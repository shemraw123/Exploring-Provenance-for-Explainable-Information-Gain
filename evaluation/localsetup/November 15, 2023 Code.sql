-- input query (assume that left-side relation is owned and right-side relation is shared)
-- SELECT o.county, o.year, CASE WHEN (s.maqi > 100 AND (s.gdays IS NOT NULL)) THEN s.gdays ELSE o.dayswaqi END AS dayswaqi, s.gdays, o.maqi 
-- FROM owned o FULL OUTER JOIN shared s ON (o.county = s.county AND o.year = s.year);


-- rewritten query that computes IG and its explanation
With queryOwnedConvertStrings AS(
SELECT county, ascii(unnest(string_to_array(county,null))) as converted, year, dayswaqi, maqi
FROM owned /* change here */
--WHERE county IN ('Madison', 'Russell', 'Sumter')
-- GROUP BY county, year, dayswaqi, maqi
),

queryOwnedConversion AS(
SELECT county, sum(a.converted), CAST(sum(a.converted) AS bit(10)) as bitsascii,
       year, CAST(CAST(year AS INTEGER) AS bit(10)) AS yearbit,
       dayswaqi, CAST(CAST(dayswaqi AS INTEGER) AS bit(10)) AS dayswaqibit,
       maqi, CAST(CAST(maqi AS INTEGER) AS bit(10)) AS maqibit
FROM queryOwnedConvertStrings a
GROUP BY county, year, dayswaqi, maqi),


-- queryOwnedAnnotated AS(
-- SELECT --CAST(bitsascii as varchar) || 'c' || yearbit || 'y' as hashanno, 
--     * , 'o' || CAST(bitsascii as varchar) || 'c' || yearbit || 'y' || dayswaqibit || 'd' || maqibit || 'm' AS anno 
-- FROM queryOwnedConversion
-- ),


querySharedConvertStrings AS(
SELECT county, ascii(unnest(string_to_array(county,null))) as converted, year, gdays, maqi
FROM shared /* change here */
--WHERE county IN ('Madison', 'Russell', 'Sumter')
GROUP BY county, year,gdays, maqi
),


querySharedConversion AS(
SELECT county, sum(a.converted), CAST(sum(a.converted) AS bit(10)) as bitsascii,
       year, CAST(CAST(year AS INTEGER) AS bit(10)) AS yearbit,
       gdays, CAST(CAST(gdays AS INTEGER) AS bit(10)) AS gdaysbit,
       maqi, CAST(CAST(maqi AS INTEGER) AS bit(10)) AS maqibit
FROM querySharedConvertStrings a
GROUP BY county, year,gdays, maqi),


-- querySharedAnnotated AS(
-- SELECT --CAST(bitsascii as varchar) || 'c' || yearbit || 'y' as hashanno, 
--     * , 's' || CAST(bitsascii as varchar) || 'c' || yearbit || 'y' || gdaysbit || 'g' || maqibit || 'm' AS anno 
-- FROM querySharedConversion
-- ),


queryIntegration AS(
    SELECT 
--		   o.county as o_county, o.year as o_year, o.dayswaqi as o_dayswaqi, o.maqi as o_maqi,
-- 		   s.county as s_county, s.year as s_year, s.gdays as s_gdays, s.maqi as s_maqi,
-- 		   o.anno AS annoi_O, s.anno AS annoi_S, 	
	-- Transformation Part to clean the tables
	   CASE WHEN (o.county = s.county) THEN o.county
	   		WHEN (o.county IS NULL) THEN s.county
			WHEN (s.county IS NULL) THEN o.county
			WHEN (o.county IS NULL AND s.county IS NULL) THEN NULL
			END AS i_county,
	   CASE WHEN (o.year = s.year) THEN o.year
	   		WHEN (o.year IS NULL) THEN s.year
			WHEN (s.year IS NULL) THEN o.year
			WHEN (o.year IS NULL AND s.year IS NULL) THEN NULL
			END AS i_year,
       COALESCE(CASE WHEN (s.maqi > 100 AND (s.gdays IS NOT NULL)) THEN s.gdays ELSE o.dayswaqi END,0) AS i_dayswaqi,
--         o.dayswaqi as i_dayswaqi, 
       COALESCE(s.gdays,0) AS i_gdays, --o.maqi AS i_maqi, --s.maqi,
	   CASE WHEN (o.maqi = s.maqi) THEN o.maqi
	   		WHEN (o.maqi IS NULL) THEN s.maqi
			WHEN (s.maqi IS NULL) THEN o.maqi
			WHEN (o.maqi IS NULL AND s.maqi IS NULL) THEN NULL
            ELSE o.maqi
			END AS i_maqi,
	-- Transform ends here
        CASE WHEN (o.bitsascii IS NULL) THEN s.bitsascii ELSE o.bitsascii END AS ibitascii,
        CASE WHEN (o.bitsascii IS NULL) THEN CAST(0 AS bit(10)) ELSE o.bitsascii END AS obitascii,
        CASE WHEN (s.bitsascii IS NULL) THEN o.bitsascii ELSE s.bitsascii END AS sbitascii,
        CASE WHEN (o.yearbit IS NULL) THEN s.yearbit ELSE o.yearbit END AS iyearbit,
        CASE WHEN (o.yearbit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.yearbit END AS oyearbit,
        CASE WHEN (s.yearbit IS NULL) THEN o.yearbit ELSE s.yearbit END AS syearbit,
        CASE 
             WHEN (s.maqi > 100 AND (s.gdaysbit IS NOT NULL)) THEN s.gdaysbit 
--              WHEN (s.maqi > 100 AND o.dayswaqibit IS NULL) THEN s.gdaysbit
--              WHEN (s.maqi <= 100 AND o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) 
             ELSE o.dayswaqibit END AS idayswaqibit, 
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS odayswaqibit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS igdaysbit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS sgdaysbit,
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS imaqibit, 
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS omaqibit, -- need to keep the value of owner's data in an additional attribute if it is a common column
        CASE WHEN (s.maqibit IS NULL) THEN o.maqibit ELSE s.maqibit END AS smaqibit
    FROM querySharedConversion s
    FULL OUTER JOIN queryOwnedConversion o
    ON (s.county = o.county AND s.year = o.year)  /* where o.county = 'Colbert' */
),

hamming as (
SELECT *,
    CASE WHEN ibitascii = obitascii THEN '0' ELSE hammingDist(CAST(obitascii AS text),CAST(ibitascii AS text)) END AS hammingdistcounty, 
    CASE WHEN iyearbit = oyearbit THEN '0' ELSE hammingDist(iyearbit::text,oyearbit::text) END AS hammingdistYear,
--    CASE WHEN idayswaqibit = odayswaqibit THEN '0' ELSE hammingDist(idayswaqibit::text,odayswaqibit::text) END AS hammingdistdayswaqi,
-- 	hammingDist(idayswaqibit::text, '0000000000') AS hammingdistdayswaqi,
--     hammingDist(igdaysbit::text, '0000000000') AS hammingdistDaysGdays,
    CASE WHEN idayswaqibit = odayswaqibit THEN '0' ELSE hammingDist(idayswaqibit::text,odayswaqibit::text) END AS hammingdistdayswaqi,
    CASE WHEN igdaysbit = sgdaysbit THEN '0' ELSE hammingDist(igdaysbit::text,sgdaysbit::text) END AS hammingdistDaysGdays,
    CASE WHEN imaqibit = omaqibit THEN '0' ELSE hammingDist(omaqibit::text,imaqibit::text) END AS hammingdistMaqi
--     CAST(igdaysbit AS INT) AS hammingdistDaysGdays -- shared new values
FROM queryIntegration
    
),

/*
computeIG AS(
SELECT *,
	hammingdistvalue(hammingdistcounty) AS countydist,
	hammingdistvalue(hammingdistYear) AS yeardist,
	hammingdistvalue(hammingdistMaqi) AS maquidist,
	hammingdistvalue(hammingdistdayswaqi) AS dayswaqidist,
	hammingdistvalue(hammingdistDaysGdays) AS gdaysdist
FROM hamming
),
*/

hammingValue as (
    SELECT *,
	   hammingdistvalue(hammingdistcounty::text) as IG_County,
	   hammingdistvalue(hammingdistYear::text) as IG_Year,
	   hammingdistvalue(hammingdistdayswaqi::text) as IG_DaysWaqi,
	   hammingdistvalue(hammingdistDaysGdays::text) as IG_Gdays,
   	   hammingdistvalue(hammingdistMaqi::text) as IG_Maqi
	FROM hamming
)

-- select * from hammingValue;
,

rowIG as(
    select *,
	(IG_County + IG_Year + IG_Maqi + IG_DaysWaqi + IG_Gdays) as Total_IG_rows
--	(hammingValueCounty + hammingValueYear + hammingValueMaqi + hammingValuedayswaqi + hammingValuegdays)/5 as avgDist
	from hammingValue
),

patterns1 as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi,
	   SUM(Total_IG_rows) as patternIG, COUNT(*) as coverage,
       (CASE WHEN (i_county IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_year IS NOT NULL) THEN 1 ELSE 0 END +
        CASE WHEN (i_dayswaqi IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_gdays IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_maqi IS NOT NULL) THEN 1 ELSE 0 END) as informativeness
	FROM rowIG
	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)
),

-- clean up patterns
-- TODO: pruning more aggressively
removeNoGoodPatt AS (
--     SELECT * 
--     FROM patterns1
--     WHERE coverage > 1
--     UNION ALL
--     SELECT *
--     FROM patterns1
--     WHERE (coverage = 1 AND informativeness = 5)
    SELECT * 
    FROM patterns1
    WHERE coverage > 1 OR (coverage = 1 AND informativeness = 5)
),

-- patternsWithPlaceholders AS (
--     SELECT * 
--     FROM removeNoGoodPatt
--     WHERE informativeness < 5 -- the calculation of maximum number of attributes can be outsourced using metadata in database.
-- ),

-- patternsWithoutPlaceholders AS (
--     SELECT *
--     FROM removeNoGoodPatt
--     WHERE informativeness = 5 -- the calculation of maximum number of attributes can be outsourced using metadata in database.
-- ),

getData AS (
    SELECT DISTINCT l.i_county, l.i_year, l.i_dayswaqi, l.i_gdays, l.i_maqi, 
--         r.i_county, r.i_year, r.i_dayswaqi, r.i_gdays, r.i_maqi, 
        l.patternig, l.coverage, l.informativeness, 
        r.ig_county, r.ig_year, r.ig_dayswaqi, r.ig_gdays, r.ig_maqi, 
        r.total_ig_rows
    FROM removeNoGoodPatt l, rowIG r
    WHERE ((l.i_county IS NULL OR l.i_county = r.i_county) AND (l.i_year IS NULL OR l.i_year = r.i_year) AND
            (l.i_dayswaqi IS NULL OR l.i_dayswaqi = r.i_dayswaqi) AND (l.i_gdays IS NULL OR l.i_gdays = r.i_gdays) AND
            (l.i_maqi IS NULL OR l.i_maqi = r.i_maqi))
--     UNION ALL
--     SELECT l.i_county, l.i_year, l.i_dayswaqi, l.i_gdays, l.i_maqi, 
-- --         r.i_county, r.i_year, r.i_dayswaqi, r.i_gdays, r.i_maqi, 
--         l.patternig, l.coverage, l.informativeness, 
--         r.ig_county, r.ig_year, r.ig_dayswaqi, r.ig_gdays, r.ig_maqi, r.total_ig_rows
--     FROM patternsWithoutPlaceholders l, rowIG r
--     WHERE l.i_county = r.i_county AND l.i_year = r.i_year AND l.i_dayswaqi = r.i_dayswaqi AND l.i_gdays = r.i_gdays AND l.i_maqi = r.i_maqi
)
-- SELECT * FROM getData
-- WHERE gdays = 226;
,

-- analysis on full table
analysisCorrelation as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness,
        COALESCE(regr_r2(total_ig_rows, ig_county),0) as county_r2,
        COALESCE(regr_r2(total_ig_rows, ig_year),0) as year_r2,
        COALESCE(regr_r2(total_ig_rows, ig_dayswaqi),0) AS dayswaqi_r2,
        COALESCE(regr_r2(total_ig_rows, ig_gdays),0) AS gdays_r2,
        COALESCE(regr_r2(total_ig_rows, ig_maqi),0) AS maqi_r2
	FROM getData
    GROUP BY i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness
),

-- computing mean of r2
meanSquare AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
           county_r2, year_r2, dayswaqi_r2, gdays_r2, maqi_r2, ((county_r2 + year_r2 + dayswaqi_r2 + gdays_r2 + maqi_r2) / 5) AS meanr2
--         CASE WHEN ((dayswaqi_r2 + gdays_r2 + maqi_r2) <> 0) 
--             THEN (3 * (dayswaqi_r2 * gdays_r2 * maqi_r2) / (dayswaqi_r2 + gdays_r2 + maqi_r2)) 
--             ELSE 0 END AS meanR2
    FROM analysisCorrelation
),

-- computing fscore
fscore AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
            county_r2, year_r2, dayswaqi_r2, gdays_r2, maqi_r2, meanR2, 
--             (3 * (patternIG * informativeness * meanR2) / (patternIG + informativeness + meanR2)) AS fscore
            (4 * (patternIG * coverage * informativeness * meanR2) / (patternIG + coverage + informativeness + meanR2)) AS fscore
    FROM meanSquare
)

SELECT * FROM fscore
ORDER BY fscore DESC;

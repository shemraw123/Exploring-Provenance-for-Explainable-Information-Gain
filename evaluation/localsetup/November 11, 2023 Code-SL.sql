
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
--			IF EXISTS (SELECT s_sayswaqi from TotalIG) 
--			BEGIN select s_sayswaqi END ELSE BEGIN o_sayswaqi END as i_sayswaqi
	   		o.dayswaqi as i_dayswaqi, s.gdays as i_gdays,
	   CASE WHEN (o.maqi = s.maqi) THEN o.maqi
	   		WHEN (o.maqi IS NULL) THEN s.maqi
			WHEN (s.maqi IS NULL) THEN o.maqi
			WHEN (o.maqi IS NULL AND s.maqi IS NULL) THEN NULL
			END AS i_maqi,
	-- Transform ends here
        CASE WHEN (o.bitsascii IS NULL) THEN s.bitsascii ELSE o.bitsascii END AS ibitascii,
        CASE WHEN (o.bitsascii IS NULL) THEN CAST(0 AS bit(10)) ELSE o.bitsascii END AS obitascii,
        CASE WHEN (s.bitsascii IS NULL) THEN o.bitsascii ELSE s.bitsascii END AS sbitascii,
        CASE WHEN (o.yearbit IS NULL) THEN s.yearbit ELSE o.yearbit END AS iyearbit,
        CASE WHEN (o.yearbit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.yearbit END AS oyearbit,
        CASE WHEN (s.yearbit IS NULL) THEN o.yearbit ELSE s.yearbit END AS syearbit,
        CASE WHEN (o.maqi > 100 AND (s.gdaysbit IS NOT NULL)) THEN s.gdaysbit 
             WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS imaqibit, 
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS omaqibit, -- need to keep the value of owner's data in an additional attribute if it is a common column
        CASE WHEN (s.maqibit IS NULL) THEN o.maqibit ELSE s.maqibit END AS smaqibit,
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS idayswaqibit,
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS odayswaqibit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS igdaysbit
        -- CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS sgdaysbit
    FROM querySharedConversion s
    FULL OUTER JOIN queryOwnedConversion o
    ON (s.county = o.county AND s.year = o.year)  /* where o.county = 'Colbert' */
)

select * from queryIntegration
where i_county = 'Baldwin'
,

hamming as (
SELECT *,
    CASE WHEN ibitascii = obitascii THEN '0' ELSE hammingDist(CAST(obitascii AS text),CAST(ibitascii AS text)) END AS hammingdistcounty, 
    CASE WHEN iyearbit = oyearbit THEN '0' ELSE hammingDist(iyearbit::text,oyearbit::text) END AS hammingdistYear,
    CASE WHEN imaqibit = omaqibit THEN '0' ELSE hammingDist(omaqibit::text,imaqibit::text) END AS hammingdistMaqi,
--    CASE WHEN idayswaqibit = odayswaqibit THEN '0' ELSE hammingDist(idayswaqibit::text,odayswaqibit::text) END AS hammingdistdayswaqi,
	hammingDist(idayswaqibit::text, '0000000000') AS hammingdistdayswaqi,
    hammingDist(igdaysbit::text, '0000000000') AS hammingdistDaysGdays
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
Select *,
	   hammingdistvalue(hammingdistcounty::text) as IG_County,
	   hammingdistvalue(hammingdistYear::text) as IG_Year,
	   hammingdistvalue(hammingdistMaqi::text) as IG_Maqi,
	   hammingdistvalue(hammingdistdayswaqi::text) as IG_DaysWaqi,
	   hammingdistvalue(hammingdistDaysGdays::text) as IG_Gdays
	from hamming
),

rowIG as(
    select *,
	(IG_County + IG_Year + IG_Maqi + IG_DaysWaqi + IG_Gdays) as Total_IG_rows
--	(hammingValueCounty + hammingValueYear + hammingValueMaqi + hammingValuedayswaqi + hammingValuegdays)/5 as avgDist
	from hammingValue
)

-- select * from rowIG
-- where i_county = 'Morgan'
,
/*
transformData as(
select o_county, s_county, o_year, s_year,
	   o_dayswaqi, s_gdays, o_maqi, s_maqi,
	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays, Total_IG,
	   CASE WHEN (o_county = s_county) THEN o_county
	   		WHEN (o_county IS NULL) THEN s_county
			WHEN (s_county IS NULL) THEN o_county
			WHEN (o_county IS NULL AND s_county IS NULL) THEN NULL
			END AS i_county,
	   CASE WHEN (o_year = s_year) THEN o_year
	   		WHEN (o_year IS NULL) THEN s_year
			WHEN (s_year IS NULL) THEN o_year
			WHEN (o_year IS NULL AND s_year IS NULL) THEN NULL
			END AS i_year,
--			IF EXISTS (SELECT s_sayswaqi from TotalIG) 
--			BEGIN select s_sayswaqi END ELSE BEGIN o_sayswaqi END as i_sayswaqi
	   		o_dayswaqi as i_dayswaqi, s_gdays as i_gdays,
	   CASE WHEN (o_maqi = s_maqi) THEN o_maqi
	   		WHEN (o_maqi IS NULL) THEN s_maqi
			WHEN (s_maqi IS NULL) THEN o_maqi
			WHEN (o_maqi IS NULL AND s_maqi IS NULL) THEN NULL
			END AS i_maqi
	

	from TotalIG
	--group by cube (o.county, o.year, o.maqi, );
),
*/
-- cleanData as(
-- select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 	   Total_IG_rows
--     --, (SELECT SUM(total_IG_rows) FROM rowIG) AS total_IG
-- 	from rowIG

-- ),

-- patterns as(
-- 	select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- --	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- --	   Total_IG, 
-- 	   sum(IG_County) as sum_County, sum(IG_Year) as sum_Year,
-- 	   sum(IG_Maqi) as sum_Maqi, sum(IG_DaysWaqi) as sum_DaysWaqi,
-- 	   sum(IG_Gdays) as sum_Gdays, sum(Total_IG) as sum_IG
-- 	FROM cleanData
-- 	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)
-- ),

patterns1 as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi,
-- 	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 	   Total_IG, 
-- 	   sum(IG_County) as sum_County, sum(IG_Year) as sum_Year,
-- 	   sum(IG_Maqi) as sum_Maqi, sum(IG_DaysWaqi) as sum_DaysWaqi,
-- 	   sum(IG_Gdays) as sum_Gdays, 
	   SUM(Total_IG_rows) as patternIG,
       COUNT(i_year) as coverage,
       (CASE WHEN (i_county IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_year IS NOT NULL) THEN 1 ELSE 0 END +
        CASE WHEN (i_dayswaqi IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_gdays IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_maqi IS NOT NULL) THEN 1 ELSE 0 END) as informativeness
--        SUM(IG_county) AS totalIG_county, SUM(IG_year) AS totalIG_year, 
--        SUM(IG_dayswaqi) AS totalIG_dayswaqi, SUM(IG_gdays) AS totalIG_gdays,
--        SUM(IG_maqi) AS totalIG_maqi 
--     , MAX(total_IG) AS total_IG
	FROM rowIG
	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)
),


getData AS (
    SELECT DISTINCT l.i_county, l.i_year, l.i_dayswaqi, l.i_gdays, l.i_maqi, l.patternig, l.coverage, l.informativeness, 
        r.ig_county, r.ig_year, r.ig_dayswaqi, r.ig_gdays, r.ig_maqi, r.total_ig_rows
    FROM patterns1 l, rowIG r
    WHERE (l.i_county IS NOT NULL AND l.i_county = r.i_county) OR (l.i_year IS NOT NULL AND l.i_year = r.i_year) OR
        (l.i_dayswaqi IS NOT NULL AND l.i_dayswaqi = r.i_dayswaqi) OR (l.i_gdays IS NOT NULL AND l.i_gdays = r.i_gdays) OR
        (l.i_maqi IS NOT NULL AND l.i_maqi = r.i_maqi)
)

-- select * from getData where i_gdays = 162 AND i_county is null and i_year is null
,
-- i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 	   Total_IG

-- Extracting a pattern
-- samplePattern as(
-- select *,
-- 	CASE WHEN (i_county IS NULL AND i_year IS NULL) THEN 'Select * from cleanData' 
-- 		 WHEN (i_county IS NULL AND i_year IS NOT NULL) THEN 'Select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON c.i_year = p.i_year'
-- 		 WHEN (i_county IS NOT NULL AND i_year IS NULL) THEN 'Select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON c.i_county = p.i_county' 
-- 	     WHEN (i_county IS NOT NULL AND i_year IS NOT NULL) THEN 'Select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON (c.i_county = p.i_county AND c.i_year = p.i_year)' 
-- 		 END AS pattern
-- 	from patterns1 
-- ),

-- Pattern as(
-- 	select pattern
-- 	from samplePattern
-- ),

-- Pattern1 as(
-- Select c.i_county, c.i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON (c.i_county = p.i_county AND c.i_year = p.i_year)

-- ),

-- Pattern2 as(
-- Select * from cleanData

-- ),

-- Pattern3 as(
-- Select c.i_county, c.i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON c.i_year = p.i_year

-- ),

-- Pattern4 as(
-- Select c.i_county, c.i_year, i_dayswaqi, i_gdays, i_maqi, 
-- 		   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
-- 		   Total_IG from cleanData c JOIN patterns1 p ON c.i_county = p.i_county

-- ),

-- analysis on a pattern

-- analysis on full table
analysisCorrelation as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
--         regr_r2(total_ig_rows, ig_county) as county_corr,
--         regr_r2(total_ig_rows, ig_year) as year_corr,
        coalesce(regr_r2(total_ig_rows, ig_dayswaqi),0) as dayswaqi_r2,
        coalesce(regr_r2(total_ig_rows, ig_gdays),0) as gdays_r2,
        coalesce(regr_r2(total_ig_rows, ig_maqi),0) as maqi_r2
	FROM getData
    GROUP BY i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness
),

-- Example of computing fscore
-- TODO: How to combine the metrics
meanSquare AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
--         COALESCE(county_corr,0) AS county_corr, COALESCE(year_corr,0) AS year_corr, 
--         COALESCE(dayswaqi_corr,0) AS dayswaqi_corr, COALESCE(gdays_corr,0) AS gdays_corr, COALESCE(maqi_corr,0) AS maqi_corr, 
         dayswaqi_r2, gdays_r2, maqi_r2, 
        CASE WHEN ((dayswaqi_r2 + gdays_r2 + maqi_r2) <> 0) 
            THEN (3 * (dayswaqi_r2 * gdays_r2 * maqi_r2) / (dayswaqi_r2 + gdays_r2 + maqi_r2)) 
            ELSE 0 END AS meanR2
    FROM analysisCorrelation
),

fscore AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
            dayswaqi_r2, gdays_r2, maqi_r2, meanR2, 
            (4 * (patternIG * coverage * informativeness * meanR2) / (patternIG + coverage + informativeness + meanR2)) AS fscore
    FROM meanSquare
)


-- sumcolumns as(
-- Select sum(hammingValueCounty) as sumCounty, sum(hammingValueYear) as sumYear, sum(hammingValueMaqi) as sumMaqi,
-- 	   sum(hammingValuedayswaqi) as sumsayswaqi, sum(hammingValuegdays) as sumgdays,
	
-- 	   min(hammingValueCounty) as mincounty, max(hammingValueCounty) as maxcounty,
	
-- 	   count(hammingValueCounty) as CountCounty, count(hammingValueYear) as CountYear, count(hammingValueMaqi) as CountMaqi,
-- 	   count(hammingValuedayswaqi) as Countsayswaqi, count(hammingValuegdays) as Countgdays,
	
-- 	   avg(hammingValueCounty) as avgCounty,
-- 	   avg(hammingValueYear) as avgYear, avg(hammingValueMaqi) as avgMaqi,
-- 	   avg(hammingValuedayswaqi) as avgsayswaqi, avg(hammingValuegdays) as avggdays
		
-- 	from hammingValue
-- )


SELECT * FROM getData;


fscore
ORDER BY fscore DESC;

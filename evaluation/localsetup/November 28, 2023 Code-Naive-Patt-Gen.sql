-- rewritten query that computes IG and its explanation
With queryOwnedConvertStrings AS(
SELECT county, ascii(unnest(string_to_array(county,null))) as converted, year, dayswaqi, maqi
FROM owned),

queryOwnedConversion AS(
SELECT county, sum(a.converted), CAST(sum(a.converted) AS bit(10)) as bitsascii,
       year, CAST(CAST(year AS INTEGER) AS bit(10)) AS yearbit,
       dayswaqi, CAST(CAST(dayswaqi AS INTEGER) AS bit(10)) AS dayswaqibit,
       maqi, CAST(CAST(maqi AS INTEGER) AS bit(10)) AS maqibit
FROM queryOwnedConvertStrings a
--GROUP BY county, year, dayswaqi, maqi
),

querySharedConvertStrings AS(
SELECT county, ascii(unnest(string_to_array(county,null))) as converted, year, gdays, maqi
FROM shared
GROUP BY county, year,gdays, maqi),

querySharedConversion AS(
SELECT county, sum(a.converted), CAST(sum(a.converted) AS bit(10)) as bitsascii,
       year, CAST(CAST(year AS INTEGER) AS bit(10)) AS yearbit,
       gdays, CAST(CAST(gdays AS INTEGER) AS bit(10)) AS gdaysbit,
       maqi, CAST(CAST(maqi AS INTEGER) AS bit(10)) AS maqibit
FROM querySharedConvertStrings a
GROUP BY county, year,gdays, maqi),

queryIntegration AS(
    SELECT  	
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
       COALESCE(s.gdays,0) AS i_gdays,
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
        CASE WHEN (s.maqi > 100 AND (s.gdaysbit IS NOT NULL)) THEN s.gdaysbit 
             ELSE o.dayswaqibit END AS idayswaqibit, 
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS odayswaqibit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS igdaysbit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS sgdaysbit,
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS imaqibit, 
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS omaqibit, -- need to keep the value of owner's data in an additional attribute if it is a common column
        CASE WHEN (s.maqibit IS NULL) THEN o.maqibit ELSE s.maqibit END AS smaqibit
    FROM querySharedConversion s
    FULL OUTER JOIN queryOwnedConversion o
    ON (s.county = o.county AND s.year = o.year)),

hamming as (
SELECT *,
    CASE WHEN ibitascii = obitascii THEN '0' ELSE hammingDist(CAST(obitascii AS text),CAST(ibitascii AS text)) END AS hammingdistcounty, 
    CASE WHEN iyearbit = oyearbit THEN '0' ELSE hammingDist(iyearbit::text,oyearbit::text) END AS hammingdistYear,
    CASE WHEN idayswaqibit = odayswaqibit THEN '0' ELSE hammingDist(idayswaqibit::text,odayswaqibit::text) END AS hammingdistdayswaqi,
    CASE WHEN igdaysbit = sgdaysbit THEN '0' ELSE hammingDist(igdaysbit::text,sgdaysbit::text) END AS hammingdistDaysGdays,
    CASE WHEN imaqibit = omaqibit THEN '0' ELSE hammingDist(omaqibit::text,imaqibit::text) END AS hammingdistMaqi
FROM queryIntegration),

hammingValue as (
    SELECT *,
	   hammingdistvalue(hammingdistcounty::text) as IG_County,
	   hammingdistvalue(hammingdistYear::text) as IG_Year,
	   hammingdistvalue(hammingdistdayswaqi::text) as IG_DaysWaqi,
	   hammingdistvalue(hammingdistDaysGdays::text) as IG_Gdays,
   	   hammingdistvalue(hammingdistMaqi::text) as IG_Maqi
	FROM hamming),

rowIG as(
    select *,
	(IG_County + IG_Year + IG_Maqi + IG_DaysWaqi + IG_Gdays) as Total_IG_rows
	from hammingValue),

patterns1 as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi,
	   SUM(Total_IG_rows) as patternIG, COUNT(*) as coverage,
       (CASE WHEN (i_county IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_year IS NOT NULL) THEN 1 ELSE 0 END +
        CASE WHEN (i_dayswaqi IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_gdays IS NOT NULL) THEN 1 ELSE 0 END + 
        CASE WHEN (i_maqi IS NOT NULL) THEN 1 ELSE 0 END) as informativeness
	FROM rowIG
	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)),

-- clean up patterns
-- TODO: pruning more aggressively
removeNoGoodPatt AS (
    SELECT *
    FROM patterns1
    WHERE coverage > 1 OR (coverage = 1 AND informativeness = 5)),

-- cleaning up patterns more where k = 3
-- patterns with coverage = 1 and informativeness = 5
topK1 AS (
    SELECT *
    FROM patterns1
    WHERE coverage = 1 AND informativeness = 5), -- 1 here is minimum coverage and 5 is the maximum informativeness

-- patterns with coverage > 1 and informativeness < 5
topK2 AS (
    SELECT *
    FROM patterns1
    WHERE coverage > 1 AND informativeness < 5), -- 1 here is minimum coverage and 5 is the maximum informativeness

-- this calculates fscore for topK1 patterns
fscoreTopK1 AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness,
		(3 * (patternIG * coverage * informativeness) / (patternIG + coverage + informativeness)) AS fscoreTopK
    FROM topK1
	ORDER BY fscoreTopK DESC
	LIMIT 10),

-- this calculates fscore for topK1 patterns
fscoreTopK2 AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness,
		(3 * (patternIG * coverage * informativeness) / (patternIG + coverage + informativeness)) AS fscoreTopK
    FROM topK2
	ORDER BY fscoreTopK DESC
	LIMIT 10),
	
-- displaying all patterns
topK AS (
    SELECT *
    FROM fscoreTopK1
	UNION ALL 
	SELECT *
	FROM fscoreTopK2
	ORDER BY fscoreTopK DESC),
	
-- -- this calculateds fscore for patterns without considering meanR2
-- fscoreNoR2 AS (
--     SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness,
-- 		(3 * (patternIG * coverage * informativeness) / (patternIG + coverage + informativeness)) AS fscoreNoR2
--     FROM removeNoGoodPatt),

-- -- using ratios here
-- fscoreRatioInf AS (
--     SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, (informativeness/5) as infRatio,
-- 		(3 * (patternIG * coverage * (informativeness/5)) / (patternIG + coverage + (informativeness/5))) AS fscoreRatio
--     FROM removeNoGoodPatt),

getData AS (
    SELECT DISTINCT l.i_county, l.i_year, l.i_dayswaqi, l.i_gdays, l.i_maqi, 
        l.patternig, l.coverage, l.informativeness, 
        r.ig_county, r.ig_year, r.ig_dayswaqi, r.ig_gdays, r.ig_maqi, 
        r.total_ig_rows
    FROM removeNoGoodPatt l, rowIG r
    WHERE ((l.i_county IS NULL OR l.i_county = r.i_county) AND (l.i_year IS NULL OR l.i_year = r.i_year) AND
            (l.i_dayswaqi IS NULL OR l.i_dayswaqi = r.i_dayswaqi) AND (l.i_gdays IS NULL OR l.i_gdays = r.i_gdays) AND
            (l.i_maqi IS NULL OR l.i_maqi = r.i_maqi))),

-- analysis on full table
analysisCorrelation as(
	SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness,
        COALESCE(regr_r2(total_ig_rows, ig_county),0) as county_r2,
        COALESCE(regr_r2(total_ig_rows, ig_year),0) as year_r2,
        COALESCE(regr_r2(total_ig_rows, ig_dayswaqi),0) AS dayswaqi_r2,
        COALESCE(regr_r2(total_ig_rows, ig_gdays),0) AS gdays_r2,
        COALESCE(regr_r2(total_ig_rows, ig_maqi),0) AS maqi_r2
	FROM getData
    GROUP BY i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness),

-- computing mean of r2
meanSquare AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
           county_r2, year_r2, dayswaqi_r2, gdays_r2, maqi_r2, ((county_r2 + year_r2 + dayswaqi_r2 + gdays_r2 + maqi_r2) / 5) AS meanr2
    FROM analysisCorrelation),

-- computing fscore
fscore AS (
    SELECT i_county, i_year, i_dayswaqi, i_gdays, i_maqi, patternIG, coverage, informativeness, 
            county_r2, year_r2, dayswaqi_r2, gdays_r2, maqi_r2, meanR2, 
            (4 * (patternIG * coverage * informativeness * meanR2) / (patternIG + coverage + informativeness + meanR2)) AS fscore
    FROM meanSquare)


SELECT * 
FROM (SELECT * FROM fscore ORDER BY fscore DESC)
LIMIT 10

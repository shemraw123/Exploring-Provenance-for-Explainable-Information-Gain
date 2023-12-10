-- November 10, 2023

-- input query
SELECT o.county, o.year, s.gdays, o.maqi, 
    -- CASE WHEN (s.maqi > 100 AND (s.gdays IS NOT NULL)) THEN s.gdays ELSE o.dayswaqi END AS dayswaqi
    o.dayswaqi
FROM owned o JOIN shared s ON (o.county = s.county AND o.year = s.year);


-- rewritten query
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


queryOwnedAnnotated AS(
SELECT --CAST(bitsascii as varchar) || 'c' || yearbit || 'y' as hashanno, 
    * , 'o' || CAST(bitsascii as varchar) || 'c' || yearbit || 'y' || dayswaqibit || 'd' || maqibit || 'm' AS anno 
FROM queryOwnedConversion
),


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


querySharedAnnotated AS(
SELECT --CAST(bitsascii as varchar) || 'c' || yearbit || 'y' as hashanno, 
    * , 's' || CAST(bitsascii as varchar) || 'c' || yearbit || 'y' || gdaysbit || 'g' || maqibit || 'm' AS anno 
FROM querySharedConversion
),


queryIntegration AS(
    SELECT o.county as o_county, o.year as o_year, o.dayswaqi as o_dayswaqi, o.maqi as o_maqi,
		   s.county as s_county, s.year as s_year, s.gdays as s_gdays, s.maqi as s_maqi,
		   o.anno AS annoi_O, 
           s.anno AS annoi_S, 
--		   o.hashanno as hashanno_O, s.hashanno as hashanno_S,
--         o.county AS ocounty,
--         s.county AS scounty,
        CASE WHEN (o.bitsascii IS NULL) THEN s.bitsascii ELSE o.bitsascii END AS ibitascii,
        CASE WHEN (o.bitsascii IS NULL) THEN CAST(0 AS bit(10)) ELSE o.bitsascii END AS obitascii,
        CASE WHEN (s.bitsascii IS NULL) THEN o.bitsascii ELSE s.bitsascii END AS sbitascii,
        CASE WHEN (o.yearbit IS NULL) THEN s.yearbit ELSE o.yearbit END AS iyearbit,
        CASE WHEN (o.yearbit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.yearbit END AS oyearbit,
        CASE WHEN (s.yearbit IS NULL) THEN o.yearbit ELSE s.yearbit END AS syearbit,
        -- CASE WHEN (o.dayswaqi > 100 AND (s.maqibit IS NOT NULL)) THEN s.maqibit 
        --      WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS imaqibit,
        CASE WHEN (o.maqibit IS NULL) THEN s.maqibit ELSE o.maqibit END AS imaqibit, 
        CASE WHEN (o.maqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.maqibit END AS omaqibit, -- need to keep the value of owner's data in an additional attribute if it is a common column
        CASE WHEN (s.maqibit IS NULL) THEN o.maqibit ELSE s.maqibit END AS smaqibit,
        -- CASE WHEN (s.maqi > 100 AND (s.gdaysbit IS NOT NULL)) THEN s.gdaysbit 
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS idayswaqibit,
        CASE WHEN (o.dayswaqibit IS NULL) THEN CAST(0 AS bit(10)) ELSE o.dayswaqibit END AS odayswaqibit,
        CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS igdaysbit
        -- CASE WHEN (s.gdaysbit IS NULL) THEN CAST(0 AS bit(10)) ELSE s.gdaysbit END AS sgdaysbit
    FROM querySharedAnnotated s
    FULL OUTER JOIN queryOwnedAnnotated o
    ON (s.county = o.county AND s.year = o.year)  /* where o.county = 'Colbert' */
),

hamming as (
SELECT *,
    CASE WHEN ibitascii = obitascii THEN '0' ELSE hammingDist(CAST(obitascii AS text),CAST(ibitascii AS text)) END AS hammingdistcounty, 
    CASE WHEN iyearbit = oyearbit THEN '0' ELSE hammingDist(iyearbit::text,oyearbit::text) END AS hammingdistYear,
    CASE WHEN imaqibit = omaqibit THEN '0' ELSE hammingDist(omaqibit::text,imaqibit::text) END AS hammingdistMaqi,
    CASE WHEN idayswaqibit = odayswaqibit THEN '0' ELSE hammingDist(idayswaqibit::text,odayswaqibit::text) END AS hammingdistdayswaqi,
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

TotalIG as(
select *,
	(IG_County + IG_Year + IG_Maqi + IG_DaysWaqi + IG_Gdays) as Total_IG
--	(hammingValueCounty + hammingValueYear + hammingValueMaqi + hammingValuedayswaqi + hammingValuegdays)/5 as avgDist
	from hammingValue
),

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

cleanData as(
select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
	   Total_IG
	from transformData

),

patterns as(
	select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
--	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
--	   Total_IG, 
	   sum(IG_County) as sum_County, sum(IG_Year) as sum_Year,
	   sum(IG_Maqi) as sum_Maqi, sum(IG_DaysWaqi) as sum_DaysWaqi,
	   sum(IG_Gdays) as sum_Gdays, sum(Total_IG) as sum_IG
	FROM cleanData
	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)
),

patterns1 as(
	select i_county, i_year, i_dayswaqi, i_gdays, i_maqi, 
--	   IG_County, IG_Year, IG_Maqi, IG_DaysWaqi, IG_Gdays,
--	   Total_IG, 
--	   sum(IG_County) as sum_County, sum(IG_Year) as sum_Year,
--	   sum(IG_Maqi) as sum_Maqi, sum(IG_DaysWaqi) as sum_DaysWaqi,
--	   sum(IG_Gdays) as sum_Gdays, 
	   sum(Total_IG) as sum_IG
	FROM cleanData
	GROUP BY CUBE(i_county, i_year, i_dayswaqi, i_gdays, i_maqi)
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

SELECT *
FROM patterns1;

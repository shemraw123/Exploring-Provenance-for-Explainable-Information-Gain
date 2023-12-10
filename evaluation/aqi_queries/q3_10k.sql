WITH _temp_view_12 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."county" AS "ig_conv_owned10k_county", F0."year" AS "ig_conv_owned10k_year", F0."dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."maqi" AS "ig_conv_owned10k_maqi"
FROM "owned10k" AS F0),
_temp_view_11 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_owned10k_county, NULL))) AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi"
FROM (SELECT * FROM _temp_view_12) F0),
_temp_view_10 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_owned10k_county"))::int8)::bit(10) AS "ig_conv_owned10k_county", F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ((F0."ig_conv_owned10k_year")::int8)::bit(10) AS "ig_conv_owned10k_year", ((F0."ig_conv_owned10k_dayswaqi")::int8)::bit(10) AS "ig_conv_owned10k_dayswaqi", ((F0."ig_conv_owned10k_maqi")::int8)::bit(10) AS "ig_conv_owned10k_maqi"
FROM (SELECT * FROM _temp_view_11) F0
GROUP BY F0."county", F0."year", F0."dayswaqi", F0."maqi", F0."ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi"),
_temp_view_15 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."county" AS "ig_conv_shared10k_county", F0."year" AS "ig_conv_shared10k_year", F0."gdays" AS "ig_conv_shared10k_gdays", F0."maqi" AS "ig_conv_shared10k_maqi"
FROM "shared10k" AS F0),
_temp_view_14 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_shared10k_county, NULL))) AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi"
FROM (SELECT * FROM _temp_view_15) F0),
_temp_view_13 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_shared10k_county"))::int8)::bit(10) AS "ig_conv_shared10k_county", F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ((F0."ig_conv_shared10k_year")::int8)::bit(10) AS "ig_conv_shared10k_year", ((F0."ig_conv_shared10k_gdays")::int8)::bit(10) AS "ig_conv_shared10k_gdays", ((F0."ig_conv_shared10k_maqi")::int8)::bit(10) AS "ig_conv_shared10k_maqi"
FROM (SELECT * FROM _temp_view_14) F0
GROUP BY F0."county", F0."year", F0."gdays", F0."maqi", F0."ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi"),
_temp_view_9 AS (
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."owned10k_anno" AS "owned10k_anno", F1."county" AS "county1", F1."year" AS "year1", F1."gdays" AS "gdays", F1."maqi" AS "maqi1", F1."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F1."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F1."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F1."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F1."shared10k_anno" AS "shared10k_anno"
FROM ((
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", ('owned10k' || (F0."ig_conv_owned10k_county")::text || 'county' || (F0."ig_conv_owned10k_year")::text || 'year' || (F0."ig_conv_owned10k_dayswaqi")::text || 'dayswaqi' || (F0."ig_conv_owned10k_maqi")::text || 'maqi') AS "owned10k_anno"
FROM (SELECT * FROM _temp_view_10) F0) F0 JOIN (
SELECT F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", ('shared10k' || (F0."ig_conv_shared10k_county")::text || 'county' || (F0."ig_conv_shared10k_year")::text || 'year' || (F0."ig_conv_shared10k_gdays")::text || 'gdays' || (F0."ig_conv_shared10k_maqi")::text || 'maqi') AS "shared10k_anno"
FROM (SELECT * FROM _temp_view_13) F0) F1 ON ((F0."maqi" = F1."maqi")))
WHERE ((F0."dayswaqi" >= 1) AND (F0."dayswaqi" <= 5))),
_temp_view_8 AS (
SELECT /*+ materialize */ (COALESCE(F0."county1", 'na'))::text AS "county1", (COALESCE(F0."year1", 0))::int8 AS "year1", (COALESCE(F0."dayswaqi", 0))::int8 AS "dayswaqi", (COALESCE(F0."gdays", 0))::int8 AS "gdays", (CASE  WHEN (F0."maqi" = F0."maqi1") THEN F0."maqi" WHEN (F0."maqi" IS NULL) THEN F0."maqi1" WHEN (F0."maqi1" IS NULL) THEN F0."maqi" WHEN ((F0."maqi" IS NULL) AND (F0."maqi1" IS NULL)) THEN 0 ELSE F0."maqi" END) AS "maqi", (CASE  WHEN (F0."ig_conv_owned10k_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_county" END) AS "ig_conv_owned10k_county", (CASE  WHEN (F0."ig_conv_owned10k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_year" END) AS "ig_conv_owned10k_year", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_dayswaqi" END) AS "ig_conv_owned10k_dayswaqi", (CASE  WHEN (F0."ig_conv_owned10k_maqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_maqi" END) AS "ig_conv_owned10k_maqi", (CASE  WHEN (F0."ig_conv_shared10k_county" IS NULL) THEN F0."ig_conv_owned10k_county" ELSE F0."ig_conv_shared10k_county" END) AS "ig_conv_shared10k_county", (CASE  WHEN (F0."ig_conv_shared10k_year" IS NULL) THEN F0."ig_conv_owned10k_year" ELSE F0."ig_conv_shared10k_year" END) AS "ig_conv_shared10k_year", (CASE  WHEN (F0."ig_conv_shared10k_gdays" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_shared10k_gdays" END) AS "ig_conv_shared10k_gdays", (CASE  WHEN (F0."ig_conv_shared10k_maqi" IS NULL) THEN F0."ig_conv_owned10k_maqi" ELSE F0."ig_conv_shared10k_maqi" END) AS "ig_conv_shared10k_maqi", (CASE  WHEN (F0."ig_conv_owned10k_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_county" END) AS "ig_conv_owned10k_county_integ", (CASE  WHEN (F0."ig_conv_owned10k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_year" END) AS "ig_conv_owned10k_year_integ", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_dayswaqi" END) AS "ig_conv_owned10k_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared10k_gdays" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_shared10k_gdays" END) AS "ig_conv_shared10k_gdays_integ", (CASE  WHEN (F0."ig_conv_owned10k_maqi" IS NULL) THEN F0."ig_conv_shared10k_maqi" ELSE F0."ig_conv_owned10k_maqi" END) AS "ig_conv_owned10k_maqi_integ"
FROM (SELECT * FROM _temp_view_9) F0),
_temp_view_7 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", (CASE  WHEN (F0."ig_conv_owned10k_county_integ" = F0."ig_conv_owned10k_county") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_county_integ")::text, (F0."ig_conv_owned10k_county")::text) END) AS "hamming_ig_conv_owned10k_county_integ", (CASE  WHEN (F0."ig_conv_owned10k_year_integ" = F0."ig_conv_owned10k_year") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_year_integ")::text, (F0."ig_conv_owned10k_year")::text) END) AS "hamming_ig_conv_owned10k_year_integ", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi_integ" = F0."ig_conv_owned10k_dayswaqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_dayswaqi_integ")::text, (F0."ig_conv_owned10k_dayswaqi")::text) END) AS "hamming_ig_conv_owned10k_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared10k_gdays_integ" = F0."ig_conv_shared10k_gdays") THEN '0000000000' ELSE hammingdist((F0."ig_conv_shared10k_gdays_integ")::text, (F0."ig_conv_shared10k_gdays")::text) END) AS "hamming_ig_conv_shared10k_gdays_integ", (CASE  WHEN (F0."ig_conv_owned10k_maqi_integ" = F0."ig_conv_owned10k_maqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_maqi_integ")::text, (F0."ig_conv_owned10k_maqi")::text) END) AS "hamming_ig_conv_owned10k_maqi_integ"
FROM (SELECT * FROM _temp_view_8) F0),
_temp_view_6 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", F0."hamming_ig_conv_owned10k_county_integ" AS "hamming_ig_conv_owned10k_county_integ", F0."hamming_ig_conv_owned10k_year_integ" AS "hamming_ig_conv_owned10k_year_integ", F0."hamming_ig_conv_owned10k_dayswaqi_integ" AS "hamming_ig_conv_owned10k_dayswaqi_integ", F0."hamming_ig_conv_shared10k_gdays_integ" AS "hamming_ig_conv_shared10k_gdays_integ", F0."hamming_ig_conv_owned10k_maqi_integ" AS "hamming_ig_conv_owned10k_maqi_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_county_integ") AS "value_hamming_ig_conv_owned10k_county_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_year_integ") AS "value_hamming_ig_conv_owned10k_year_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_dayswaqi_integ") AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", hammingdistvalue(F0."hamming_ig_conv_shared10k_gdays_integ") AS "value_hamming_ig_conv_shared10k_gdays_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_maqi_integ") AS "value_hamming_ig_conv_owned10k_maqi_integ"
FROM (SELECT * FROM _temp_view_7) F0),
_temp_view_5 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", F0."hamming_ig_conv_owned10k_county_integ" AS "hamming_ig_conv_owned10k_county_integ", F0."hamming_ig_conv_owned10k_year_integ" AS "hamming_ig_conv_owned10k_year_integ", F0."hamming_ig_conv_owned10k_dayswaqi_integ" AS "hamming_ig_conv_owned10k_dayswaqi_integ", F0."hamming_ig_conv_shared10k_gdays_integ" AS "hamming_ig_conv_shared10k_gdays_integ", F0."hamming_ig_conv_owned10k_maqi_integ" AS "hamming_ig_conv_owned10k_maqi_integ", F0."value_hamming_ig_conv_owned10k_county_integ" AS "value_hamming_ig_conv_owned10k_county_integ", F0."value_hamming_ig_conv_owned10k_year_integ" AS "value_hamming_ig_conv_owned10k_year_integ", F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."value_hamming_ig_conv_shared10k_gdays_integ" AS "value_hamming_ig_conv_shared10k_gdays_integ", F0."value_hamming_ig_conv_owned10k_maqi_integ" AS "value_hamming_ig_conv_owned10k_maqi_integ", (F0."value_hamming_ig_conv_owned10k_county_integ" + F0."value_hamming_ig_conv_owned10k_year_integ" + F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" + F0."value_hamming_ig_conv_shared10k_gdays_integ" + F0."value_hamming_ig_conv_owned10k_maqi_integ") AS "Total_Distance", ((F0."value_hamming_ig_conv_owned10k_county_integ" + F0."value_hamming_ig_conv_owned10k_year_integ" + F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" + F0."value_hamming_ig_conv_shared10k_gdays_integ" + F0."value_hamming_ig_conv_owned10k_maqi_integ") / 5) AS "Average_Distance"
FROM (SELECT * FROM _temp_view_6) F0),
_temp_view_4 AS (
SELECT /*+ materialize */ F0."county1" AS "i_county1", F0."year1" AS "i_year1", F0."dayswaqi" AS "i_dayswaqi", F0."maqi" AS "i_maqi", F0."gdays" AS "i_gdays", SUM(F0."Total_Distance") AS "pattern_IG", ((CASE  WHEN (NOT ((F0."county1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."year1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."dayswaqi" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."maqi" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."gdays" IS NULL))) THEN 1 ELSE 0 END)) AS "informativeness", COUNT(1) AS "coverage"
FROM (SELECT * FROM _temp_view_5) F0
GROUP BY CUBE (F0."county1", F0."year1", F0."dayswaqi", F0."maqi", F0."gdays")),
_temp_view_22 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."county" AS "ig_conv_owned10k_county", F0."year" AS "ig_conv_owned10k_year", F0."dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."maqi" AS "ig_conv_owned10k_maqi"
FROM "owned10k" AS F0),
_temp_view_21 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_owned10k_county, NULL))) AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi"
FROM (SELECT * FROM _temp_view_22) F0),
_temp_view_20 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_owned10k_county"))::int8)::bit(10) AS "ig_conv_owned10k_county", F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ((F0."ig_conv_owned10k_year")::int8)::bit(10) AS "ig_conv_owned10k_year", ((F0."ig_conv_owned10k_dayswaqi")::int8)::bit(10) AS "ig_conv_owned10k_dayswaqi", ((F0."ig_conv_owned10k_maqi")::int8)::bit(10) AS "ig_conv_owned10k_maqi"
FROM (SELECT * FROM _temp_view_21) F0
GROUP BY F0."county", F0."year", F0."dayswaqi", F0."maqi", F0."ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi"),
_temp_view_25 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."county" AS "ig_conv_shared10k_county", F0."year" AS "ig_conv_shared10k_year", F0."gdays" AS "ig_conv_shared10k_gdays", F0."maqi" AS "ig_conv_shared10k_maqi"
FROM "shared10k" AS F0),
_temp_view_24 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_shared10k_county, NULL))) AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi"
FROM (SELECT * FROM _temp_view_25) F0),
_temp_view_23 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_shared10k_county"))::int8)::bit(10) AS "ig_conv_shared10k_county", F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ((F0."ig_conv_shared10k_year")::int8)::bit(10) AS "ig_conv_shared10k_year", ((F0."ig_conv_shared10k_gdays")::int8)::bit(10) AS "ig_conv_shared10k_gdays", ((F0."ig_conv_shared10k_maqi")::int8)::bit(10) AS "ig_conv_shared10k_maqi"
FROM (SELECT * FROM _temp_view_24) F0
GROUP BY F0."county", F0."year", F0."gdays", F0."maqi", F0."ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi"),
_temp_view_19 AS (
SELECT /*+ materialize */ (COALESCE(F1."county", 'na'))::text AS "county1", (COALESCE(F1."year", 0))::int8 AS "year1", (COALESCE(F0."dayswaqi", 0))::int8 AS "dayswaqi", (COALESCE(F1."gdays", 0))::int8 AS "gdays", (CASE  WHEN (F0."maqi" = F1."maqi") THEN F0."maqi" WHEN (F0."maqi" IS NULL) THEN F1."maqi" WHEN (F1."maqi" IS NULL) THEN F0."maqi" WHEN ((F0."maqi" IS NULL) AND (F1."maqi" IS NULL)) THEN 0 ELSE F0."maqi" END) AS "maqi", (CASE  WHEN (F0."ig_conv_owned10k_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_county" END) AS "ig_conv_owned10k_county", (CASE  WHEN (F0."ig_conv_owned10k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_year" END) AS "ig_conv_owned10k_year", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_dayswaqi" END) AS "ig_conv_owned10k_dayswaqi", (CASE  WHEN (F0."ig_conv_owned10k_maqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_maqi" END) AS "ig_conv_owned10k_maqi", (CASE  WHEN (F1."ig_conv_shared10k_county" IS NULL) THEN F0."ig_conv_owned10k_county" ELSE F1."ig_conv_shared10k_county" END) AS "ig_conv_shared10k_county", (CASE  WHEN (F1."ig_conv_shared10k_year" IS NULL) THEN F0."ig_conv_owned10k_year" ELSE F1."ig_conv_shared10k_year" END) AS "ig_conv_shared10k_year", (CASE  WHEN (F1."ig_conv_shared10k_gdays" IS NULL) THEN (0)::bit(10) ELSE F1."ig_conv_shared10k_gdays" END) AS "ig_conv_shared10k_gdays", (CASE  WHEN (F1."ig_conv_shared10k_maqi" IS NULL) THEN F0."ig_conv_owned10k_maqi" ELSE F1."ig_conv_shared10k_maqi" END) AS "ig_conv_shared10k_maqi", (CASE  WHEN (F0."ig_conv_owned10k_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_county" END) AS "ig_conv_owned10k_county_integ", (CASE  WHEN (F0."ig_conv_owned10k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_year" END) AS "ig_conv_owned10k_year_integ", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned10k_dayswaqi" END) AS "ig_conv_owned10k_dayswaqi_integ", (CASE  WHEN (F1."ig_conv_shared10k_gdays" IS NULL) THEN (0)::bit(10) ELSE F1."ig_conv_shared10k_gdays" END) AS "ig_conv_shared10k_gdays_integ", (CASE  WHEN (F0."ig_conv_owned10k_maqi" IS NULL) THEN F1."ig_conv_shared10k_maqi" ELSE F0."ig_conv_owned10k_maqi" END) AS "ig_conv_owned10k_maqi_integ"
FROM ((
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", ('owned10k' || (F0."ig_conv_owned10k_county")::text || 'county' || (F0."ig_conv_owned10k_year")::text || 'year' || (F0."ig_conv_owned10k_dayswaqi")::text || 'dayswaqi' || (F0."ig_conv_owned10k_maqi")::text || 'maqi') AS "owned10k_anno"
FROM (SELECT * FROM _temp_view_20) F0) F0 JOIN (
SELECT F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", ('shared10k' || (F0."ig_conv_shared10k_county")::text || 'county' || (F0."ig_conv_shared10k_year")::text || 'year' || (F0."ig_conv_shared10k_gdays")::text || 'gdays' || (F0."ig_conv_shared10k_maqi")::text || 'maqi') AS "shared10k_anno"
FROM (SELECT * FROM _temp_view_23) F0) F1 ON ((F0."maqi" = F1."maqi")))
WHERE ((F0."dayswaqi" >= 1) AND (F0."dayswaqi" <= 5))),
_temp_view_18 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", (CASE  WHEN (F0."ig_conv_owned10k_county_integ" = F0."ig_conv_owned10k_county") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_county_integ")::text, (F0."ig_conv_owned10k_county")::text) END) AS "hamming_ig_conv_owned10k_county_integ", (CASE  WHEN (F0."ig_conv_owned10k_year_integ" = F0."ig_conv_owned10k_year") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_year_integ")::text, (F0."ig_conv_owned10k_year")::text) END) AS "hamming_ig_conv_owned10k_year_integ", (CASE  WHEN (F0."ig_conv_owned10k_dayswaqi_integ" = F0."ig_conv_owned10k_dayswaqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_dayswaqi_integ")::text, (F0."ig_conv_owned10k_dayswaqi")::text) END) AS "hamming_ig_conv_owned10k_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared10k_gdays_integ" = F0."ig_conv_shared10k_gdays") THEN '0000000000' ELSE hammingdist((F0."ig_conv_shared10k_gdays_integ")::text, (F0."ig_conv_shared10k_gdays")::text) END) AS "hamming_ig_conv_shared10k_gdays_integ", (CASE  WHEN (F0."ig_conv_owned10k_maqi_integ" = F0."ig_conv_owned10k_maqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned10k_maqi_integ")::text, (F0."ig_conv_owned10k_maqi")::text) END) AS "hamming_ig_conv_owned10k_maqi_integ"
FROM (SELECT * FROM _temp_view_19) F0),
_temp_view_17 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", F0."hamming_ig_conv_owned10k_county_integ" AS "hamming_ig_conv_owned10k_county_integ", F0."hamming_ig_conv_owned10k_year_integ" AS "hamming_ig_conv_owned10k_year_integ", F0."hamming_ig_conv_owned10k_dayswaqi_integ" AS "hamming_ig_conv_owned10k_dayswaqi_integ", F0."hamming_ig_conv_shared10k_gdays_integ" AS "hamming_ig_conv_shared10k_gdays_integ", F0."hamming_ig_conv_owned10k_maqi_integ" AS "hamming_ig_conv_owned10k_maqi_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_county_integ") AS "value_hamming_ig_conv_owned10k_county_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_year_integ") AS "value_hamming_ig_conv_owned10k_year_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_dayswaqi_integ") AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", hammingdistvalue(F0."hamming_ig_conv_shared10k_gdays_integ") AS "value_hamming_ig_conv_shared10k_gdays_integ", hammingdistvalue(F0."hamming_ig_conv_owned10k_maqi_integ") AS "value_hamming_ig_conv_owned10k_maqi_integ"
FROM (SELECT * FROM _temp_view_18) F0),
_temp_view_16 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned10k_county" AS "ig_conv_owned10k_county", F0."ig_conv_owned10k_year" AS "ig_conv_owned10k_year", F0."ig_conv_owned10k_dayswaqi" AS "ig_conv_owned10k_dayswaqi", F0."ig_conv_owned10k_maqi" AS "ig_conv_owned10k_maqi", F0."ig_conv_shared10k_county" AS "ig_conv_shared10k_county", F0."ig_conv_shared10k_year" AS "ig_conv_shared10k_year", F0."ig_conv_shared10k_gdays" AS "ig_conv_shared10k_gdays", F0."ig_conv_shared10k_maqi" AS "ig_conv_shared10k_maqi", F0."ig_conv_owned10k_county_integ" AS "ig_conv_owned10k_county_integ", F0."ig_conv_owned10k_year_integ" AS "ig_conv_owned10k_year_integ", F0."ig_conv_owned10k_dayswaqi_integ" AS "ig_conv_owned10k_dayswaqi_integ", F0."ig_conv_shared10k_gdays_integ" AS "ig_conv_shared10k_gdays_integ", F0."ig_conv_owned10k_maqi_integ" AS "ig_conv_owned10k_maqi_integ", F0."hamming_ig_conv_owned10k_county_integ" AS "hamming_ig_conv_owned10k_county_integ", F0."hamming_ig_conv_owned10k_year_integ" AS "hamming_ig_conv_owned10k_year_integ", F0."hamming_ig_conv_owned10k_dayswaqi_integ" AS "hamming_ig_conv_owned10k_dayswaqi_integ", F0."hamming_ig_conv_shared10k_gdays_integ" AS "hamming_ig_conv_shared10k_gdays_integ", F0."hamming_ig_conv_owned10k_maqi_integ" AS "hamming_ig_conv_owned10k_maqi_integ", F0."value_hamming_ig_conv_owned10k_county_integ" AS "value_hamming_ig_conv_owned10k_county_integ", F0."value_hamming_ig_conv_owned10k_year_integ" AS "value_hamming_ig_conv_owned10k_year_integ", F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."value_hamming_ig_conv_shared10k_gdays_integ" AS "value_hamming_ig_conv_shared10k_gdays_integ", F0."value_hamming_ig_conv_owned10k_maqi_integ" AS "value_hamming_ig_conv_owned10k_maqi_integ", (F0."value_hamming_ig_conv_owned10k_county_integ" + F0."value_hamming_ig_conv_owned10k_year_integ" + F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" + F0."value_hamming_ig_conv_shared10k_gdays_integ" + F0."value_hamming_ig_conv_owned10k_maqi_integ") AS "Total_Distance", ((F0."value_hamming_ig_conv_owned10k_county_integ" + F0."value_hamming_ig_conv_owned10k_year_integ" + F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" + F0."value_hamming_ig_conv_shared10k_gdays_integ" + F0."value_hamming_ig_conv_owned10k_maqi_integ") / 5) AS "Average_Distance"
FROM (SELECT * FROM _temp_view_17) F0),
_temp_view_3 AS (
SELECT /*+ materialize */ F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage", F1."value_hamming_ig_conv_owned10k_county_integ" AS "value_hamming_ig_conv_owned10k_county_integ", F1."value_hamming_ig_conv_owned10k_year_integ" AS "value_hamming_ig_conv_owned10k_year_integ", F1."value_hamming_ig_conv_owned10k_dayswaqi_integ" AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", F1."value_hamming_ig_conv_shared10k_gdays_integ" AS "value_hamming_ig_conv_shared10k_gdays_integ", F1."value_hamming_ig_conv_owned10k_maqi_integ" AS "value_hamming_ig_conv_owned10k_maqi_integ", F1."Total_Distance" AS "Total_Distance"
FROM ((
SELECT F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage"
FROM (SELECT * FROM _temp_view_4) F0
WHERE ((F0."coverage" > 1) OR ((F0."coverage" = 1) AND (F0."informativeness" = 5)))) F0 JOIN (
SELECT F0."county1" AS "i_county1", F0."year1" AS "i_year1", F0."dayswaqi" AS "i_dayswaqi", F0."maqi" AS "i_maqi", F0."gdays" AS "i_gdays", F0."value_hamming_ig_conv_owned10k_county_integ" AS "value_hamming_ig_conv_owned10k_county_integ", F0."value_hamming_ig_conv_owned10k_year_integ" AS "value_hamming_ig_conv_owned10k_year_integ", F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."value_hamming_ig_conv_shared10k_gdays_integ" AS "value_hamming_ig_conv_shared10k_gdays_integ", F0."value_hamming_ig_conv_owned10k_maqi_integ" AS "value_hamming_ig_conv_owned10k_maqi_integ", F0."Total_Distance" AS "Total_Distance"
FROM (SELECT * FROM _temp_view_16) F0) F1 ON ((((F0."i_county1" IS NULL) OR (F0."i_county1" = F1."i_county1")) AND ((F0."i_year1" IS NULL) OR (F0."i_year1" = F1."i_year1")) AND ((F0."i_dayswaqi" IS NULL) OR (F0."i_dayswaqi" = F1."i_dayswaqi")) AND ((F0."i_maqi" IS NULL) OR (F0."i_maqi" = F1."i_maqi")) AND ((F0."i_gdays" IS NULL) OR (F0."i_gdays" = F1."i_gdays")))))),
_temp_view_2 AS (
SELECT /*+ materialize */  DISTINCT F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage", F0."value_hamming_ig_conv_owned10k_county_integ" AS "value_hamming_ig_conv_owned10k_county_integ", F0."value_hamming_ig_conv_owned10k_year_integ" AS "value_hamming_ig_conv_owned10k_year_integ", F0."value_hamming_ig_conv_owned10k_dayswaqi_integ" AS "value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."value_hamming_ig_conv_shared10k_gdays_integ" AS "value_hamming_ig_conv_shared10k_gdays_integ", F0."value_hamming_ig_conv_owned10k_maqi_integ" AS "value_hamming_ig_conv_owned10k_maqi_integ", F0."Total_Distance" AS "Total_Distance"
FROM (SELECT * FROM _temp_view_3) F0),
_temp_view_1 AS (
SELECT /*+ materialize */ COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_county_integ", F0."Total_Distance"), 0) AS "ig_conv_owned10k_county_integ_r2", COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_year_integ", F0."Total_Distance"), 0) AS "ig_conv_owned10k_year_integ_r2", COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."Total_Distance"), 0) AS "ig_conv_owned10k_dayswaqi_integ_r2", COALESCE(regr_r2(F0."value_hamming_ig_conv_shared10k_gdays_integ", F0."Total_Distance"), 0) AS "ig_conv_shared10k_gdays_integ_r2", COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_maqi_integ", F0."Total_Distance"), 0) AS "ig_conv_owned10k_maqi_integ_r2", F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage", ((COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_county_integ", F0."Total_Distance"), 0) + COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_year_integ", F0."Total_Distance"), 0) + COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_dayswaqi_integ", F0."Total_Distance"), 0) + COALESCE(regr_r2(F0."value_hamming_ig_conv_shared10k_gdays_integ", F0."Total_Distance"), 0) + COALESCE(regr_r2(F0."value_hamming_ig_conv_owned10k_maqi_integ", F0."Total_Distance"), 0)) / 5) AS "mean_r2"
FROM (SELECT * FROM _temp_view_2) F0
GROUP BY F0."i_county1", F0."i_year1", F0."i_dayswaqi", F0."i_maqi", F0."i_gdays", F0."pattern_IG", F0."informativeness", F0."coverage"),
_temp_view_0 AS (
SELECT /*+ materialize */ F0."ig_conv_owned10k_county_integ_r2" AS "ig_conv_owned10k_county_integ_r2", F0."ig_conv_owned10k_year_integ_r2" AS "ig_conv_owned10k_year_integ_r2", F0."ig_conv_owned10k_dayswaqi_integ_r2" AS "ig_conv_owned10k_dayswaqi_integ_r2", F0."ig_conv_shared10k_gdays_integ_r2" AS "ig_conv_shared10k_gdays_integ_r2", F0."ig_conv_owned10k_maqi_integ_r2" AS "ig_conv_owned10k_maqi_integ_r2", F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage", F0."mean_r2" AS "mean_r2", ((F0."pattern_IG" * F0."coverage" * F0."informativeness" * F0."mean_r2" * 4) / (F0."pattern_IG" + F0."coverage" + F0."informativeness" + F0."mean_r2")) AS "f_score"
FROM (SELECT * FROM _temp_view_1) F0)
SELECT F0."ig_conv_owned10k_county_integ_r2" AS "ig_conv_owned10k_county_integ_r2", F0."ig_conv_owned10k_year_integ_r2" AS "ig_conv_owned10k_year_integ_r2", F0."ig_conv_owned10k_dayswaqi_integ_r2" AS "ig_conv_owned10k_dayswaqi_integ_r2", F0."ig_conv_shared10k_gdays_integ_r2" AS "ig_conv_shared10k_gdays_integ_r2", F0."ig_conv_owned10k_maqi_integ_r2" AS "ig_conv_owned10k_maqi_integ_r2", F0."i_county1" AS "i_county1", F0."i_year1" AS "i_year1", F0."i_dayswaqi" AS "i_dayswaqi", F0."i_maqi" AS "i_maqi", F0."i_gdays" AS "i_gdays", F0."pattern_IG" AS "pattern_IG", F0."informativeness" AS "informativeness", F0."coverage" AS "coverage", F0."mean_r2" AS "mean_r2", F0."f_score" AS "f_score"
FROM (SELECT * FROM _temp_view_0) F0
ORDER BY F0."f_score" DESC NULLS LAST

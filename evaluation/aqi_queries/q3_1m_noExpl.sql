WITH _temp_view_12 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."county" AS "ig_conv_owned1m_county", F0."year" AS "ig_conv_owned1m_year", F0."dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."maqi" AS "ig_conv_owned1m_maqi"
FROM "owned1m" AS F0),
_temp_view_11 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_owned1m_county, NULL))) AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi"
FROM (SELECT * FROM _temp_view_12) F0),
_temp_view_10 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_owned1m_county"))::int8)::bit(10) AS "ig_conv_owned1m_county", F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ((F0."ig_conv_owned1m_year")::int8)::bit(10) AS "ig_conv_owned1m_year", ((F0."ig_conv_owned1m_dayswaqi")::int8)::bit(10) AS "ig_conv_owned1m_dayswaqi", ((F0."ig_conv_owned1m_maqi")::int8)::bit(10) AS "ig_conv_owned1m_maqi"
FROM (SELECT * FROM _temp_view_11) F0
GROUP BY F0."county", F0."year", F0."dayswaqi", F0."maqi", F0."ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi"),
_temp_view_15 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."county" AS "ig_conv_shared1m_county", F0."year" AS "ig_conv_shared1m_year", F0."gdays" AS "ig_conv_shared1m_gdays", F0."maqi" AS "ig_conv_shared1m_maqi"
FROM "shared1m" AS F0),
_temp_view_14 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_shared1m_county, NULL))) AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi"
FROM (SELECT * FROM _temp_view_15) F0),
_temp_view_13 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_shared1m_county"))::int8)::bit(10) AS "ig_conv_shared1m_county", F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ((F0."ig_conv_shared1m_year")::int8)::bit(10) AS "ig_conv_shared1m_year", ((F0."ig_conv_shared1m_gdays")::int8)::bit(10) AS "ig_conv_shared1m_gdays", ((F0."ig_conv_shared1m_maqi")::int8)::bit(10) AS "ig_conv_shared1m_maqi"
FROM (SELECT * FROM _temp_view_14) F0
GROUP BY F0."county", F0."year", F0."gdays", F0."maqi", F0."ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi"),
_temp_view_9 AS (
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."owned1m_anno" AS "owned1m_anno", F1."county" AS "county1", F1."year" AS "year1", F1."gdays" AS "gdays", F1."maqi" AS "maqi1", F1."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F1."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F1."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F1."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F1."shared1m_anno" AS "shared1m_anno"
FROM ((
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", ('owned1m' || (F0."ig_conv_owned1m_county")::text || 'county' || (F0."ig_conv_owned1m_year")::text || 'year' || (F0."ig_conv_owned1m_dayswaqi")::text || 'dayswaqi' || (F0."ig_conv_owned1m_maqi")::text || 'maqi') AS "owned1m_anno"
FROM (SELECT * FROM _temp_view_10) F0) F0 JOIN (
SELECT F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", ('shared1m' || (F0."ig_conv_shared1m_county")::text || 'county' || (F0."ig_conv_shared1m_year")::text || 'year' || (F0."ig_conv_shared1m_gdays")::text || 'gdays' || (F0."ig_conv_shared1m_maqi")::text || 'maqi') AS "shared1m_anno"
FROM (SELECT * FROM _temp_view_13) F0) F1 ON ((F0."maqi" = F1."maqi")))
WHERE ((F0."dayswaqi" >= 1) AND (F0."dayswaqi" <= 5))),
_temp_view_8 AS (
SELECT /*+ materialize */ (COALESCE(F0."county1", 'na'))::text AS "county1", (COALESCE(F0."year1", 0))::int8 AS "year1", (COALESCE(F0."dayswaqi", 0))::int8 AS "dayswaqi", (COALESCE(F0."gdays", 0))::int8 AS "gdays", (CASE  WHEN (F0."maqi" = F0."maqi1") THEN F0."maqi" WHEN (F0."maqi" IS NULL) THEN F0."maqi1" WHEN (F0."maqi1" IS NULL) THEN F0."maqi" WHEN ((F0."maqi" IS NULL) AND (F0."maqi1" IS NULL)) THEN 0 ELSE F0."maqi" END) AS "maqi", (CASE  WHEN (F0."ig_conv_owned1m_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_county" END) AS "ig_conv_owned1m_county", (CASE  WHEN (F0."ig_conv_owned1m_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_year" END) AS "ig_conv_owned1m_year", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_dayswaqi" END) AS "ig_conv_owned1m_dayswaqi", (CASE  WHEN (F0."ig_conv_owned1m_maqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_maqi" END) AS "ig_conv_owned1m_maqi", (CASE  WHEN (F0."ig_conv_shared1m_county" IS NULL) THEN F0."ig_conv_owned1m_county" ELSE F0."ig_conv_shared1m_county" END) AS "ig_conv_shared1m_county", (CASE  WHEN (F0."ig_conv_shared1m_year" IS NULL) THEN F0."ig_conv_owned1m_year" ELSE F0."ig_conv_shared1m_year" END) AS "ig_conv_shared1m_year", (CASE  WHEN (F0."ig_conv_shared1m_gdays" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_shared1m_gdays" END) AS "ig_conv_shared1m_gdays", (CASE  WHEN (F0."ig_conv_shared1m_maqi" IS NULL) THEN F0."ig_conv_owned1m_maqi" ELSE F0."ig_conv_shared1m_maqi" END) AS "ig_conv_shared1m_maqi", (CASE  WHEN (F0."ig_conv_owned1m_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_county" END) AS "ig_conv_owned1m_county_integ", (CASE  WHEN (F0."ig_conv_owned1m_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_year" END) AS "ig_conv_owned1m_year_integ", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_dayswaqi" END) AS "ig_conv_owned1m_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared1m_gdays" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_shared1m_gdays" END) AS "ig_conv_shared1m_gdays_integ", (CASE  WHEN (F0."ig_conv_owned1m_maqi" IS NULL) THEN F0."ig_conv_shared1m_maqi" ELSE F0."ig_conv_owned1m_maqi" END) AS "ig_conv_owned1m_maqi_integ"
FROM (SELECT * FROM _temp_view_9) F0),
_temp_view_7 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", (CASE  WHEN (F0."ig_conv_owned1m_county_integ" = F0."ig_conv_owned1m_county") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_county_integ")::text, (F0."ig_conv_owned1m_county")::text) END) AS "hamming_ig_conv_owned1m_county_integ", (CASE  WHEN (F0."ig_conv_owned1m_year_integ" = F0."ig_conv_owned1m_year") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_year_integ")::text, (F0."ig_conv_owned1m_year")::text) END) AS "hamming_ig_conv_owned1m_year_integ", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi_integ" = F0."ig_conv_owned1m_dayswaqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_dayswaqi_integ")::text, (F0."ig_conv_owned1m_dayswaqi")::text) END) AS "hamming_ig_conv_owned1m_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared1m_gdays_integ" = F0."ig_conv_shared1m_gdays") THEN '0000000000' ELSE hammingdist((F0."ig_conv_shared1m_gdays_integ")::text, (F0."ig_conv_shared1m_gdays")::text) END) AS "hamming_ig_conv_shared1m_gdays_integ", (CASE  WHEN (F0."ig_conv_owned1m_maqi_integ" = F0."ig_conv_owned1m_maqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_maqi_integ")::text, (F0."ig_conv_owned1m_maqi")::text) END) AS "hamming_ig_conv_owned1m_maqi_integ"
FROM (SELECT * FROM _temp_view_8) F0),
_temp_view_6 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", F0."hamming_ig_conv_owned1m_county_integ" AS "hamming_ig_conv_owned1m_county_integ", F0."hamming_ig_conv_owned1m_year_integ" AS "hamming_ig_conv_owned1m_year_integ", F0."hamming_ig_conv_owned1m_dayswaqi_integ" AS "hamming_ig_conv_owned1m_dayswaqi_integ", F0."hamming_ig_conv_shared1m_gdays_integ" AS "hamming_ig_conv_shared1m_gdays_integ", F0."hamming_ig_conv_owned1m_maqi_integ" AS "hamming_ig_conv_owned1m_maqi_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_county_integ") AS "value_hamming_ig_conv_owned1m_county_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_year_integ") AS "value_hamming_ig_conv_owned1m_year_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_dayswaqi_integ") AS "value_hamming_ig_conv_owned1m_dayswaqi_integ", hammingdistvalue(F0."hamming_ig_conv_shared1m_gdays_integ") AS "value_hamming_ig_conv_shared1m_gdays_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_maqi_integ") AS "value_hamming_ig_conv_owned1m_maqi_integ"
FROM (SELECT * FROM _temp_view_7) F0),
_temp_view_5 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", F0."hamming_ig_conv_owned1m_county_integ" AS "hamming_ig_conv_owned1m_county_integ", F0."hamming_ig_conv_owned1m_year_integ" AS "hamming_ig_conv_owned1m_year_integ", F0."hamming_ig_conv_owned1m_dayswaqi_integ" AS "hamming_ig_conv_owned1m_dayswaqi_integ", F0."hamming_ig_conv_shared1m_gdays_integ" AS "hamming_ig_conv_shared1m_gdays_integ", F0."hamming_ig_conv_owned1m_maqi_integ" AS "hamming_ig_conv_owned1m_maqi_integ", F0."value_hamming_ig_conv_owned1m_county_integ" AS "value_hamming_ig_conv_owned1m_county_integ", F0."value_hamming_ig_conv_owned1m_year_integ" AS "value_hamming_ig_conv_owned1m_year_integ", F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" AS "value_hamming_ig_conv_owned1m_dayswaqi_integ", F0."value_hamming_ig_conv_shared1m_gdays_integ" AS "value_hamming_ig_conv_shared1m_gdays_integ", F0."value_hamming_ig_conv_owned1m_maqi_integ" AS "value_hamming_ig_conv_owned1m_maqi_integ", (F0."value_hamming_ig_conv_owned1m_county_integ" + F0."value_hamming_ig_conv_owned1m_year_integ" + F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" + F0."value_hamming_ig_conv_shared1m_gdays_integ" + F0."value_hamming_ig_conv_owned1m_maqi_integ") AS "Total_Distance", ((F0."value_hamming_ig_conv_owned1m_county_integ" + F0."value_hamming_ig_conv_owned1m_year_integ" + F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" + F0."value_hamming_ig_conv_shared1m_gdays_integ" + F0."value_hamming_ig_conv_owned1m_maqi_integ") / 5) AS "Average_Distance"
FROM (SELECT * FROM _temp_view_6) F0),
_temp_view_4 AS (
SELECT /*+ materialize */ F0."county1" AS "i_county1", F0."year1" AS "i_year1", F0."dayswaqi" AS "i_dayswaqi", F0."maqi" AS "i_maqi", F0."gdays" AS "i_gdays", SUM(F0."Total_Distance") AS "pattern_IG", ((CASE  WHEN (NOT ((F0."county1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."year1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."dayswaqi" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."maqi" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."gdays" IS NULL))) THEN 1 ELSE 0 END)) AS "informativeness", COUNT(1) AS "coverage"
FROM (SELECT * FROM _temp_view_5) F0
GROUP BY CUBE (F0."county1", F0."year1", F0."dayswaqi", F0."maqi", F0."gdays")),
_temp_view_22 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."county" AS "ig_conv_owned1m_county", F0."year" AS "ig_conv_owned1m_year", F0."dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."maqi" AS "ig_conv_owned1m_maqi"
FROM "owned1m" AS F0),
_temp_view_21 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_owned1m_county, NULL))) AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi"
FROM (SELECT * FROM _temp_view_22) F0),
_temp_view_20 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_owned1m_county"))::int8)::bit(10) AS "ig_conv_owned1m_county", F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", ((F0."ig_conv_owned1m_year")::int8)::bit(10) AS "ig_conv_owned1m_year", ((F0."ig_conv_owned1m_dayswaqi")::int8)::bit(10) AS "ig_conv_owned1m_dayswaqi", ((F0."ig_conv_owned1m_maqi")::int8)::bit(10) AS "ig_conv_owned1m_maqi"
FROM (SELECT * FROM _temp_view_21) F0
GROUP BY F0."county", F0."year", F0."dayswaqi", F0."maqi", F0."ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi"),
_temp_view_25 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."county" AS "ig_conv_shared1m_county", F0."year" AS "ig_conv_shared1m_year", F0."gdays" AS "ig_conv_shared1m_gdays", F0."maqi" AS "ig_conv_shared1m_maqi"
FROM "shared1m" AS F0),
_temp_view_24 AS (
SELECT /*+ materialize */ F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ascii(unnest(string_to_array(ig_conv_shared1m_county, NULL))) AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi"
FROM (SELECT * FROM _temp_view_25) F0),
_temp_view_23 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_shared1m_county"))::int8)::bit(10) AS "ig_conv_shared1m_county", F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", ((F0."ig_conv_shared1m_year")::int8)::bit(10) AS "ig_conv_shared1m_year", ((F0."ig_conv_shared1m_gdays")::int8)::bit(10) AS "ig_conv_shared1m_gdays", ((F0."ig_conv_shared1m_maqi")::int8)::bit(10) AS "ig_conv_shared1m_maqi"
FROM (SELECT * FROM _temp_view_24) F0
GROUP BY F0."county", F0."year", F0."gdays", F0."maqi", F0."ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi"),
_temp_view_19 AS (
SELECT /*+ materialize */ (COALESCE(F1."county", 'na'))::text AS "county1", (COALESCE(F1."year", 0))::int8 AS "year1", (COALESCE(F0."dayswaqi", 0))::int8 AS "dayswaqi", (COALESCE(F1."gdays", 0))::int8 AS "gdays", (CASE  WHEN (F0."maqi" = F1."maqi") THEN F0."maqi" WHEN (F0."maqi" IS NULL) THEN F1."maqi" WHEN (F1."maqi" IS NULL) THEN F0."maqi" WHEN ((F0."maqi" IS NULL) AND (F1."maqi" IS NULL)) THEN 0 ELSE F0."maqi" END) AS "maqi", (CASE  WHEN (F0."ig_conv_owned1m_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_county" END) AS "ig_conv_owned1m_county", (CASE  WHEN (F0."ig_conv_owned1m_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_year" END) AS "ig_conv_owned1m_year", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_dayswaqi" END) AS "ig_conv_owned1m_dayswaqi", (CASE  WHEN (F0."ig_conv_owned1m_maqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_maqi" END) AS "ig_conv_owned1m_maqi", (CASE  WHEN (F1."ig_conv_shared1m_county" IS NULL) THEN F0."ig_conv_owned1m_county" ELSE F1."ig_conv_shared1m_county" END) AS "ig_conv_shared1m_county", (CASE  WHEN (F1."ig_conv_shared1m_year" IS NULL) THEN F0."ig_conv_owned1m_year" ELSE F1."ig_conv_shared1m_year" END) AS "ig_conv_shared1m_year", (CASE  WHEN (F1."ig_conv_shared1m_gdays" IS NULL) THEN (0)::bit(10) ELSE F1."ig_conv_shared1m_gdays" END) AS "ig_conv_shared1m_gdays", (CASE  WHEN (F1."ig_conv_shared1m_maqi" IS NULL) THEN F0."ig_conv_owned1m_maqi" ELSE F1."ig_conv_shared1m_maqi" END) AS "ig_conv_shared1m_maqi", (CASE  WHEN (F0."ig_conv_owned1m_county" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_county" END) AS "ig_conv_owned1m_county_integ", (CASE  WHEN (F0."ig_conv_owned1m_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_year" END) AS "ig_conv_owned1m_year_integ", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_owned1m_dayswaqi" END) AS "ig_conv_owned1m_dayswaqi_integ", (CASE  WHEN (F1."ig_conv_shared1m_gdays" IS NULL) THEN (0)::bit(10) ELSE F1."ig_conv_shared1m_gdays" END) AS "ig_conv_shared1m_gdays_integ", (CASE  WHEN (F0."ig_conv_owned1m_maqi" IS NULL) THEN F1."ig_conv_shared1m_maqi" ELSE F0."ig_conv_owned1m_maqi" END) AS "ig_conv_owned1m_maqi_integ"
FROM ((
SELECT F0."county" AS "county", F0."year" AS "year", F0."dayswaqi" AS "dayswaqi", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", ('owned1m' || (F0."ig_conv_owned1m_county")::text || 'county' || (F0."ig_conv_owned1m_year")::text || 'year' || (F0."ig_conv_owned1m_dayswaqi")::text || 'dayswaqi' || (F0."ig_conv_owned1m_maqi")::text || 'maqi') AS "owned1m_anno"
FROM (SELECT * FROM _temp_view_20) F0) F0 JOIN (
SELECT F0."county" AS "county", F0."year" AS "year", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", ('shared1m' || (F0."ig_conv_shared1m_county")::text || 'county' || (F0."ig_conv_shared1m_year")::text || 'year' || (F0."ig_conv_shared1m_gdays")::text || 'gdays' || (F0."ig_conv_shared1m_maqi")::text || 'maqi') AS "shared1m_anno"
FROM (SELECT * FROM _temp_view_23) F0) F1 ON ((F0."maqi" = F1."maqi")))
WHERE ((F0."dayswaqi" >= 1) AND (F0."dayswaqi" <= 5))),
_temp_view_18 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", (CASE  WHEN (F0."ig_conv_owned1m_county_integ" = F0."ig_conv_owned1m_county") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_county_integ")::text, (F0."ig_conv_owned1m_county")::text) END) AS "hamming_ig_conv_owned1m_county_integ", (CASE  WHEN (F0."ig_conv_owned1m_year_integ" = F0."ig_conv_owned1m_year") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_year_integ")::text, (F0."ig_conv_owned1m_year")::text) END) AS "hamming_ig_conv_owned1m_year_integ", (CASE  WHEN (F0."ig_conv_owned1m_dayswaqi_integ" = F0."ig_conv_owned1m_dayswaqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_dayswaqi_integ")::text, (F0."ig_conv_owned1m_dayswaqi")::text) END) AS "hamming_ig_conv_owned1m_dayswaqi_integ", (CASE  WHEN (F0."ig_conv_shared1m_gdays_integ" = F0."ig_conv_shared1m_gdays") THEN '0000000000' ELSE hammingdist((F0."ig_conv_shared1m_gdays_integ")::text, (F0."ig_conv_shared1m_gdays")::text) END) AS "hamming_ig_conv_shared1m_gdays_integ", (CASE  WHEN (F0."ig_conv_owned1m_maqi_integ" = F0."ig_conv_owned1m_maqi") THEN '0000000000' ELSE hammingdist((F0."ig_conv_owned1m_maqi_integ")::text, (F0."ig_conv_owned1m_maqi")::text) END) AS "hamming_ig_conv_owned1m_maqi_integ"
FROM (SELECT * FROM _temp_view_19) F0),
_temp_view_17 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", F0."hamming_ig_conv_owned1m_county_integ" AS "hamming_ig_conv_owned1m_county_integ", F0."hamming_ig_conv_owned1m_year_integ" AS "hamming_ig_conv_owned1m_year_integ", F0."hamming_ig_conv_owned1m_dayswaqi_integ" AS "hamming_ig_conv_owned1m_dayswaqi_integ", F0."hamming_ig_conv_shared1m_gdays_integ" AS "hamming_ig_conv_shared1m_gdays_integ", F0."hamming_ig_conv_owned1m_maqi_integ" AS "hamming_ig_conv_owned1m_maqi_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_county_integ") AS "value_hamming_ig_conv_owned1m_county_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_year_integ") AS "value_hamming_ig_conv_owned1m_year_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_dayswaqi_integ") AS "value_hamming_ig_conv_owned1m_dayswaqi_integ", hammingdistvalue(F0."hamming_ig_conv_shared1m_gdays_integ") AS "value_hamming_ig_conv_shared1m_gdays_integ", hammingdistvalue(F0."hamming_ig_conv_owned1m_maqi_integ") AS "value_hamming_ig_conv_owned1m_maqi_integ"
FROM (SELECT * FROM _temp_view_18) F0),
_temp_view_16 AS (
SELECT /*+ materialize */ F0."county1" AS "county1", F0."year1" AS "year1", F0."dayswaqi" AS "dayswaqi", F0."gdays" AS "gdays", F0."maqi" AS "maqi", F0."ig_conv_owned1m_county" AS "ig_conv_owned1m_county", F0."ig_conv_owned1m_year" AS "ig_conv_owned1m_year", F0."ig_conv_owned1m_dayswaqi" AS "ig_conv_owned1m_dayswaqi", F0."ig_conv_owned1m_maqi" AS "ig_conv_owned1m_maqi", F0."ig_conv_shared1m_county" AS "ig_conv_shared1m_county", F0."ig_conv_shared1m_year" AS "ig_conv_shared1m_year", F0."ig_conv_shared1m_gdays" AS "ig_conv_shared1m_gdays", F0."ig_conv_shared1m_maqi" AS "ig_conv_shared1m_maqi", F0."ig_conv_owned1m_county_integ" AS "ig_conv_owned1m_county_integ", F0."ig_conv_owned1m_year_integ" AS "ig_conv_owned1m_year_integ", F0."ig_conv_owned1m_dayswaqi_integ" AS "ig_conv_owned1m_dayswaqi_integ", F0."ig_conv_shared1m_gdays_integ" AS "ig_conv_shared1m_gdays_integ", F0."ig_conv_owned1m_maqi_integ" AS "ig_conv_owned1m_maqi_integ", F0."hamming_ig_conv_owned1m_county_integ" AS "hamming_ig_conv_owned1m_county_integ", F0."hamming_ig_conv_owned1m_year_integ" AS "hamming_ig_conv_owned1m_year_integ", F0."hamming_ig_conv_owned1m_dayswaqi_integ" AS "hamming_ig_conv_owned1m_dayswaqi_integ", F0."hamming_ig_conv_shared1m_gdays_integ" AS "hamming_ig_conv_shared1m_gdays_integ", F0."hamming_ig_conv_owned1m_maqi_integ" AS "hamming_ig_conv_owned1m_maqi_integ", F0."value_hamming_ig_conv_owned1m_county_integ" AS "value_hamming_ig_conv_owned1m_county_integ", F0."value_hamming_ig_conv_owned1m_year_integ" AS "value_hamming_ig_conv_owned1m_year_integ", F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" AS "value_hamming_ig_conv_owned1m_dayswaqi_integ", F0."value_hamming_ig_conv_shared1m_gdays_integ" AS "value_hamming_ig_conv_shared1m_gdays_integ", F0."value_hamming_ig_conv_owned1m_maqi_integ" AS "value_hamming_ig_conv_owned1m_maqi_integ", (F0."value_hamming_ig_conv_owned1m_county_integ" + F0."value_hamming_ig_conv_owned1m_year_integ" + F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" + F0."value_hamming_ig_conv_shared1m_gdays_integ" + F0."value_hamming_ig_conv_owned1m_maqi_integ") AS "Total_Distance", ((F0."value_hamming_ig_conv_owned1m_county_integ" + F0."value_hamming_ig_conv_owned1m_year_integ" + F0."value_hamming_ig_conv_owned1m_dayswaqi_integ" + F0."value_hamming_ig_conv_shared1m_gdays_integ" + F0."value_hamming_ig_conv_owned1m_maqi_integ") / 5) AS "Average_Distance"
FROM (SELECT * FROM _temp_view_17) F0)
select * from _temp_view_16
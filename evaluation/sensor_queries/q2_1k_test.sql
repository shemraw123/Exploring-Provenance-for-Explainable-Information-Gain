WITH _temp_view_12 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."subid" AS "ig_conv_accelphone1k_subid", F0."actcode" AS "ig_conv_accelphone1k_actcode", F0."actgroup" AS "ig_conv_accelphone1k_actgroup", F0."year" AS "ig_conv_accelphone1k_year", F0."month" AS "ig_conv_accelphone1k_month", F0."x" AS "ig_conv_accelphone1k_x", F0."y" AS "ig_conv_accelphone1k_y", F0."z" AS "ig_conv_accelphone1k_z"
FROM "accelphone10k" AS F0),
_temp_view_11 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", ascii(unnest(string_to_array(ig_conv_accelphone1k_actcode, NULL))) AS "ig_conv_accelphone1k_actcode", ascii(unnest(string_to_array(ig_conv_accelphone1k_actgroup, NULL))) AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z"
FROM (SELECT * FROM _temp_view_12) F0),
_temp_view_10 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_accelphone1k_actcode"))::int8)::bit(10) AS "ig_conv_accelphone1k_actcode", ((SUM(F0."ig_conv_accelphone1k_actgroup"))::int8)::bit(10) AS "ig_conv_accelphone1k_actgroup", F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", ((F0."ig_conv_accelphone1k_subid")::int8)::bit(10) AS "ig_conv_accelphone1k_subid", ((F0."ig_conv_accelphone1k_year")::int8)::bit(10) AS "ig_conv_accelphone1k_year", ((F0."ig_conv_accelphone1k_month")::int8)::bit(10) AS "ig_conv_accelphone1k_month", ((F0."ig_conv_accelphone1k_x")::int8)::bit(10) AS "ig_conv_accelphone1k_x", ((F0."ig_conv_accelphone1k_y")::int8)::bit(10) AS "ig_conv_accelphone1k_y", ((F0."ig_conv_accelphone1k_z")::int8)::bit(10) AS "ig_conv_accelphone1k_z"
FROM (SELECT * FROM _temp_view_11) F0
GROUP BY F0."subid", F0."actcode", F0."actgroup", F0."year", F0."month", F0."x", F0."y", F0."z", F0."ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z"),
_temp_view_15 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."subid" AS "ig_conv_accelwatch1k_subid", F0."actcode" AS "ig_conv_accelwatch1k_actcode", F0."actgroup" AS "ig_conv_accelwatch1k_actgroup", F0."year" AS "ig_conv_accelwatch1k_year", F0."month" AS "ig_conv_accelwatch1k_month", F0."x" AS "ig_conv_accelwatch1k_x", F0."y" AS "ig_conv_accelwatch1k_y", F0."z" AS "ig_conv_accelwatch1k_z"
FROM "accelwatch10k" AS F0),
_temp_view_14 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", ascii(unnest(string_to_array(ig_conv_accelwatch1k_actcode, NULL))) AS "ig_conv_accelwatch1k_actcode", ascii(unnest(string_to_array(ig_conv_accelwatch1k_actgroup, NULL))) AS "ig_conv_accelwatch1k_actgroup", F0."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z"
FROM (SELECT * FROM _temp_view_15) F0),
_temp_view_13 AS (
SELECT /*+ materialize */ ((SUM(F0."ig_conv_accelwatch1k_actcode"))::int8)::bit(10) AS "ig_conv_accelwatch1k_actcode", ((SUM(F0."ig_conv_accelwatch1k_actgroup"))::int8)::bit(10) AS "ig_conv_accelwatch1k_actgroup", F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", ((F0."ig_conv_accelwatch1k_subid")::int8)::bit(10) AS "ig_conv_accelwatch1k_subid", ((F0."ig_conv_accelwatch1k_year")::int8)::bit(10) AS "ig_conv_accelwatch1k_year", ((F0."ig_conv_accelwatch1k_month")::int8)::bit(10) AS "ig_conv_accelwatch1k_month", ((F0."ig_conv_accelwatch1k_x")::int8)::bit(10) AS "ig_conv_accelwatch1k_x", ((F0."ig_conv_accelwatch1k_y")::int8)::bit(10) AS "ig_conv_accelwatch1k_y", ((F0."ig_conv_accelwatch1k_z")::int8)::bit(10) AS "ig_conv_accelwatch1k_z"
FROM (SELECT * FROM _temp_view_14) F0
GROUP BY F0."subid", F0."actcode", F0."actgroup", F0."year", F0."month", F0."x", F0."y", F0."z", F0."ig_conv_accelwatch1k_subid", F0."ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z"),
_temp_view_9 AS (
SELECT F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_actcode" AS "ig_conv_accelphone1k_actcode", F0."ig_conv_accelphone1k_actgroup" AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z", F0."accelphone1k_anno" AS "accelphone1k_anno", F1."subid" AS "subid1", F1."actcode" AS "actcode1", F1."actgroup" AS "actgroup1", F1."year" AS "year1", F1."month" AS "month1", F1."x" AS "x1", F1."y" AS "y1", F1."z" AS "z1", F1."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", F1."ig_conv_accelwatch1k_actcode" AS "ig_conv_accelwatch1k_actcode", F1."ig_conv_accelwatch1k_actgroup" AS "ig_conv_accelwatch1k_actgroup", F1."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F1."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F1."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F1."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F1."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z", F1."accelwatch1k_anno" AS "accelwatch1k_anno"
FROM ((
SELECT F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_actcode" AS "ig_conv_accelphone1k_actcode", F0."ig_conv_accelphone1k_actgroup" AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z", ('accelphone1k' || (F0."ig_conv_accelphone1k_subid")::text || 'subid' || (F0."ig_conv_accelphone1k_actcode")::text || 'actcode' || (F0."ig_conv_accelphone1k_actgroup")::text || 'actgroup' || (F0."ig_conv_accelphone1k_year")::text || 'year' || (F0."ig_conv_accelphone1k_month")::text || 'month' || (F0."ig_conv_accelphone1k_x")::text || 'x' || (F0."ig_conv_accelphone1k_y")::text || 'y' || (F0."ig_conv_accelphone1k_z")::text || 'z') AS "accelphone1k_anno"
FROM (SELECT * FROM _temp_view_10) F0) F0 JOIN (
SELECT F0."subid" AS "subid", F0."actcode" AS "actcode", F0."actgroup" AS "actgroup", F0."year" AS "year", F0."month" AS "month", F0."x" AS "x", F0."y" AS "y", F0."z" AS "z", F0."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", F0."ig_conv_accelwatch1k_actcode" AS "ig_conv_accelwatch1k_actcode", F0."ig_conv_accelwatch1k_actgroup" AS "ig_conv_accelwatch1k_actgroup", F0."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z", ('accelwatch1k' || (F0."ig_conv_accelwatch1k_subid")::text || 'subid' || (F0."ig_conv_accelwatch1k_actcode")::text || 'actcode' || (F0."ig_conv_accelwatch1k_actgroup")::text || 'actgroup' || (F0."ig_conv_accelwatch1k_year")::text || 'year' || (F0."ig_conv_accelwatch1k_month")::text || 'month' || (F0."ig_conv_accelwatch1k_x")::text || 'x' || (F0."ig_conv_accelwatch1k_y")::text || 'y' || (F0."ig_conv_accelwatch1k_z")::text || 'z') AS "accelwatch1k_anno"
FROM (SELECT * FROM _temp_view_13) F0) F1 ON ((((F0."actcode" = F1."actcode") AND (F0."actgroup" = F1."actgroup")) AND (F0."subid" = F1."subid"))))
WHERE ((F0."year" = 2020) AND (F1."year" = 2020))),
_temp_view_8 AS (
SELECT /*+ materialize */ (CASE  WHEN (F0."subid" = F0."subid1") THEN F0."subid" WHEN (F0."subid" IS NULL) THEN F0."subid1" WHEN (F0."subid1" IS NULL) THEN F0."subid" WHEN ((F0."subid" IS NULL) AND (F0."subid1" IS NULL)) THEN 0 ELSE F0."subid" END) AS "subid", (COALESCE(F0."year1", 0))::int8 AS "year1", (COALESCE(F0."month1", 0))::int8 AS "month1", (CASE  WHEN (F0."x" = F0."x1") THEN F0."x" WHEN (F0."x" IS NULL) THEN F0."x1" WHEN (F0."x1" IS NULL) THEN F0."x" WHEN ((F0."x" IS NULL) AND (F0."x1" IS NULL)) THEN 0 ELSE F0."x" END) AS "x", (COALESCE(F0."x1", 0))::int8 AS "x1", (CASE  WHEN (F0."y" = F0."y1") THEN F0."y" WHEN (F0."y" IS NULL) THEN F0."y1" WHEN (F0."y1" IS NULL) THEN F0."y" WHEN ((F0."y" IS NULL) AND (F0."y1" IS NULL)) THEN 0 ELSE F0."y" END) AS "y", (COALESCE(F0."y1", 0))::int8 AS "y1", (CASE  WHEN (F0."z" = F0."z1") THEN F0."z" WHEN (F0."z" IS NULL) THEN F0."z1" WHEN (F0."z1" IS NULL) THEN F0."z" WHEN ((F0."z" IS NULL) AND (F0."z1" IS NULL)) THEN 0 ELSE F0."z" END) AS "z", (COALESCE(F0."z1", 0))::int8 AS "z1", (CASE  WHEN (F0."ig_conv_accelphone1k_subid" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_subid" END) AS "ig_conv_accelphone1k_subid", (CASE  WHEN (F0."ig_conv_accelphone1k_actcode" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_actcode" END) AS "ig_conv_accelphone1k_actcode", (CASE  WHEN (F0."ig_conv_accelphone1k_actgroup" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_actgroup" END) AS "ig_conv_accelphone1k_actgroup", (CASE  WHEN (F0."ig_conv_accelphone1k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_year" END) AS "ig_conv_accelphone1k_year", (CASE  WHEN (F0."ig_conv_accelphone1k_month" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_month" END) AS "ig_conv_accelphone1k_month", (CASE  WHEN (F0."ig_conv_accelphone1k_x" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_x" END) AS "ig_conv_accelphone1k_x", (CASE  WHEN (F0."ig_conv_accelphone1k_y" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_y" END) AS "ig_conv_accelphone1k_y", (CASE  WHEN (F0."ig_conv_accelphone1k_z" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_z" END) AS "ig_conv_accelphone1k_z", (CASE  WHEN (F0."ig_conv_accelwatch1k_subid" IS NULL) THEN F0."ig_conv_accelphone1k_subid" ELSE F0."ig_conv_accelwatch1k_subid" END) AS "ig_conv_accelwatch1k_subid", (CASE  WHEN (F0."ig_conv_accelwatch1k_actcode" IS NULL) THEN F0."ig_conv_accelphone1k_actcode" ELSE F0."ig_conv_accelwatch1k_actcode" END) AS "ig_conv_accelwatch1k_actcode", (CASE  WHEN (F0."ig_conv_accelwatch1k_actgroup" IS NULL) THEN F0."ig_conv_accelphone1k_actgroup" ELSE F0."ig_conv_accelwatch1k_actgroup" END) AS "ig_conv_accelwatch1k_actgroup", (CASE  WHEN (F0."ig_conv_accelwatch1k_year" IS NULL) THEN F0."ig_conv_accelphone1k_year" ELSE F0."ig_conv_accelwatch1k_year" END) AS "ig_conv_accelwatch1k_year", (CASE  WHEN (F0."ig_conv_accelwatch1k_month" IS NULL) THEN F0."ig_conv_accelphone1k_month" ELSE F0."ig_conv_accelwatch1k_month" END) AS "ig_conv_accelwatch1k_month", (CASE  WHEN (F0."ig_conv_accelwatch1k_x" IS NULL) THEN F0."ig_conv_accelphone1k_x" ELSE F0."ig_conv_accelwatch1k_x" END) AS "ig_conv_accelwatch1k_x", (CASE  WHEN (F0."ig_conv_accelwatch1k_y" IS NULL) THEN F0."ig_conv_accelphone1k_y" ELSE F0."ig_conv_accelwatch1k_y" END) AS "ig_conv_accelwatch1k_y", (CASE  WHEN (F0."ig_conv_accelwatch1k_z" IS NULL) THEN F0."ig_conv_accelphone1k_z" ELSE F0."ig_conv_accelwatch1k_z" END) AS "ig_conv_accelwatch1k_z", (CASE  WHEN (F0."ig_conv_accelphone1k_subid" IS NULL) THEN F0."ig_conv_accelwatch1k_subid" ELSE F0."ig_conv_accelphone1k_subid" END) AS "ig_conv_accelphone1k_subid_integ", (CASE  WHEN (F0."ig_conv_accelwatch1k_year" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelwatch1k_year" END) AS "ig_conv_accelwatch1k_year_integ", (CASE  WHEN (F0."ig_conv_accelwatch1k_month" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelwatch1k_month" END) AS "ig_conv_accelwatch1k_month_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_x" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_x" END) AS "ig_conv_accelphone1k_x_integ", (CASE  WHEN (F0."ig_conv_accelwatch1k_x" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelwatch1k_x" END) AS "ig_conv_accelwatch1k_x_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_y" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_y" END) AS "ig_conv_accelphone1k_y_integ", (CASE  WHEN (F0."ig_conv_accelwatch1k_y" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelwatch1k_y" END) AS "ig_conv_accelwatch1k_y_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_z" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelphone1k_z" END) AS "ig_conv_accelphone1k_z_integ", (CASE  WHEN (F0."ig_conv_accelwatch1k_z" IS NULL) THEN (0)::bit(10) ELSE F0."ig_conv_accelwatch1k_z" END) AS "ig_conv_accelwatch1k_z_integ"
FROM (SELECT * FROM _temp_view_9) F0),
_temp_view_7 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."year1" AS "year1", F0."month1" AS "month1", F0."x" AS "x", F0."x1" AS "x1", F0."y" AS "y", F0."y1" AS "y1", F0."z" AS "z", F0."z1" AS "z1", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_actcode" AS "ig_conv_accelphone1k_actcode", F0."ig_conv_accelphone1k_actgroup" AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z", F0."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", F0."ig_conv_accelwatch1k_actcode" AS "ig_conv_accelwatch1k_actcode", F0."ig_conv_accelwatch1k_actgroup" AS "ig_conv_accelwatch1k_actgroup", F0."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z", F0."ig_conv_accelphone1k_subid_integ" AS "ig_conv_accelphone1k_subid_integ", F0."ig_conv_accelwatch1k_year_integ" AS "ig_conv_accelwatch1k_year_integ", F0."ig_conv_accelwatch1k_month_integ" AS "ig_conv_accelwatch1k_month_integ", F0."ig_conv_accelphone1k_x_integ" AS "ig_conv_accelphone1k_x_integ", F0."ig_conv_accelwatch1k_x_integ" AS "ig_conv_accelwatch1k_x_integ", F0."ig_conv_accelphone1k_y_integ" AS "ig_conv_accelphone1k_y_integ", F0."ig_conv_accelwatch1k_y_integ" AS "ig_conv_accelwatch1k_y_integ", F0."ig_conv_accelphone1k_z_integ" AS "ig_conv_accelphone1k_z_integ", F0."ig_conv_accelwatch1k_z_integ" AS "ig_conv_accelwatch1k_z_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_subid_integ" = F0."ig_conv_accelphone1k_subid") THEN '0000000000' ELSE hammingdist((F0."ig_conv_accelphone1k_subid_integ")::text, (F0."ig_conv_accelphone1k_subid")::text) END) AS "hamming_ig_conv_accelphone1k_subid_integ", hammingdist((F0."ig_conv_accelwatch1k_year_integ")::text, '0000000000') AS "hamming_ig_conv_accelwatch1k_year_integ", hammingdist((F0."ig_conv_accelwatch1k_month_integ")::text, '0000000000') AS "hamming_ig_conv_accelwatch1k_month_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_x_integ" = F0."ig_conv_accelphone1k_x") THEN '0000000000' ELSE hammingdist((F0."ig_conv_accelphone1k_x_integ")::text, (F0."ig_conv_accelphone1k_x")::text) END) AS "hamming_ig_conv_accelphone1k_x_integ", hammingdist((F0."ig_conv_accelwatch1k_x_integ")::text, '0000000000') AS "hamming_ig_conv_accelwatch1k_x_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_y_integ" = F0."ig_conv_accelphone1k_y") THEN '0000000000' ELSE hammingdist((F0."ig_conv_accelphone1k_y_integ")::text, (F0."ig_conv_accelphone1k_y")::text) END) AS "hamming_ig_conv_accelphone1k_y_integ", hammingdist((F0."ig_conv_accelwatch1k_y_integ")::text, '0000000000') AS "hamming_ig_conv_accelwatch1k_y_integ", (CASE  WHEN (F0."ig_conv_accelphone1k_z_integ" = F0."ig_conv_accelphone1k_z") THEN '0000000000' ELSE hammingdist((F0."ig_conv_accelphone1k_z_integ")::text, (F0."ig_conv_accelphone1k_z")::text) END) AS "hamming_ig_conv_accelphone1k_z_integ", hammingdist((F0."ig_conv_accelwatch1k_z_integ")::text, '0000000000') AS "hamming_ig_conv_accelwatch1k_z_integ"
FROM (SELECT * FROM _temp_view_8) F0),
_temp_view_6 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."year1" AS "year1", F0."month1" AS "month1", F0."x" AS "x", F0."x1" AS "x1", F0."y" AS "y", F0."y1" AS "y1", F0."z" AS "z", F0."z1" AS "z1", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_actcode" AS "ig_conv_accelphone1k_actcode", F0."ig_conv_accelphone1k_actgroup" AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z", F0."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", F0."ig_conv_accelwatch1k_actcode" AS "ig_conv_accelwatch1k_actcode", F0."ig_conv_accelwatch1k_actgroup" AS "ig_conv_accelwatch1k_actgroup", F0."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z", F0."ig_conv_accelphone1k_subid_integ" AS "ig_conv_accelphone1k_subid_integ", F0."ig_conv_accelwatch1k_year_integ" AS "ig_conv_accelwatch1k_year_integ", F0."ig_conv_accelwatch1k_month_integ" AS "ig_conv_accelwatch1k_month_integ", F0."ig_conv_accelphone1k_x_integ" AS "ig_conv_accelphone1k_x_integ", F0."ig_conv_accelwatch1k_x_integ" AS "ig_conv_accelwatch1k_x_integ", F0."ig_conv_accelphone1k_y_integ" AS "ig_conv_accelphone1k_y_integ", F0."ig_conv_accelwatch1k_y_integ" AS "ig_conv_accelwatch1k_y_integ", F0."ig_conv_accelphone1k_z_integ" AS "ig_conv_accelphone1k_z_integ", F0."ig_conv_accelwatch1k_z_integ" AS "ig_conv_accelwatch1k_z_integ", F0."hamming_ig_conv_accelphone1k_subid_integ" AS "hamming_ig_conv_accelphone1k_subid_integ", F0."hamming_ig_conv_accelwatch1k_year_integ" AS "hamming_ig_conv_accelwatch1k_year_integ", F0."hamming_ig_conv_accelwatch1k_month_integ" AS "hamming_ig_conv_accelwatch1k_month_integ", F0."hamming_ig_conv_accelphone1k_x_integ" AS "hamming_ig_conv_accelphone1k_x_integ", F0."hamming_ig_conv_accelwatch1k_x_integ" AS "hamming_ig_conv_accelwatch1k_x_integ", F0."hamming_ig_conv_accelphone1k_y_integ" AS "hamming_ig_conv_accelphone1k_y_integ", F0."hamming_ig_conv_accelwatch1k_y_integ" AS "hamming_ig_conv_accelwatch1k_y_integ", F0."hamming_ig_conv_accelphone1k_z_integ" AS "hamming_ig_conv_accelphone1k_z_integ", F0."hamming_ig_conv_accelwatch1k_z_integ" AS "hamming_ig_conv_accelwatch1k_z_integ", hammingdistvalue(F0."hamming_ig_conv_accelphone1k_subid_integ") AS "value_hamming_ig_conv_accelphone1k_subid_integ", hammingdistvalue(F0."hamming_ig_conv_accelwatch1k_year_integ") AS "value_hamming_ig_conv_accelwatch1k_year_integ", hammingdistvalue(F0."hamming_ig_conv_accelwatch1k_month_integ") AS "value_hamming_ig_conv_accelwatch1k_month_integ", hammingdistvalue(F0."hamming_ig_conv_accelphone1k_x_integ") AS "value_hamming_ig_conv_accelphone1k_x_integ", hammingdistvalue(F0."hamming_ig_conv_accelwatch1k_x_integ") AS "value_hamming_ig_conv_accelwatch1k_x_integ", hammingdistvalue(F0."hamming_ig_conv_accelphone1k_y_integ") AS "value_hamming_ig_conv_accelphone1k_y_integ", hammingdistvalue(F0."hamming_ig_conv_accelwatch1k_y_integ") AS "value_hamming_ig_conv_accelwatch1k_y_integ", hammingdistvalue(F0."hamming_ig_conv_accelphone1k_z_integ") AS "value_hamming_ig_conv_accelphone1k_z_integ", hammingdistvalue(F0."hamming_ig_conv_accelwatch1k_z_integ") AS "value_hamming_ig_conv_accelwatch1k_z_integ"
FROM (SELECT * FROM _temp_view_7) F0),
_temp_view_5 AS (
SELECT /*+ materialize */ F0."subid" AS "subid", F0."year1" AS "year1", F0."month1" AS "month1", F0."x" AS "x", F0."x1" AS "x1", F0."y" AS "y", F0."y1" AS "y1", F0."z" AS "z", F0."z1" AS "z1", F0."ig_conv_accelphone1k_subid" AS "ig_conv_accelphone1k_subid", F0."ig_conv_accelphone1k_actcode" AS "ig_conv_accelphone1k_actcode", F0."ig_conv_accelphone1k_actgroup" AS "ig_conv_accelphone1k_actgroup", F0."ig_conv_accelphone1k_year" AS "ig_conv_accelphone1k_year", F0."ig_conv_accelphone1k_month" AS "ig_conv_accelphone1k_month", F0."ig_conv_accelphone1k_x" AS "ig_conv_accelphone1k_x", F0."ig_conv_accelphone1k_y" AS "ig_conv_accelphone1k_y", F0."ig_conv_accelphone1k_z" AS "ig_conv_accelphone1k_z", F0."ig_conv_accelwatch1k_subid" AS "ig_conv_accelwatch1k_subid", F0."ig_conv_accelwatch1k_actcode" AS "ig_conv_accelwatch1k_actcode", F0."ig_conv_accelwatch1k_actgroup" AS "ig_conv_accelwatch1k_actgroup", F0."ig_conv_accelwatch1k_year" AS "ig_conv_accelwatch1k_year", F0."ig_conv_accelwatch1k_month" AS "ig_conv_accelwatch1k_month", F0."ig_conv_accelwatch1k_x" AS "ig_conv_accelwatch1k_x", F0."ig_conv_accelwatch1k_y" AS "ig_conv_accelwatch1k_y", F0."ig_conv_accelwatch1k_z" AS "ig_conv_accelwatch1k_z", F0."ig_conv_accelphone1k_subid_integ" AS "ig_conv_accelphone1k_subid_integ", F0."ig_conv_accelwatch1k_year_integ" AS "ig_conv_accelwatch1k_year_integ", F0."ig_conv_accelwatch1k_month_integ" AS "ig_conv_accelwatch1k_month_integ", F0."ig_conv_accelphone1k_x_integ" AS "ig_conv_accelphone1k_x_integ", F0."ig_conv_accelwatch1k_x_integ" AS "ig_conv_accelwatch1k_x_integ", F0."ig_conv_accelphone1k_y_integ" AS "ig_conv_accelphone1k_y_integ", F0."ig_conv_accelwatch1k_y_integ" AS "ig_conv_accelwatch1k_y_integ", F0."ig_conv_accelphone1k_z_integ" AS "ig_conv_accelphone1k_z_integ", F0."ig_conv_accelwatch1k_z_integ" AS "ig_conv_accelwatch1k_z_integ", F0."hamming_ig_conv_accelphone1k_subid_integ" AS "hamming_ig_conv_accelphone1k_subid_integ", F0."hamming_ig_conv_accelwatch1k_year_integ" AS "hamming_ig_conv_accelwatch1k_year_integ", F0."hamming_ig_conv_accelwatch1k_month_integ" AS "hamming_ig_conv_accelwatch1k_month_integ", F0."hamming_ig_conv_accelphone1k_x_integ" AS "hamming_ig_conv_accelphone1k_x_integ", F0."hamming_ig_conv_accelwatch1k_x_integ" AS "hamming_ig_conv_accelwatch1k_x_integ", F0."hamming_ig_conv_accelphone1k_y_integ" AS "hamming_ig_conv_accelphone1k_y_integ", F0."hamming_ig_conv_accelwatch1k_y_integ" AS "hamming_ig_conv_accelwatch1k_y_integ", F0."hamming_ig_conv_accelphone1k_z_integ" AS "hamming_ig_conv_accelphone1k_z_integ", F0."hamming_ig_conv_accelwatch1k_z_integ" AS "hamming_ig_conv_accelwatch1k_z_integ", F0."value_hamming_ig_conv_accelphone1k_subid_integ" AS "value_hamming_ig_conv_accelphone1k_subid_integ", F0."value_hamming_ig_conv_accelwatch1k_year_integ" AS "value_hamming_ig_conv_accelwatch1k_year_integ", F0."value_hamming_ig_conv_accelwatch1k_month_integ" AS "value_hamming_ig_conv_accelwatch1k_month_integ", F0."value_hamming_ig_conv_accelphone1k_x_integ" AS "value_hamming_ig_conv_accelphone1k_x_integ", F0."value_hamming_ig_conv_accelwatch1k_x_integ" AS "value_hamming_ig_conv_accelwatch1k_x_integ", F0."value_hamming_ig_conv_accelphone1k_y_integ" AS "value_hamming_ig_conv_accelphone1k_y_integ", F0."value_hamming_ig_conv_accelwatch1k_y_integ" AS "value_hamming_ig_conv_accelwatch1k_y_integ", F0."value_hamming_ig_conv_accelphone1k_z_integ" AS "value_hamming_ig_conv_accelphone1k_z_integ", F0."value_hamming_ig_conv_accelwatch1k_z_integ" AS "value_hamming_ig_conv_accelwatch1k_z_integ", (F0."value_hamming_ig_conv_accelphone1k_subid_integ" + F0."value_hamming_ig_conv_accelwatch1k_year_integ" + F0."value_hamming_ig_conv_accelwatch1k_month_integ" + F0."value_hamming_ig_conv_accelphone1k_x_integ" + F0."value_hamming_ig_conv_accelwatch1k_x_integ" + F0."value_hamming_ig_conv_accelphone1k_y_integ" + F0."value_hamming_ig_conv_accelwatch1k_y_integ" + F0."value_hamming_ig_conv_accelphone1k_z_integ" + F0."value_hamming_ig_conv_accelwatch1k_z_integ") AS "Total_Distance", ((F0."value_hamming_ig_conv_accelphone1k_subid_integ" + F0."value_hamming_ig_conv_accelwatch1k_year_integ" + F0."value_hamming_ig_conv_accelwatch1k_month_integ" + F0."value_hamming_ig_conv_accelphone1k_x_integ" + F0."value_hamming_ig_conv_accelwatch1k_x_integ" + F0."value_hamming_ig_conv_accelphone1k_y_integ" + F0."value_hamming_ig_conv_accelwatch1k_y_integ" + F0."value_hamming_ig_conv_accelphone1k_z_integ" + F0."value_hamming_ig_conv_accelwatch1k_z_integ") / 9) AS "Average_Distance"
FROM (SELECT * FROM _temp_view_6) F0),
_temp_view_4 AS (
SELECT /*+ materialize */ F0."i_subid" AS "i_subid", F0."i_year1" AS "i_year1", F0."i_month1" AS "i_month1", F0."i_x" AS "i_x", F0."i_y" AS "i_y", F0."i_z" AS "i_z", F0."pattern_IG" AS "pattern_IG", F0."coverage" AS "coverage", F0."informativeness" AS "informativeness", (((3 * (F0."pattern_IG" * F0."coverage" * F0."informativeness")) / (F0."pattern_IG" + F0."coverage" + F0."informativeness")))::float8 AS "fscoreTopK"
FROM (
SELECT F0."i_subid" AS "i_subid", F0."i_year1" AS "i_year1", F0."i_month1" AS "i_month1", F0."i_x" AS "i_x", F0."i_y" AS "i_y", F0."i_z" AS "i_z", F0."pattern_IG" AS "pattern_IG", F0."coverage" AS "coverage", F0."informativeness" AS "informativeness"
FROM (
SELECT F0."subid" AS "i_subid", F0."year1" AS "i_year1", F0."month1" AS "i_month1", F0."x" AS "i_x", F0."y" AS "i_y", F0."z" AS "i_z", SUM(F0."Total_Distance") AS "pattern_IG", COUNT(1) AS "coverage", ((CASE  WHEN (NOT ((F0."subid" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."year1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."month1" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."x" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."y" IS NULL))) THEN 1 ELSE 0 END) + (CASE  WHEN (NOT ((F0."z" IS NULL))) THEN 1 ELSE 0 END)) AS "informativeness"
FROM (SELECT * FROM _temp_view_5) F0
GROUP BY CUBE (F0."subid", F0."year1", F0."month1", F0."x", F0."y", F0."z")) F0
--WHERE ((F0."pattern_IG" > 0) AND ((F0."coverage" > 1) OR ((F0."coverage" = 1) AND (F0."informativeness" = 6))))
) F0
--WHERE ((F0."coverage" > 1) AND (F0."informativeness" < 6))
)
SELECT * FROM _temp_view_4;


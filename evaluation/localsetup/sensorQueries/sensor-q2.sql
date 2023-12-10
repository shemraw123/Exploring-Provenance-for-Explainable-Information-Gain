SELECT p.subid, w.year, w.month, p.x, w.x, p.y, w.y, p.z, w.z FROM accelphone p JOIN accelwatch w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 OR w.year = 2020



-- use this query
SELECT p.subid, w.year, w.month, p.x, w.x, p.y, w.y, p.z, w.z FROM accelphone00001 p JOIN accelwatch00001 w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 AND w.year = 2020


SELECT p.subid, w.year, w.month, p.x, w.x, p.y, w.y, p.z, w.z FROM accelphone4m p JOIN accelwatch4m w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 AND w.year = 2020


new updated query : 


./scripts/dev/debug_gprom.sh 3 "IG OF (SELECT p.subid, p.actcode, p.actgroup, w.year, w.month, w.x, w.y, w.z FROM data_accel_phone_1k p JOIN data_accel_watch_1k w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 OR w.year = 2020);"

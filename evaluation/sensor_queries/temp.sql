./scripts/dev/debug_gprom.sh 3 "IG OF (SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone100k p JOIN gyrowatch100k w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015);"

./scripts/dev/debug_gprom.sh 3 "IG OF (SELECT p.subid, w.year, w.month, p.x, w.x, p.y, w.y, p.z, w.z FROM accelphone1k p JOIN accelwatch1k w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 AND w.year = 2020);"

./scripts/dev/debug_gprom.sh 3 "IG OF (SELECT g.subId, g.actgroup, CASE WHEN (g.actcode = a.actcode) THEN a.actcode ELSE g.actcode END AS actcode, a.year, a.month, g.x, g.y, g.z FROM accelphone1k a JOIN gyrophone1k g ON (g.subId = a.subId AND g.actgroup = a.actgroup AND g.year = a.year AND g.month = a.month) WHERE g.subid = 1640 AND g.x > 3);"

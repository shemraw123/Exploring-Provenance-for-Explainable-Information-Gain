SELECT g.subId, g.actcode, g.actgroup, CASE WHEN (g.year = a.year) THEN a.year ELSE g.year END AS year, CASE WHEN (g.month = a.month) THEN a.month ELSE g.month END AS month, g.x, g.y, g.z FROM accelphone a JOIN gyrophone g ON (g.subId = a.subId AND g.actgroup = a.actgroup)

SELECT g.subId, g.actgroup, CASE WHEN (g.actcode = a.actcode) THEN a.actcode ELSE g.actcode END AS actcode, a.year, a.month, g.x, g.y, g.z FROM accelphone100k a JOIN gyrophone100k g ON (g.subId = a.subId AND g.actgroup = a.actgroup)


-- use this query
SELECT g.subId, g.actgroup, CASE WHEN (g.actcode = a.actcode) THEN a.actcode ELSE g.actcode END AS actcode, a.year, a.month, g.x, g.y, g.z FROM accelphone1m a JOIN gyrophone1m g ON (g.subId = a.subId AND g.actgroup = a.actgroup AND g.year = a.year AND g.month = a.month) WHERE g.subid = 1640 AND g.x > 3
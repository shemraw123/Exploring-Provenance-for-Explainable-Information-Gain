SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone p JOIN gyrowatch w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015


-- use this query
SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone00001 p JOIN gyrowatch1m w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015


SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone00001 p JOIN gyrowatch00001 w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015



SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone1k p JOIN gyrowatch1k w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015

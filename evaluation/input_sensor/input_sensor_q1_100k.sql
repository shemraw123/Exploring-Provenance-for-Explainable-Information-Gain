SELECT p.subId, p.actgroup, w.actcode, p.year, p.month, w.x, w.y, w.z FROM gyrophone100k p JOIN gyrowatch100k w ON p.subId = w.subId AND p.year = w.year AND p.month = w.month WHERE w.year = 2015

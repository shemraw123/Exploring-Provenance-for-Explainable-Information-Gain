SELECT p.subid, w.year, w.month, p.x, w.x, p.y, w.y, p.z, w.z FROM accelphone10k p JOIN accelwatch10k w ON (p.actcode = w.actcode AND p.actgroup = w.actgroup AND p.subId = w.subId) WHERE p.year = 2020 AND w.year = 2020

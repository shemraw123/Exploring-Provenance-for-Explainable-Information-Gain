SELECT CASE WHEN (ap.year = gp.year) THEN ap.year ELSE gp.year END year, 
    CASE WHEN (ap.month = gp.month) THEN ap.month ELSE gp.month END month,
    CASE WHEN (aw.actcode = gw.actcode) THEN aw.actcode ELSE gw.actcode END actcode,
    CASE WHEN (aw.actgroup = gw.actgroup) THEN aw.actgroup ELSE gw.actgroup END actgroup,
FROM data_accel_phone ap
    JOIN data_accel_watch aw ON (ap.subjectId = aw.subjectId)
        JOIN data_gyro_phone gp ON ap.subjectId = gp.subjectId 
            JOIN data_gyro_watch gw ON ap.subjectId = gw.subjectId; 
SELECT o.county, o.year, CASE WHEN (s.maqi > 100 AND (s.gdays IS NOT NULL)) THEN s.gdays ELSE o.dayswaqi END AS dayswaqi, s.gdays, o.maqi from owned1m o FULL OUTER JOIN shared1m s ON (o.county = s.county AND o.year = s.year); 
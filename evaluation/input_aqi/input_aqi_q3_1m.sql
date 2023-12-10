SELECT s.county, s.year, o.dayswaqi, s.gdays, o.maqi FROM owned1m o JOIN shared1m s ON (o.maqi = s.maqi) WHERE o.dayswaqi >= 1 AND o.dayswaqi <= 5

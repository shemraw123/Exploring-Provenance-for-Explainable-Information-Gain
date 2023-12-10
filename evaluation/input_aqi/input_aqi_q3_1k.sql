SELECT s.county, s.year, o.dayswaqi, s.gdays, o.maqi FROM owned1k o JOIN shared1k s ON (o.maqi = s.maqi) WHERE o.dayswaqi >= 1 AND o.dayswaqi <= 5

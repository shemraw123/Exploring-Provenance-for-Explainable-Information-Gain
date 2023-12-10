SELECT s.county, s.year, o.dayswaqi, s.gdays, o.maqi FROM owned100k o JOIN shared100k s ON (o.maqi = s.maqi) WHERE o.dayswaqi >= 1 AND o.dayswaqi <= 5

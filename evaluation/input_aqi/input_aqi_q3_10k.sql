SELECT s.county, s.year, o.dayswaqi, s.gdays, o.maqi FROM owned10k o JOIN shared10k s ON (o.maqi = s.maqi) WHERE o.dayswaqi >= 1 AND o.dayswaqi <= 5

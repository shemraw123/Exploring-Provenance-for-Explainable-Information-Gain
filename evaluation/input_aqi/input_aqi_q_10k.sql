SELECT s.county, s.year, s.maqi, s.gdays, o.dayswaqi FROM owned10k o JOIN shared10k s ON (s.county = o.county AND s.year = o.year)
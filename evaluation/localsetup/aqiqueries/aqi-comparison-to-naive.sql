SELECT s.county, s.year, s.maqi, s.gdays, o.dayswaqi FROM owned o JOIN shared s ON (s.county = o.county AND s.year = o.year)
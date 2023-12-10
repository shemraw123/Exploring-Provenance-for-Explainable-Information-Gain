SELECT o.county, o.year, s.gdays, o.maqi, o.dayswaqi FROM owned o JOIN shared s ON (o.county = s.county AND o.year = s.year) WHERE s.gdays < 100

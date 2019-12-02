library(readr)
All_Mango <- read_csv("Project_Python3/Competitor Locations/Mango/All_Mango.csv") # Read all Mango store locations (include lat, lon)


library(sp)
library(rworldmap)

coords2country = function(points)
{  
  countriesSP <- getMap(resolution='low')
  pointsSP = SpatialPoints(points, proj4string=CRS(proj4string(countriesSP)))  
  indices = over(pointsSP, countriesSP)
  
  # return the ADMIN names of each country
  indices$ADMIN  

}

points = data.frame(lon=All_Mango$longitude, lat=All_Mango$latitude)
All_Mango$Country = coords2country(points)

write.csv(All_Mango, 'All_Mango_Ctry.csv')

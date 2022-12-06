library("leaflet")
library("tmap") 

latitude <- 22.3116452
longitude <- 114.1767885

leaflet() %>% 
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  setView(lat = latitude, lng = longitude, zoom = 12) %>%
  addScaleBar() %>% 
  addMiniMap() ## minimap


#### Dataframe with Latitude and Longitude values for each of data points that want to be denoted in the map
df <- data.frame(Lat = runif(5, min=22.3016452, max=22.3216452), 
                 Lon = runif(5, min=114.1667885, max=114.1867885),
                 Location = c("Location A", "Location B", "Location C", "Location D", "Location E"))

#denote lcoations of the data points which you want to display by addMarkers() function
leaflet() %>%
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  setView(lat = latitude, lng = longitude, zoom = 12) %>%
  addScaleBar() %>%
  addMiniMap() %>%
  addMarkers(data = df, lng = ~Lon, lat = ~Lat, label = ~Location) 

#change to circle marker
leaflet() %>%
  addProviderTiles("OpenStreetMap.Mapnik") %>%
  setView(lat = latitude, lng = longitude, zoom = 12) %>%
  addScaleBar() %>%
  addMiniMap() %>%
  addCircleMarkers(data = df, lng = ~Lon, lat = ~Lat, label = ~Location) 

# Topographic maps

latitude <- 39.7837304
longitude <- -100.445882

# Load specified data sets. Dataset "World" provides the data of the boundaries of countries. "land" provides the topographic data such as elevation.
data(World, land)

# tmap mode set to plotting "interactive map"
tmap_mode("view")

tm_shape(land) + tm_raster("elevation", palette = terrain.colors(10))

# Combine the topographic data and the data of the boundaries of countries together and add the country name
p <- tm_shape(land) +
  tm_raster("elevation", palette = terrain.colors(10)) +
  tm_shape(World) +
  tm_borders("white", lwd = 1.5) +
  tm_text("name", size = "AREA") 
p

# Customize the interactive map. Configure United States as initial view in the map.
p +
  tm_basemap(leaflet::providers$Esri.WorldTopoMap) +
  tm_view(set.view = c(lon = longitude, lat = latitude, zoom = 4)) +
  tm_legend(show = TRUE) 

# Thematic maps

data(quakes)
head(quakes)

# 1) Define handmade bins for the Richter magnitude. Find the min and max values of "mag" variable first.
mybins <- seq(4, 6.5, by=0.5)
# 2) Mapping data values (numeric or factor/character) to colors according to a given palette
mypalette <- colorBin(palette="Oranges", domain=quakes$mag, na.color="transparent", bins=mybins)
# Prepare the text for the tooltip (interactive message which appears when a cursor is positioned over an element in a graphical user interface)
mytext <- paste("Depth: ", quakes$depth, "<br/>", 
                "Stations: ", quakes$stations, "<br/>", 
                "Magnitude: ", quakes$mag, sep="") %>%
  lapply(htmltools::HTML)  # Mark Characters as HTML by package "htmltools"

leaflet() %>% 
  addTiles() %>%
  addProviderTiles("Esri.NatGeoWorldMap") %>%
  setView(lat=latitude, lng=longitude , zoom=5)

#France
latitude <- 46.603354
longitude <- 1.8883335

leaflet() %>% 
  addProviderTiles("Stamen.TonerLite") %>%
  setView(lat = latitude, lng = longitude, zoom = 6) %>%
  addScaleBar() %>% 
  addMiniMap() 
library("ggplot2")
library("dplyr")
library("leaflet")
library("RColorBrewer")
library("htmltools")
library("ggbeeswarm")
library("ggridges")   
library("gcookbook") # Load gcookbook for the uspopage data set


df.adult <- read.csv(file = 'adult.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.salaries <- read.csv(file = 'salaries.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 

# Interactive Graphics

#basic interactive map
leaflet() %>% addTiles()

# add scale bar and minimap to the map (location of Tokyo, latitude and longitude coordinates are: 35.652832, 139.839478)
leaflet() %>% 
  addTiles() %>%
  addScaleBar() %>% 
  setView(lng = 139.83, lat = 35.65, zoom = 10) %>% 
  addMiniMap()

# The data set gives the locations (coordinates of latitude and longitude) and other information, such as depth and Richter magnitude, of 1000 seismic events occurred near Fiji since 1964. Load example data. 
data(quakes)
quakes

summary(quakes)

mybins <- seq(4, 6.5, by=0.5)
mypalette <- colorBin( palette="Oranges", domain=quakes$mag, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- paste("Depth: ", quakes$depth, "<br/>", 
                "Stations: ", quakes$stations, "<br/>", 
                "Magnitude: ", quakes$mag, sep="") %>%
  lapply(htmltools::HTML)  # Mark Characters as HTML by package "htmltools"

map <- leaflet(quakes) %>% 
  addTiles()  %>% 
  setView( lat=-27, lng=170 , zoom=3) %>%
  addProviderTiles("Esri") %>%
  addCircleMarkers(~long, ~lat, 
                   fillColor = ~mypalette(mag), fillOpacity = 0.9, radius=2, stroke=FALSE,
                   label = mytext,
                   labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~mag, opacity=0.9, title = "Magnitude", position = "topright" )


map

quakes <- read.csv(file = 'Japan earthquakes 2001-2018.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
quakes

# Create a color palette with handmade bins.
mybins <- seq(4.5, 9.5, by=1)
mypalette <- colorBin( palette="Reds", domain=quakes$mag, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- paste("Depth: ", quakes$depth, "<br/>", 
                "Place: ", quakes$place, "<br/>", 
                "Magnitude: ", quakes$mag, sep="") %>%
  lapply(htmltools::HTML)


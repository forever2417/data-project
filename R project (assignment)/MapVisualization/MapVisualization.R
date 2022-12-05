library("ggplot2")
library("treemapify")
library("ggridges")          
library("dplyr")
library("ggbeeswarm")
library("lattice")
library("vcd")
library("maps")
library("viridis") # virids package for the color palette

##Bubble map
#(GPS coordinates) turn map data from the maps package in to a data frame suitable for plotting with ggplot2 
df.world <- map_data("world")
df.world

head(unique(df.world$region),20)

region <- map_data("world") %>% filter(region=="Australia")
region

data(world.cities)   
data_nv <- world.cities %>% filter(country.etc=="Australia")
data_nv

ggplot() +
  geom_polygon(data = region, aes(x=long, y = lat, group = group), fill="grey", alpha=0.9) +   #the zone filled by grey color with transparency (alpha=0.9)
  geom_point(data = data_nv,  aes(x=long, y=lat, size=pop, color=pop), alpha=0.9)  #the bubble with transparency (alpha=0.9)


ggplot() +
  geom_polygon(data = region, aes(x=long, y = lat, group = group), fill="grey", alpha=0.9) +
  geom_point(data = data_nv,  aes(x=long, y=lat, size=pop, color=pop), alpha=0.9) +
  scale_size_continuous(name="Population", trans="identity")  +       #Built-in scale transformations include "identity", "log", "log10"
  scale_color_viridis(name="Population (in log)", trans="log") +   
  theme_void() + 
  theme(legend.position="right",
        legend.title = element_text(colour="blue", size=10, face="bold"),   #Change the legend title and text font styles
        legend.text = element_text(colour="red", size=8, face="italic")    
  ) +
  labs(title = "Bubble map: Population of the Australia.",
       subtitle = "Showing the biggest cities with population of the Australia."
  ) 

##Choropleth map
states_map <- map_data("state")
states_map

p <- ggplot(data = states_map,
            mapping = aes(x = long, y = lat,
                          group = group))

p + geom_polygon(fill = "white", color = "black")

p <- ggplot(data = states_map,
            aes(x = long, y = lat,
                group = group, fill = region))

#color = "white", size = 0.1: white and thin lines to make the state borders clearly.
#guides(fill = FALSE): not to plot a legend.
p + geom_polygon(color = "white", size = 0.1) + guides(fill = FALSE)   

###############US murder rate map visualization**************************

crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimes
# Merge the USArrests data set and pre-drawn map data set together
crime_map <- merge(states_map, crimes, by.x = "region", by.y = "state")

# After merging, the order has changed, which would lead to polygons drawn in the incorrect order. So, we'll sort the data.
crime_map
# set fill = Murder to display murder rates
p <- ggplot(data = crime_map,
            aes(x = long, y = lat,
                group = group, fill = Murder))

#color = "white", size = 0.1: white and thin lines to make the state borders clearly.
#guides(fill = FALSE): not to plot a legend.
#The Albers projection requires two latitude parameters, lat0 and lat1. We give them their conventional values for a US map here. (Try change their values and see what happens when you redraw the map.)

p + geom_polygon(color = "white", size = 0.1)  +
  theme_void() +
  labs(title = "Choropleth map: Murder rates by US state",
       subtitle = "Number of murder rates per US state",
       caption = "Source: https://socviz.co/maps.html") +
  theme(plot.title = element_text(size= 15, hjust=0.01, color = "black"),
        plot.subtitle = element_text(size= 12, hjust=0.01, color = "black"),
        plot.caption = element_text( size=10, color = "black"),
        legend.position = "right") +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)   

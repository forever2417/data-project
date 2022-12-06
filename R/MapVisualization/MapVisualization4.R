library("gapminder")
library("ggplot2")
library("plotly")

df.climate <- read.csv(file = 'data/DailyDelhiClimate.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")
# convert the character type to class "Date" representing calendar dates.
df.climate$date <- as.Date(df.climate$date, "%m/%d/%Y")

#import data, map variable "date" and "wind_speed" to x and y axis respectively
ggplot(df.climate, aes(x=date, y=wind_speed)) +    
  #add GEOM_FUNCTION
  geom_line()

fig <- plot_ly(df.climate, 
               x = ~date, 
               y = ~wind_speed, 
               type = 'scatter', 
               mode = 'lines')
fig

#Interactive multiple lines chart for wind speed, mean temperature and humidity
fig <- plot_ly(df.climate, 
               x = ~date, 
               y = ~wind_speed, 
               name = 'Wind speed',
               type = 'scatter', 
               mode = 'lines') 
fig <- fig %>% add_trace(y = ~meantemp, 
                         name = 'Mean temperature', 
                         mode = 'lines') 
fig <- fig %>% add_trace(y = ~humidity, 
                         name = 'Humidity', 
                         mode = 'lines') 
fig


#Customization on the chart. The customization can be done by layout() function.
fig <- plot_ly(df.climate, 
               x = ~date, 
               y = ~wind_speed, 
               name = 'Wind speed',
               type = 'scatter', 
               mode = 'lines+markers') 
fig <- fig %>% add_trace(y = ~meantemp, 
                         name = 'Mean temperature', 
                         mode = 'lines+markers') 
fig <- fig %>% add_trace(y = ~humidity, 
                         name = 'Humidity', 
                         mode = 'markers') 
fig <- fig %>% layout(title = "Daily climate data in the city of Delhi", 
                      xaxis = list(title = "Date", 
                                   color = "red"), 
                      yaxis = list(title = ""), 
                      legend = list(title=list(text='<b> Weather data </b>'))
)
fig

# Import the Stroke Prediction Dataset
df.healthcare <- read.csv(file = 'data/healthcare-dataset-stroke-data.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent)) +                 
  geom_point() +  
  ggtitle("Relationship between GDP per capita and life expectancy") +
  labs(x = "GDP per capita (US$, inflation-adjusted)", y = "Life expectancy at birth, in years") +   
  scale_x_continuous(breaks = seq(0,113524,10000))  +                      
  scale_y_continuous(breaks = seq(0,100,10))   

fig <- plot_ly(df.healthcare, y = ~bmi, color = ~smoking_status, type = "box")
#basic chart
fig

fig <- plot_ly(df.healthcare, y = ~bmi, color = ~smoking_status, type = "box")
#basic chart
fig

fig <- plot_ly(gapminder,
               x = ~gdpPercap, 
               y = ~lifeExp, 
               size = ~pop, 
               color = ~continent, 
               text = ~country, 
               hoverinfo = "text",
               type = 'scatter',
               mode = 'markers')
fig

#Basic animation on the scatter plot by adding the time frame
fig <- plot_ly(gapminder,
               x = ~gdpPercap, 
               y = ~lifeExp, 
               size = ~pop, 
               color = ~continent, 
               frame = ~year,      #add the time frame for the animation
               text = ~country, 
               hoverinfo = "text",
               type = 'scatter',
               mode = 'markers')
fig

#Customization on the animation
fig <- fig %>% layout(title = "Relationship between GDP per capita and life expectancy",
                      xaxis = list(title = "GDP per capita (US$, inflation-adjusted)",
                                   type = "log"),
                      yaxis = list(title = "Life expectancy at birth, in years"))

fig

# import the modified daily climate time series data.
df.climate <- read.csv(file = 'data/DailyDelhiClimate.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")
#select the data in January 2013 only, total 31 days.
df.climate <- df.climate[c(1:31),]
df.climate$date <- seq(1:31)

fig <- plot_ly(df.climate,
               x = ~meantemp, 
               y = ~humidity, 
               size = ~wind_speed, 
               frame = ~date, 
               text = ~meanpressure, 
               hoverinfo = "text",
               type = 'scatter',
               mode = 'markers',
               showlegend = FALSE)
fig <- fig %>% layout(title = "Relationship between mean temperature, humidity, wind speed and pressure in January 2013",
                      xaxis = list(title = "Mean temperature"),
                      yaxis = list(title = "Humidity"))

fig
# Import the Drug Classification Dataset
df.drug <- read.csv(file = 'data/drug.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")

#Basic 3D scatter plot
fig <- plot_ly(df.drug, 
               x = ~ Age, 
               y = ~Na_to_K, 
               z = ~BP, 
               color = ~Drug,
               type = 'scatter3d',
               mode = 'markers')
fig

#Customization on the 3D scatter plot
fig <- plot_ly(df.drug, 
               x = ~ Age, 
               y = ~Na_to_K, 
               z = ~BP, 
               color = ~Drug,
               type = 'scatter3d',
               mode = 'markers')
fig <- fig %>% layout(title = "Relationship between the age, Sodium to Potassium ration and blood pressure levels",
                      legend = list(title=list(text="<b> Drug type for patient </b>")),
                      scene = list(xaxis = list(title = 'x-axis: Age of the patient'),
                                   yaxis = list(title = 'y-axis: Sodium (Na) to Potassium (K) ration'),
                                   zaxis = list(title = 'z-axis: Blood pressure levels')))

fig

# Import the dataset "uspopage" about the age distribution of population in the United States, 1900-2002
data(uspopage, package="gcookbook")

fig <- plot_ly(uspopage, 
               x = ~Year, 
               y = ~Thousands, 
               z = ~AgeGroup, 
               type = 'scatter3d', 
               mode = 'lines',
               color = ~AgeGroup)

fig

#Customization on the 3D line chart
fig <- plot_ly(uspopage, 
               x = ~Year, 
               y = ~Thousands, 
               z = ~AgeGroup, 
               type = 'scatter3d', 
               mode = 'lines',
               color = ~AgeGroup,
               #set the transparency of the line by opacity
               opacity = 0.8,
               #set the width of the line
               line = list(width = 5))

fig <- fig %>% layout(title = "Age distribution of population in the United States, 1900-2002",
                      scene = list(xaxis = list(title = 'x-axis: Date in year'),
                                   yaxis = list(title = 'y-axis: Number of people, in thousands'),
                                   zaxis = list(title = 'z-axis: Age group of population')))

fig


#Surface plots
x = c(1,2,3,4,5,6)
y = c(1,2,3,4,5)
z = rbind(c(0, 1, 0, 1, 0, 1),
          c(1, 0, 1, 0, 1, 0),
          c(0, 1, 0, 1, 0, 1),
          c(1, 0, 1, 0, 1, 0),
          c(0, 1, 0, 1, 0, 1))
#z is a matrix:
z

fig <- plot_ly(x = ~x,
               y = ~y,
               z = ~z,
               type = 'surface')

fig

#Customization on the surface plot
fig <- fig %>% layout(title = "3D surface plot for x, y and z",
                      scene = list(xaxis = list(title = 'x-axis: 1-6'),
                                   yaxis = list(title = 'y-axis: 1-5'),
                                   zaxis = list(title = 'z-axis: 0-1'),
                                   # axes are drawn in proportion with the input of "aspectratio"
                                   aspectratio = list(x = 1, y = 0.5, z = 0.5)))

fig

#import dataset
data(VADeaths)

#Load plot3D package for 3D histogram
library("plot3D")
hist3D(z = VADeaths)

hist3D(x = 1:5, y = 1:4, z = VADeaths,
       phi = 30,  theta = -70,
       xlab = "", ylab = "", zlab = "", main = "Death Rates in Virginia (1940)",
       border = "black", shade = 0.5,
       ticktype = "detailed", space = 0.5, d = 2)
# Use text3D to label and position x axis
text3D(x = 1:5, y = rep(0.3, 5), z = rep(5, 5),
       labels = rownames(VADeaths),
       add = TRUE, adj = -0.5)
# Use text3D to label and position y axis
text3D(x = rep(1, 4),   y = 1:4, z = rep(-10, 4),
       labels  = colnames(VADeaths),
       add = TRUE, adj = 1)

# Import the Stroke Prediction Dataset
df.healthcare <- read.csv(file = 'data/healthcare-dataset-stroke-data.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")
df.healthcare$hypertension <- as.character(df.healthcare$hypertension)

fig <- plot_ly(df.healthcare, 
               x = ~ age, 
               y = ~avg_glucose_level, 
               z = ~bmi, 
               color = ~hypertension,
               type = 'scatter3d',
               mode = 'markers',
               size = 0.5)
fig <- fig %>% layout(title = "Relationship between Age, Average glucose level and BMI",
                      legend = list(title=list(text="<b> 0: no hypertension<br> 1: hypertension </b>")),
                      scene = list(xaxis = list(title = 'x-axis: Age of the patient'),
                                   yaxis = list(title = 'y-axis: Average glucose level in blood (mg/dL)'),
                                   zaxis = list(title = 'z-axis: Body mass index')))

fig
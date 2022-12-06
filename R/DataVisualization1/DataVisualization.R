library("ggplot2")
library("ggpubr")

df.adult <- read.csv(file = 'adult.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.glass <- read.csv(file = 'glass.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.salaries <- read.csv(file = 'salaries.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 

#salary data visualization
plot1 <- ggplot(df.salaries, aes(x=salary, y=yrs.service, color = rank)) +                 
  geom_point()  

plot2 <- ggplot(df.salaries, aes(x=rank, fill = sex)) +                 
  geom_histogram(stat="count") 

plot3 <- ggplot(df.salaries, aes(x=rank, fill = discipline)) +                 
  geom_bar(position="stack", stat="count") 

#option1
ggarrange(plot1, plot2, plot3, 
          labels = c("Plot 1", "Plot 2", "Plot 3"),
          ncol = 2, nrow = 2)

#option2
ggarrange(plot1, plot2, plot3, 
          labels = c("Plot 1", "Plot 2", "Plot 3"),
          ncol = 2, 
          nrow = 2, 
          common.legend = FALSE, legend= "top",
          label.x = 0.5, label.y = 1
)  

#option3
ggarrange(plot1, plot2, plot3, 
          labels = c("Plot 1", "Plot 2", "Plot 3"),
          ncol = 1, nrow = 3,                       #change the appearance of the combination of the plots
          common.legend = FALSE, legend= "top",
          label.x = 0.1, label.y = 1,           
          font.label = list(size = 20, face ="bold.italic", color ="blue"))


#iris data visualization
p <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + geom_point(pch=15, cex=3)
p + theme_bw() # dark-on-light ggplot2 theme
p + theme_linedraw() 


ggplot(df.glass, aes(x=Si, y=Na, color = Type)) + geom_point() 

#adult dataset data visualization
#plot 1
ggplot(data = df.adult, mapping = aes(x = Annual_income)) +  geom_bar(position = "identity")

#plot 2
ggplot(data = df.adult, mapping = aes(x = Relationship)) +   geom_bar(position = "identity")

#plot 3
ggplot(data = df.adult, mapping = aes(x = Race)) + geom_bar(position = "identity") 

#plot 4
ggplot(data = df.adult, mapping = aes(x = Sex)) +  geom_bar(position = "identity") 

plot <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()
plot

#use "mean" as summary function and "line" as geometric object to display the summary data. 
plot + stat_summary(fun = mean, colour = "red", size = 2, geom = "line")  

#diamonds data visualization
ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar()

ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")    

ggplot(diamonds, aes(x = price, y = carat, color = cut)) + geom_point()    

ggplot(diamonds, aes(x = price, y = carat, color = cut)) +geom_point(position="jitter")  

ggplot(diamonds, aes(x=price, fill=cut)) + geom_histogram() 

#glass data visualization
ggplot(df.glass, aes(x=Si, y=K, color = Type)) + geom_point()



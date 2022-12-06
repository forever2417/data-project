library("ggplot2")
library("treemapify")
library("ggridges")          
library("dplyr")
library("ggbeeswarm")
library("lattice")
library("vcd")
library("ggcorrplot")

df.adult <- read.csv(file = 'adult.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.glass <- read.csv(file = 'glass.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.salaries <- read.csv(file = 'salaries.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 

#adult data visualization

#glass data visualization
xyplot(RI~Na | Type, 
       data=df.glass, 
       layout = c(1, 6), 
       xlab=list(label="Sodium", cex=3), 
       ylab=list(label="Refractive index", cex=3), 
       scales=list(cex=2)) #cex: the text size along both axes

xyplot(RI~Mg | Type, 
       data=df.glass, 
       layout = c(2, 3), 
       xlab=list(cex=3), 
       ylab=list(cex=3), 
       scales=list(cex=2))   
xyplot(yrs.service~salary | rank, data=df.salaries, xlab = "Academic salaries", ylab = "Service years")      
bwplot(yrs.service~salary | rank, data=df.salaries, xlab = "Academic salaries", ylab = "Service years")
barchart(yrs.service~salary | rank, data=df.salaries, xlab = "Academic salaries", ylab = "Service years") 
histogram(yrs.service~salary | rank, data=df.salaries, xlab = "Academic salaries", ylab = "Service years")   
#salaries data visualization
ggplot(df.salaries, aes(x = salary, y = rank, color = sex)) + geom_point() 

ggplot(df.salaries, aes(x = salary, y = rank, color = sex)) + geom_point(size = 3)  

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + geom_jitter() 

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + geom_jitter(width = 0.2, height = 0.2) 

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + 
  geom_jitter(width = 0.3, height = 0.3) +
  geom_boxplot(alpha = 0.5,
               size=0.1,
               outlier.shape = 8,
               outlier.color = "red",
               outlier.size  = 5)

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + 
  geom_quasirandom(groupOnX=FALSE)

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + 
  geom_quasirandom(groupOnX=FALSE, dodge.width=0.5)   

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + 
  geom_jitter()

ggplot(df.salaries, aes(y = rank, x = salary, color = sex)) + 
  geom_quasirandom(groupOnX=FALSE, dodge.width=0.5)   

#correlation matrix
cor(mtcars)      

corr <- round(cor(mtcars), 1)   # Rounding of numbers to 1 decimal place 

ggcorrplot(corr, lab = TRUE)

ggcorrplot(corr, method = "circle", lab = TRUE)

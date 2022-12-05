library("ggplot2")
library("ggpubr")

df.adult <- read.csv(file = 'R_DV_Lesson_1_adult.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.glass <- read.csv(file = 'R_DV_Lesson_1_glass.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.salaries <- read.csv(file = 'R_DV_Lesson_1_salaries.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 

plot1 <- ggplot(df.salaries, aes(x=salary, y=yrs.service, color = rank)) +                 
  geom_point()  

plot2 <- ggplot(df.salaries, aes(x=rank, fill = sex)) +                 
  geom_histogram(stat="count") 

plot3 <- ggplot(df.salaries, aes(x=rank, fill = discipline)) +                 
  geom_bar(position="stack", stat="count") 

ggarrange(plot1, plot2, plot3, 
          labels = c("Plot 1", "Plot 2", "Plot 3"),
          ncol = 2, nrow = 2)

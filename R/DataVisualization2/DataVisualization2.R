library("ggplot2")
library("treemapify")
library("ggridges")          
library("dplyr") 

df.adult <- read.csv(file = 'adult.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.glass <- read.csv(file = 'glass.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 
df.salaries <- read.csv(file = 'salaries.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",") 

#adult data visualization
ggplot(df.adult, aes(Education)) +                 
  geom_bar()+ 
  coord_flip()

ggplot(df.adult, aes(Education)) +                 
  geom_bar(aes(fill = Annual_income))+ 
  coord_flip() 

ggplot(df.adult, aes(Education)) +                 
  geom_bar(aes(fill = WorkClass))  +
  #geom_bar(aes(fill = Marital_status))  +
  #geom_bar(aes(fill = Occupation))  +  
  #geom_bar(aes(fill = Relationship))  +  
  #geom_bar(aes(fill = Sex))  +    
  coord_flip() 

ggplot(df.adult, aes(Education)) +                 
  geom_bar()+ 
  coord_flip() +
  facet_wrap(~ WorkClass, nrow = 3) 

ggplot(df.adult, aes(Education)) +                 
  geom_bar()+ 
  coord_flip() +
  facet_wrap(~ WorkClass, nrow = 3) 

ggplot(df.adult, aes(Annual_income)) +                 
  geom_bar()+ 
  facet_grid(Sex ~ Education)

#glass data visualization
ggplot(df.glass, aes(x=Si, y=RI)) + 
  geom_point()      

ggplot(df.glass, aes(x=Si, y=RI)) + 
  geom_smooth()

ggplot(df.glass, aes(x=Si, y=RI)) +  # the same x variable, the same y variable, and describe the same data.
  geom_point()    +                    # first geom function
  geom_smooth()

#salaries data visualization
ggplot(df.salaries, aes(x=rank, y=salary)) + 
  geom_dotplot(binaxis="y", stackdir="center", binpositions="all")

ggplot(df.salaries, aes(x=rank, y=salary)) + 
  geom_dotplot(binaxis="y", stackdir="down", binpositions="all", dotsize = 0.5)

ggplot(df.salaries, aes(salary, fill = rank)) + geom_density(position = "stack")  

ggplot(df.salaries, aes(salary, fill = rank)) + geom_density(position = "fill", alpha = 0.3)  

ggplot(df.salaries, aes(salary, fill = rank)) + geom_density(position = "stack", kernel = "optcosine")

#use density plots for ridgeline plot (default)
ggplot(df.salaries, aes(x = salary, y = rank, fill = rank)) +  #fill=rank allows us to use one colour per rank and display the ranks as separate groups
  geom_density_ridges()

ggplot(df.salaries, aes(x = salary, y = rank, fill = rank)) + 
  geom_density_ridges(stat="binline", bins=20)

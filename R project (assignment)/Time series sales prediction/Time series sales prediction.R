library("dplyr")
library("ggplot2")
library("forecast")
library("bayesforecast")

df.retail <- read.csv(file = 'R_DA_Data_online_retail_II_clean.csv', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, sep = ",")


#data type of InvoiceDate is "chr" from csv format, we convert it back to date-time format by as.POSIXct() function.
df.retail$InvoiceDate <- as.POSIXct(df.retail$InvoiceDate)


# Hourly, daily and monthly split of date time for Invoice date
df.retail$date <- format(df.retail$InvoiceDate, "%m/%d/%Y")
# If you need predict sales at each hour, weekly or monthly, below split of date time is useful.
# df.retail$year <- format(df.retail$InvoiceDate, "%Y")
# df.retail$month <- format(df.retail$InvoiceDate, "%Y-%m")
# df.retail$week <- format(df.retail$InvoiceDate, "%A")
# df.retail$time <- format(df.retail$InvoiceDate, "%H")

#total sales per transaction
df.retail$Total_sales = df.retail$Quantity * df.retail$Price
head(df.retail)

#check the range of the InvoiceDate in the data
range(df.retail$InvoiceDate)

str(df.retail)

df.retail_sales_day <- df.retail %>%
  filter(InvoiceDate >="2009-12-01" & InvoiceDate <= "2011-11-30")%>%
  group_by(date)%>%
  summarise(Total_sales=sum(Total_sales))%>%
  mutate(date = as.Date(date, "%m/%d/%Y")) %>%
  arrange(date)
df.retail_sales_day

summary(df.retail_sales_day)

#plot the data daily
sales_by_day_plot <- ggplot(df.retail_sales_day,aes(x=date, y=Total_sales)) +
  ggtitle("Total Sales daily ") +
  geom_line(colour = "blue", size = 0.1) +
  theme(axis.text.x = element_text(angle = 50),
        plot.title = element_text(face = "bold")) +
  ylab("Total Sales") + xlab("Time") +
  scale_x_date(date_breaks = '2 month')
sales_by_day_plot




#Converting to a time series by ts() function
#syntax of ts(data, start, end, frequency)
#data: a vector of the observed time-series values. 
#start: the time of the first observation. Either a single number or a vector of two numbers 
#end: the time of the last observation. Either a single number or a vector of two numbers 
#frequency: the number of observations per unit of time (1=annual, 4=quartly, 12=monthly, etc.).
sales_ts_full <- ts(data = df.retail_sales_day$Total_sales, start = 1, frequency = 208)
#check the data type
class(sales_ts_full)


# Training set
# Use first 70% data for forecasting
sales_ts_train <- head(sales_ts_full, round(length(sales_ts_full) * 0.7))

# Test set
# Use remaining data to test accuracy
h <- length(sales_ts_full) - length(sales_ts_train)
sales_ts_test <- tail(sales_ts_full, h)

#train and test dataset visualization
ggplot() + autolayer(sales_ts_full, linetype=2, size=1.5) + autolayer(sales_ts_train) + autolayer(sales_ts_test)+
  xlab("Time") +
  ylab("Total Sales") 

#Holt-Winters function and let R figure out the tuning parameters on it¡¦s own
HW <- HoltWinters(sales_ts_train)

HW_forecast <- forecast(HW, h=179, level=0)

#Visually evaluate the fits to see of how well the HoltWinters model generalizes data similar to that with which it was trained.
plot(HW_forecast, xlab="Time", ylab="Sales")
#Blue line for Holt-Winters function with the tuning parameters on it¡¦s own
lines(HW$fitted[,1], lty=1, lwd=3, col="blue")

#Visually evaluate the fits to see of how well the HoltWinters model generalizes data similar to that with which it was trained.
plot(sales_ts_train, xlab="Time", ylab="Sales", main = "HoltWinters fits to our data")




#Visualize the test data as well
autoplot(HW_forecast) + autolayer(sales_ts_test)+
  xlab("Time") +
  ylab("Total Sales") +
  guides(colour = guide_legend(title = "Test data"))

# Build the ARIMA Model Using auto.arima() Function
arima <- auto.arima(sales_ts_train)

# Build up seasonal-ARIMA
sarima <- auto.sarima(sales_ts_train, seasonal=T)

#perform forecasting
arima_forecast <- forecast(arima, level=0, h=179)
sarima_forecast <- forecast(sarima, level=0, h=179)

#Show the regression metrics for two arima models
accuracy(arima_forecast)
accuracy(sarima_forecast)

accuracy_arima <- accuracy(arima_forecast)
accuracy_sarima <- accuracy(sarima_forecast)
accuracy_HW <- accuracy(HW_forecast)
#compare the RMSE values between the 3 forecast models. Holt-Winters forecast model is better.
accuracy_arima["Training set","RMSE"]  
accuracy_sarima["Training set","RMSE"]
accuracy_HW["Training set","RMSE"]  



#Since HW performance is the best, we fit the Holt-Winters forecast model with full dataset
HW_full <- HoltWinters(sales_ts_full)
#forecast next 10 days (h=10)
HW_full_forecast <- forecast(HW_full, h=100, level=0)
#show the forecast (forecast sales under "Point Forecast")
HW_full_forecast

#plot the predicted trend
autoplot(HW_full_forecast,lty=2,lwd=1)+autolayer(sales_ts_train)+
  xlab("Time") +
  ylab("Total Sales") 
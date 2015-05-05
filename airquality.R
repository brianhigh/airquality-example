# Explore "New York Air Quality Measurements" from the "dataset" package in R.
# http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/airquality.html
# Brian High, 2015-05-05, CC0, https://github.com/brianhigh/airquality-example

# Load the dataset
library(datasets)
data(airquality)

# Examine the data structure
str(airquality)

# View the first few rows
head(airquality)

# Produce a basic statistical summary 
summary(airquality)

# Produce an exploratory matrix of scatterplots
library(graphics)
pairs(airquality, panel = panel.smooth, main = "airquality data")

# Produce a summary of linear model fit statistics
library(stats)
fit <- lm(Ozone ~ Wind + Solar.R + Temp, data = airquality)
summary(fit)

# Copy the dataset to a new data.frame, removing rows containing NA values
df <- na.omit(as.data.frame(airquality))

# Plot Ozone versus Temp with a linear regression fit
library(ggplot2)
qplot(Temp, Ozone, data=df, geom=c("point", "smooth"), method="lm")

# Create a new Date column from Month and Day, using "1973" as the year 
df$Date <- as.Date(paste("1973", df$Month, df$Day, sep="-"), "%Y-%m-%d")

# Plot Temp, Wind, Solar.R, and Ozone versus Date with log10 y-axis scale
ggplot(df, aes(x=Date)) + ylab("") + labs(color="") + scale_y_log10() +
    geom_point(aes(y=Temp, color='Temp')) + 
    geom_point(aes(y=Wind, color='Wind')) + 
    geom_point(aes(y=Solar.R, color='Solar.R')) + 
    geom_point(aes(y=Ozone, color='Ozone'))

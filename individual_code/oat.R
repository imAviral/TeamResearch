# This R environment comes with many helpful analytics packages installed
library(readr)
library(tidyverse)
library(ggplot2)
library(dplyr)

# reading file data
oat_data <- read_csv("../individual_data/Oat_data.csv",show_col_types = FALSE)
# Check the structure of the data
str(oat_data)

# Ensure the date column is in Date format
oat_data$date <- as.Date(oat_data$date, format = "%Y-%m-%d")

# Aggregate the data to get the average close for each date (if there are duplicates)
oat_data_agg <- oat_data %>%
  group_by(date) %>%
  summarise(close = mean(close, na.rm = TRUE))

# Plot close vs date as a line graph
ggplot(oat_data_agg, aes(x = date, y = close)) +
  geom_line(color = "#FFD700") +  # Line graph
  labs(title = "Close vs Date", x = "Date", y = "Close") +
  theme_minimal()

# Plot histogram with density curve line
ggplot(oat_data_agg, aes(x = close)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "skyblue", color = "#FFD700", alpha = 0.5) +  # Histogram
  geom_density(color = "#FF0000", size = 1) +  # Density curve line
  labs(title = "Histogram with Density Curve Line", x = "Close", y = "Density") +
  theme_minimal()

# Scatter Plot of Close by date
ggplot(oat_data_agg, aes(x = date, y = close)) +
  geom_point(color = "#FFD700", size = 2) +  # Scatter plot with blue points
  geom_smooth(method = "lm", color = "red", linewidth = 1) +  # Use 'linewidth' instead of 'size' for the regression line
  labs(title = "Scatter Plot of Close by date with Regression Line",
       x = "date",
       y = "Close") +
  theme_minimal()


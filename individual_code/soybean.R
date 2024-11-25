# This R environment comes with many helpful analytics packages installed
library(readr)
library(tidyverse)
library(ggplot2)
library(dplyr)

# reading file data
soybean_data <- read_csv("../individual_data/Soybean_data.csv",show_col_types = FALSE)
# Check the structure of the data
str(soybean_data)

# Ensure the date column is in Date format
soybean_data$date <- as.Date(soybean_data$date, format = "%Y-%m-%d")

# Aggregate the data to get the average close for each date (if there are duplicates)
soybean_data_agg <- soybean_data %>%
  group_by(date) %>%
  summarise(close = mean(close, na.rm = TRUE))

# Plot close vs date as a line graph
ggplot(soybean_data_agg, aes(x = date, y = close)) +
  geom_line(color = "#F1C232") +  # Line graph
  labs(title = "Close vs Date", x = "Date", y = "Close") +
  theme_minimal()

# Plot histogram with density curve line
ggplot(soybean_data_agg, aes(x = close)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "#F1C232", color = "#F1C232", alpha = 0.5) +  # Histogram
  geom_density(color = "#FF0000", size = 1) +  # Density curve line
  labs(title = "Histogram with Density Curve Line", x = "Close", y = "Density") +
  theme_minimal()


# Scatter Plot of Close by date
ggplot(soybean_data_agg, aes(x = date, y = close)) +
  geom_point(color = "#FFD700", size = 2) +  # Scatter plot with blue points
  geom_smooth(method = "lm", color = "red", linewidth = 1) +  # Use 'linewidth' instead of 'size' for the regression line
  labs(title = "Scatter Plot of Close by date with Regression Line",
       x = "date",
       y = "Close") +
  theme_minimal()

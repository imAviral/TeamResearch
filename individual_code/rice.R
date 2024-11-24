# This R environment comes with many helpful analytics packages installed
library(readr)
library(tidyverse)
library(ggplot2)
library(dplyr)

# reading file data
rice_data <- read_csv("../individual_data/Rough_Rice_data.csv",show_col_types = FALSE)
# Check the structure of the data
str(rice_data)

# Ensure the date column is in Date format
rice_data$date <- as.Date(rice_data$date, format = "%Y-%m-%d")

# Aggregate the data to get the average close for each date (if there are duplicates)
rice_data_agg <- rice_data %>%
  group_by(date) %>%
  summarise(close = mean(close, na.rm = TRUE))

# Plot close vs date as a line graph
ggplot(rice_data_agg, aes(x = date, y = close)) +
  geom_line(color = "#F1C232") +  # Line graph
  labs(title = "Close vs Date", x = "Date", y = "Close") +
  theme_minimal()

# Plot histogram with density curve line
ggplot(rice_data_agg, aes(x = close)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "skyblue", color = "#F1C232", alpha = 0.5) +  # Histogram
  geom_density(color = "#FF0000", size = 1) +  # Density curve line
  labs(title = "Histogram with Density Curve Line", x = "Close", y = "Density") +
  theme_minimal()
Í
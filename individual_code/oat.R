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
ggplot(oat_data, aes(x = date, y = close)) +
  geom_line(color = "#FFD700") +  # Line graph
  labs(title = "Close vs Date", x = "Date", y = "Close") +
  theme_minimal()

# Plot close vs date as a bar graph with larger bars
ggplot(oat_data_agg, aes(x = date, y = close)) +
  geom_col(fill = "skyblue", color = "#FFD700", width = 0.8) +  # Increased bar width
  labs(title = "Bar Graph of Close vs Date", x = "Date", y = "Close") +
  theme_minimal()

# Plot histogram with Frequency on y-axis
ggplot(oat_data, aes(x = close)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "#FFD700") +
  labs(title = "Histogram of Close (Frequency)", x = "Close", y = "Frequency") +
  theme_minimal()

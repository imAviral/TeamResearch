# This R environment comes with many helpful analytics packages installed
library(readr)
library(tidyverse)
library(ggplot2)
library(dplyr)

# reading file data
all_crop_data <- read_csv("./all_grains_data.csv",show_col_types = FALSE)
# Check the structure of the data
str(all_crop_data)

# Plot close vs date as a line graph
ggplot(all_crop_data, aes(x = close, y = commodity)) +
  geom_line(color = "#4CAF50") +  # Line graph
  labs(title = "Commodity vs Close", x = "Close", y = "Commodity") +
  theme_minimal()

# Assuming 'data' contains 'commodity' and 'close' columns
ggplot(all_crop_data, aes(x = close)) +
  geom_histogram(aes(y = after_stat(density)), bins = 300, color = "#4CAF50", fill = NA) +  # Histogram with no fill color
  geom_density(color = "red", linewidth = 1) +
  facet_wrap(~commodity) + 
  labs(title = "Histogram of Close by Commodity with Density Line",
       x = "Close",
       y = "Commodity") +
  theme_minimal()

# Scatter Plot of Close by date
ggplot(all_crop_data, aes(x = commodity, y = close)) +
  geom_point(color = "#FFD700", size = 2) +  # Scatter plot with blue points
  geom_smooth(method = "lm", color = "red", linewidth = 1) +
  labs(title = "Scatter Plot of Close by Commodity with Regression Line",
       x = "Commodity",
       y = "Close") +
  theme_minimal()

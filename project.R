# Load necessary packages
library(readr)
library(tidyverse)
library(dplyr)
library(ggplot2)

# Load datasets
patient_info <- read.csv("./dataset/PatientInfo.csv")
time <- read.csv("./dataset/Time.csv")
time_age <- read.csv("./dataset/TimeAge.csv")

# Examine structure of the datasets
str(time)
str(time_age)

# Convert date columns to Date type
time$date <- as.Date(time$date)
time_age$date <- as.Date(time_age$date)

# Plot Cumulative Confirmed, Released, and Deceased Cases Over Time
ggplot(time, aes(x = date)) +
  geom_line(aes(y = confirmed, color = "Confirmed Cases"), size = 1) +
  geom_line(aes(y = released, color = "Released Cases"), size = 1) +
  geom_line(aes(y = deceased, color = "Deceased Cases"), size = 1) +
  labs(
    title = "Cumulative Confirmed, Released, and Deceased Cases Over Time",
    x = "Date",
    y = "Number of Cases",
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Plot Confirmed Cases by Age Group Over Time
ggplot(time_age, aes(x = date, y = confirmed, color = age)) +
  geom_line(size = 1) +
  labs(
    title = "Confirmed Cases by Age Group Over Time",
    x = "Date",
    y = "Number of Cases",
    color = "Age Group"
  ) +
  theme_minimal() +
  theme(legend.position = "right")

# Plot Deceased Cases by Age Group Over Time
ggplot(time_age, aes(x = date, y = deceased, color = age)) +
  geom_line(size = 1) +
  labs(
    title = "Deceased Cases by Age Group Over Time",
    x = "Date",
    y = "Number of Cases",
    color = "Age Group"
  ) +
  theme_minimal() +
  theme(legend.position = "right")

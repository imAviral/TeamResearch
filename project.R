# Load necessary packages
library(readr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(reshape)

# Load datasets
patient_info <- read.csv("./dataset/PatientInfo.csv")
time <- read.csv("./dataset/Time.csv")
time_age <- read.csv("./dataset/TimeAge.csv")

# Examine structure of the datasets
str(time)
str(time_age)

# Analyze Covid Cases
datebreak <- seq(from = min(time_reshape$date), to = max(time_reshape$date), by = "1 month")
time_reshape<-melt(time, id.vars="date", measure.vars =c("confirmed","released","deceased"))
time_reshape %>%
  ggplot(aes(x = date, y = value, col = variable)) +
  geom_point() +
  geom_line() +
  ggtitle("Accumulated confirmed, released, deceased numbers") +
  scale_x_date(breaks = datebreak) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

# Analyze Covid Case against age
time_age$date<-as.Date(time_age$date)
time_age %>%
  ggplot(aes(x = date, y = confirmed, color = age, group = age)) +
  geom_line() +
  geom_point() +
  ggtitle("Accumulated Confirmed Number by Age Group") +
  scale_x_date(breaks = datebreak) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    text = element_text(size = 15, face = "bold")
  ) +
  ylab("Accumulated Confirmed Number")
time_age %>%
  ggplot(aes(x = date, y = deceased, color = age, group = age)) +
  geom_line() +
  geom_point() +
  ggtitle("Accumulated Decreased Number by Age Group") +
  scale_x_date(breaks = datebreak) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    text = element_text(size = 15, face = "bold")
  ) +
  ylab("COVID-19 accumulated fatality rate")

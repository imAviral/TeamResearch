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
str(province_cases)
str(data_clean)
str(patient_info_clean)

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

# Bar Graph based on showing counts of a categorical variables - Gender and number of cases

data_clean <- subset(patient_info, !is.na(sex) & sex != "")
gender_distribution <- table(data_clean$sex)
gender_df <- as.data.frame(gender_distribution)
colnames(gender_df) <- c("Gender", "Count")
ggplot(gender_df, aes(x = Gender, y = Count, fill = Gender)) +
  geom_bar(stat = "identity", width = 0.7) +
  labs(title = "COVID-19 Cases by Gender", x = "Gender", y = "Number of Cases") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2")

####

data_clean <- patient_info[!(is.na(patient_info$confirmed_date) | is.na(patient_info$province)), ]

# Group by province and calculate the total number of confirmed cases
province_cases <- data_clean %>%
  group_by(province) %>%
  summarize(Confirmed_Cases = n())

# Sort provinces by number of confirmed cases for better visualization
province_cases <- province_cases %>%
  arrange(desc(Confirmed_Cases))

# Create the plot
ggplot(province_cases, aes(x = reorder(province, -Confirmed_Cases), y = Confirmed_Cases)) +
  geom_bar(stat = "identity", fill = "skyblue", alpha = 0.8) + 
  geom_line(aes(group = 1), color = "red", size = 1) +        
  geom_point(color = "red", size = 2) +                      
  labs(title = "Confirmed Cases by Province",
       x = "Province",
       y = "Number of Confirmed Cases") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


patient_info_clean <- na.omit(patient_info)

# Pearson's correlation test
correlation_test <- cor.test(patient_info_clean$Height, patient_info_clean$Weight, method = "pearson")
print(correlation_test)



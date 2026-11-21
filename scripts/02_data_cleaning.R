# Day 2: Data Cleaning & Management
# Task 1: Variable Selection and Missing Value Check

# Loads necessary libraries
library(tidyverse)

# Load raw dataset
nhis_raw <- read.csv("NHIS _Data_2021.csv")

# Select required variables
selected_vars <- c('AGEP_A', 'WEIGHTLBTC_A', 'HEIGHTTC_A', 'SEX_A', 'HISPALLP_A', 'EDUCP_A', 'PHSTAT_A', 'LSATIS4R_A')
nhis_subset <- nhis_raw %>% select(all_of(selected_vars))

# Identify and remove missing / non-response codes via listwise deletion
nhis_clean <- nhis_subset %>%
  filter(
    !AGEP_A %in% c(97, 98, 99),
    !WEIGHTLBTC_A %in% c(996, 997, 998, 999),
    !HEIGHTTC_A %in% c(96, 97, 98, 99),
    !SEX_A %in% c(7, 9),
    !HISPALLP_A %in% c(97, 98, 99),
    !EDUCP_A %in% c(97, 98, 99),
    !PHSTAT_A %in% c(7, 8, 9),
    !LSATIS4R_A %in% c(7, 8, 9)
  )

# Task 2: Recoding Variables

# Recode EDUCP_A according to the codebook specifications:
# 1 ~ less than High School (Original 0-4)
# 2 ~ High School Graduate (Original 4)
# 3 ~ Some College Education (Original 5-7)
# 4 ~ College Graduate or better (Original 8-10)
nhis_clean <- nhis_clean %>%
  mutate(EDUCP_A_recoded = case_when(
    EDUCP_A >= 0 & EDUCP_A <= 3 ~ "1_Less_than_HS",
    EDUCP_A == 4 ~ "2_HS_Graduate",
    EDUCP_A >= 5 & EDUCP_A <= 7 ~ "3_Some_College",
    EDUCP_A >= 8 & EDUCP_A <= 10 ~ "4_College_Graduate_or_Better",
    TRUE ~ NA_character_
  )) %>%
  mutate(EDUCP_A_recoded = factor(EDUCP_A_recoded, levels = c(
    "1_Less_than_HS", "2_HS_Graduate", "3_Some_College", "4_College_Graduate_or_Better"
  )))

# Format categorical variables as factors
nhis_clean <- nhis_clean %>%
  mutate(
    SEX_A = factor(SEX_A, levels = c(1, 2), labels = c("Male", "Female")),
    HISPALLP_A = factor(HISPALLP_A),
    PHSTAT_A = factor(PHSTAT_A, levels = 1:5, labels = c("Excellent", "Very Good", "Good", "Fair", "Poor")),
    LSATIS4R_A = factor(LSATIS4R_A, levels = 1:4, labels = c("Very Satisfied", "Satisfied", "Dissatisfied", "Very Dissatisfied"))
  )

# Save cleaned dataset
write.csv(nhis_clean, "nhis_clean.csv", row.names = FALSE)
print("Data cleaning complete. Cleaned dataset saved to nhis_clean.csv")
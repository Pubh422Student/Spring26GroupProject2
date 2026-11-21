# Day 4: Multivariate Analysis & Report Drafting
# Task 1: Multivariate Visualization

# Loads necessary libraries
library(tidyverse)
library(psych)
nhis_clean <- read.csv("nhis_clean.csv")

# Faceted Scatter Plot
p_multi <- ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A, color = SEX_A)) +
  geom_point(alpha = 0.4, size = 1.5) +
  facet_wrap(~ PHSTAT_A) +
  ggtitle("Height vs. Weight by Sex, Faceted by General Health Status") +
  theme_minimal()
print(p_multi)

# Correlation Matrix Panel
quant_df <- nhis_clean %>% select(AGEP_A, WEIGHTLBTC_A, HEIGHTTC_A)
pairs.panels(quant_df, method = "pearson", density = TRUE, ellipses = TRUE, main = "Correlation Matrix: Age, Weight, Height")
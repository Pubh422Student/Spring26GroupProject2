# Day 3: Univariate & Bivariate Analysis & Visualization
# Task 1: Univariate Analysis

# Loads necessary libraries
library(tidyverse)
nhis_clean <- read.csv("nhis_clean.csv")

# Quantitative Variables
quant_vars <- c("AGEP_A", "WEIGHTLBTC_A", "HEIGHTTC_A")
for (var in quant_vars) {
  cat("\nSummary Statistics for:", var, "\n")
  x <- nhis_clean[[var]]
  print(summary(x))
  cat("Standard Deviation:", sd(x, na.rm = TRUE), "\n")
  
  # Base R & ggplot2 Visualizations
  hist(x, main = paste("Base R Histogram of", var), xlab = var, col = "lightblue")
  print(ggplot(nhis_clean, aes_string(x = var)) + geom_histogram(binwidth = 5, fill = "steelblue", color = "black") + theme_minimal())
  
  boxplot(x, main = paste("Base R Boxplot of", var), ylab = var, col = "pink")
  print(ggplot(nhis_clean, aes_string(y = var)) + geom_boxplot(fill = "pink") + theme_minimal())
}

# Qualitative Variables
cat_vars <- c("SEX_A", "HISPALLP_A", "EDUCP_A_recoded", "PHSTAT_A", "LSATIS4R_A")
for (var in cat_vars) {
  cat("\nFrequency Table for:", var, "\n")
  print(table(nhis_clean[[var]]))
  
  barplot(table(nhis_clean[[var]]), main = paste("Base R Bar Plot of", var), col = "coral", las = 2)
  print(ggplot(nhis_clean, aes_string(x = var)) + geom_bar(fill = "coral") + theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1)))
}
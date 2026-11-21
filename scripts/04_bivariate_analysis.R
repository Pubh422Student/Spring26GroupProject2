# Day 3: Univariate & Bivariate Analysis & Visualization
# Task 2: Bivariate Analysis

# Loads necessary libraries
library(tidyverse)
nhis_clean <- read.csv("nhis_clean.csv")

# 1. Quantitative vs. Qualitative (Age across Sex and Education)
boxplot(AGEP_A ~ SEX_A, data = nhis_clean, main = "Age by Sex", col = c("skyblue", "lightpink"))
print(ggplot(nhis_clean, aes(x = SEX_A, y = AGEP_A, fill = SEX_A)) + geom_boxplot() + theme_minimal())

boxplot(AGEP_A ~ EDUCP_A_recoded, data = nhis_clean, main = "Age by Education", col = "lightgreen", las = 2)
print(ggplot(nhis_clean, aes(x = EDUCP_A_recoded, y = AGEP_A, fill = EDUCP_A_recoded)) + geom_boxplot() + theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1)))

# 2. Qualitative vs. Qualitative (General Health vs. Life Satisfaction)
print(ggplot(nhis_clean, aes(x = PHSTAT_A, fill = LSATIS4R_A)) + geom_bar(position = "dodge") + labs(title = "Health vs Life Satisfaction", fill = "Life Satisfaction") + theme_minimal())

# 3. Quantitative vs. Quantitative (Height vs. Weight)
plot(nhis_clean$HEIGHTTC_A, nhis_clean$WEIGHTLBTC_A, main = "Height vs Weight", xlab = "Height", ylab = "Weight", col = rgb(0,0,1,0.2), pch = 19)
print(ggplot(nhis_clean, aes(x = HEIGHTTC_A, y = WEIGHTLBTC_A)) + geom_point(alpha = 0.3, color = "purple") + geom_smooth(method = "lm", color = "red") + theme_minimal())

correlation_val <- cor(nhis_clean$HEIGHTTC_A, nhis_clean$WEIGHTLBTC_A, use = "complete.obs")
cat("\nCorrelation Coefficient (Height vs Weight):", correlation_val, "\n")
# R code for Census Data

```r
# Load necessary libraries

library(ggplot2)
library(dplyr)
library(pROC)

# Load the dataset
adult = read.csv("/Users/hannahlim/Downloads/adult.csv")
head(adult, n = 10)

## 1. EDA
# Univariate summaries for the variables in this dataset.

# Summary for Numeric Variables
adult %>%
select(where(is.numeric)) %>%
summary()

# Create Bar chart
# Bar chart displaying the counts of working class for all United States citizens.
work_class = table(adult$workclass)
count = table(adult$workclass[adult$native == "United-States"])
barplot(count, 
  col = c("orangered", "steelblue", "lightgreen", "pink", "yellow", "violet", "darkgreen"),
  xlab = "Work Class", ylab = "Counts",
  main = "Counts of Working Class for all United States Citizens",
  las = 1, cex.names = 0.4)

# Make a bivariate frequency table for the 'workclass' variable as the rows and race as the columns. 
# In a second table, show the same table but with the marginal frequencies added.
bivar_freq_tab = table(adult$workclass, adult$race)
bivar_freq_tab
# Add the marginal frequencies
bivar_freq_tab_margin = addmargins(bivar_freq_tab)
bivar_freq_tab_margin

# make a three-way table for the 'workclass', 'race', and 'sex' variables.
# Then use 'ftable()' to flatten the 3-D table.
my_3way_tab = xtabs( ~ workclass + race + sex, data = adult)
ftable(my_3way_tab)

# Create a relative frequency stacked barchart displaying the counts of 'pay' categories with respect to the 'marital' category.
ggplot(adult) + theme_bw() +
geom_bar(mapping = aes(x = marital, fill = pay), position = "fill") +
  labs(x = "Marital Status", y = "Relative Frequency",
  title = "Relative Frequency of Pay Categories by Marital Status") +
  scale_fill_manual(values = c("darkgreen", "steelblue")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Age distribution by age
ggplot(adult, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "violet", color = "black") +
  theme_minimal() +
  labs(title = "Age Distribution")

## 2. Statistical Analysis & Model Validation
# Recoding Factors
# 7 unique factors in Martial -> commbine the factors into 3 factors
adult$marital[adult$marital == 'Never-married'] = 'NeverMarried'
adult$marital[adult$marital == 'Married-civ-spouse'] = 'Married'
adult$marital[adult$marital == 'Divorced'] = 'FormerlyMarried'
adult$marital[adult$marital == 'Married-spouse-absent'] = 'Married'
adult$marital[adult$marital == 'Separated'] = 'Married'
adult$marital[adult$marital == 'Married-AF-spouse'] = 'Married'
adult$marital[adult$marital == 'Widowed'] = 'FormerlyMarried'
# Table that shows converted categories
table (adult$marital)

# Logistic Regression
adult$pay_binary = ifelse(adult$pay == ">50K", 1, 0)
model = glm(pay_binary ~ marital + age + education + sex + race + workclass +
hourspweek, data = adult, family = "binomial")
summary(model)

# Model Evaluation
pred_probs = predict(model, type = "response")
pred_class = ifelse(pred_probs >= 0.5, 1, 0)
conf_matrix = table(Predicted = pred_class, Actual = adult$pay_binary)
print(conf_matrix)

accuracy = sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy:", round(accuracy, 4), "\n")

roc_obj = roc(adult$pay_binary, pred_probs)

auc_value = auc(roc_obj)
cat("AUC:", round(auc_value, 4), "\n")

plot(roc_obj, col = "darkblue", lwd = 2,
main = "ROC Curve - Logistic Regression")
abline(a = 0, b = 1, lty = 2, col = "gray")
```

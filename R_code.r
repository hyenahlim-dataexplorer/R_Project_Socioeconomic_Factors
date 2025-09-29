# Socioeconomic Factors in U.S. Census: An Analytical Approach

```{r}
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(pROC)

# Load the dataset
adult = read.csv("/Users/hannahlim/Downloads/adult.csv")
head(adult, n = 5)
```

1. EDA (Exploratory Data Analysis)

```{r}
# Summary for Numeric Variables
adult %>%
  select(where(is.numeric), -fnlwgt, -capgain, -caploss) %>%
  summary()
```

a. Demographics: What is the age distribution and common working hours among U.S. workers in the dataset?

```{r}
ggplot(adult, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Age Distribution")
```

b. Employment Patterns: How are work classes distributed among U.S.-born individuals?

```{r}
work_class = table(adult$workclass)
count = table(adult$workclass[adult$native == "United-States"])
barplot(count, col = c("orangered", "steelblue", "lightgreen", "pink", 
                       "yellow", "violet", "darkgreen"),
        xlab = "Work Class", ylab = "Counts", 
        main = "Counts of Working Class for all United States Citizens",
        las = 0.5, cex.names = 0.5)
```

c. Workforce Diversity: How do race and workclass intersect in employment?

```{r}
# bivariate frequency table
bivar_freq_tab = table(adult$workclass, adult$race)
bivar_freq_tab

# Add the marginal frequencies
bivar_freq_tab_margin = addmargins(bivar_freq_tab)
bivar_freq_tab_margin
```

d. Intersectional Analysis: How do work class, race, and sex jointly shape labor force composition?

```{r}
my_3way_tab = xtabs( ~ workclass + race + sex, data = adult)
ftable(my_3way_tab)
```

e. Income Inequality: How does martial status influence income levels?

```{r}
ggplot(adult) + theme_bw() +
  geom_bar(mapping = aes(x = marital, fill = pay), position = "fill") +
  labs(x = "Marital Status", y = "Relative Frequency",
       title = "Relative Frequency of Pay Categories by Marital Status") +
  scale_fill_manual(values = c("darkgreen", "steelblue")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

2. Statistical Analysis

a. Predictors of Income: Which demographic and employment-related factors are most strongly associated with earning more than $50K per year?

```{r}
# Recoding Factors

# 7 unique factors in Martial -> combine the factors into 3 factors
adult$marital[adult$marital == 'Never-married'] = 'NeverMarried'
adult$marital[adult$marital == 'Married-civ-spouse'] = 'Married'
adult$marital[adult$marital == 'Divorced'] = 'FormerlyMarried'
adult$marital[adult$marital == 'Married-spouse-absent'] = 'Married'
adult$marital[adult$marital == 'Separated'] = 'Married'
adult$marital[adult$marital == 'Married-AF-spouse'] = 'Married'
adult$marital[adult$marital == 'Widowed'] = 'FormerlyMarried'

# Table that shows converted categories
table (adult$marital)
```

```{r}
# Logistic Regression
adult$pay_binary = ifelse(adult$pay == ">50K", 1, 0)

model = glm(pay_binary ~ marital + age + education + sex + race + workclass +
              hourspweek, data = adult, family = "binomial")
summary(model)
```

3. Model Evaluation

a. Model Performance: How accurately can we predict income category (>50K vs <=50K) using demographic and employment characteristics?

```{r}
# Model Evaluation / Model Performance
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

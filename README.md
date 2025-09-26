# R_Project_Socioeconomic_Factors

## Socioeconomic Factors in U.S. Census: An Analytical Approach

### 📌 Project Overview

This project uses the **Adult Census Income dataset** (44,993 observations, 14 attributes) to analyze socioeconomic and demographic predictors of income, specifically focusing on whether individuals earn more than $50,000 annually.

**Tools used:** R (tidyverse, stats, ggplot2, caret)

**Main focus:** Effect of marital status on income while controlling for other variables.

---

### 📊 Data Overview

- **Target Variable (pay):** Binary (0 = ≤50K, 1 = >50K)
- **Predictors:**
    - Categorical: marital, education, sex, race, workclass
    - Numeric: age, hours-per-week
- **Excluded variables:** fnlwgt, native-country, occupation, relationship, capital gain/loss (to reduce multicollinearity and improve interpretability).

---

### 🔎 Exploratory Data Analysis

- **Age**: Right-skewed, median ≈ 37, max = 90.
- **Hours/week**: Centered at 40 hrs, slightly skewed right.
- **Income distribution**: Imbalanced (majority ≤50K).
- **Workclass**: Dominated by *Private*.
- **Race**: Mostly *White*, followed by *Black*.
- **Marital status**: Married (22,863), NeverMarried (14,578), FormerlyMarried (7,552).

---

### 🧮 Logistic Regression Model

**Formula:**

```
pay_binary ~ marital + age + education + sex + race + workclass + hours_per_week
```

**Key Results:**

- **Marital Status**: Married → strong positive predictor (β = 1.90, p < 0.001).
- **Education**: Advanced degrees (Masters, Doctorate, Prof-school) → large positive coefficients.
- **Age**: Positive effect (β = 0.03 per year).
- **Sex**: Males more likely to earn >50K (β = 0.38, p < 0.001).
- **Race**: White significant (β = 0.53), others not significant.
- **Workclass**: Private and self-employed show lower odds than federal government jobs.
- **Hours worked**: More hours → higher odds (β = 0.03, p < 0.001).

---

### 📈 Model Evaluation

- **Accuracy**: 81.8%
- **AUC**: 0.8663 (very good discrimination ability).
- **Confusion Matrix**: Balanced predictive performance.

---

### ✅ Conclusion

- Marital status is a **key determinant** of income.
- Higher education, being male, older age, and working longer hours increase odds of high income.
- The model shows **good predictive accuracy** and interpretability.

---

### 📚 References

- Dataset: Adult Census Income (UCI Repository)

# R_Project_Socioeconomic_Factors

## Socioeconomic Factors in U.S. Census: An Analytical Approach

### Introduction

The Adult Census Income dataset, derived from the 1994 U.S. Census database, contains a wide range of socio-economic and demographic features. It has been widely used for modeling classification problems related to income, particularly distinguishing individuals who earn more than $50,000 annually from those who do not. This project aims to explore the effect of marital status on income level, while accounting for other individual-level characteristics. 

**Data Overview**

The dataset consists of **44,993 observations** with 14 attributes describing demographic (e.g., age, sex, race), economic (e.g., hours per week, work class, education), and income-related information.

 - Variables Used in This Analysis:

| Variable      | Type        | Description                                            |
|---------------|-------------|--------------------------------------------------------|
| `pay`         | Binary      | Target Variable: income level   (1 = >50K, 0 = ≤50K)   |
| `marital`     | Categorical | Recoded into: Married, NeverMarried, Formerly Married  |
| `age`         | Numeric     | Age of the individual                                  |
| `education`   | Categorical | 16 categories (e.g., Bachelors, HS-grad)               |
| `sex`         | Categorical | Male or Female                                         |
| `race`        | Categorical | 5 categories                                           |
| `workclass`   | Categorical | 7 categories                                           |
| `hourspweek`  | Numeric     | Hours worked per week                                  |

 - Note: `fnlwgt`, `native`, `occupation`, `relationship` and `capital gain/loss` were excluded to focus on interpretability and reduce multicollinearity.

---

### Analysis & Interpretation

1. **Descriptive Insights**

* Age & Hours: Most individuals work ~40 hours per week, with median age ~37.
* Work Class: Private sector dominates, followed by government roles.
* Race x Work Class: White workers are the majority acorss all work classes, while Black workers are heavily concentrated in the private sector.
* Marital Status x Income: Married individuals have a much higher likelihood of >50K income compared to single or formerly married groups.

2. **Logistic Regression Findings**

* Marital Status: Being married increases odds of high income (β ≈ +1.90, p < 0.001).
* Education: Higher education (Bachelor's, Master's, Doctorate, Professional School) strongly boosts income odds.
* Age & Hours Worked: Both positively influence income likelihood (older individuals, longer weekly hours → higher pay).
* Sex: Men have higher odds than women (β ≈ +0.38, p < 0.001).
* Work Class: Government employees earn less than private, while self-employed (not-incorporated) earn significantly less.

3. **Model Performance**

* Accuracy: 81.8%
* AUC: 0.866 → strong discrimination between >50K and ≤50K groups.
* Misclassification: ~5,600 high earners misclassified as low earners → possible business impact if model used in financial planning or credit risk.

---

### Conclusion

* Logistic regression is an appropriate baseline model with good predictive performance (AUC: 0.866).
* Key predictors: marital status, education, age, weekly hours, sex, and work class.
* Future improvements: add interaction terms (e.g., sex x education), try ensemble models (e.g., Random Forest, XGBoost), and address class imbalance.

---

### References
Dataset: Adult Census Income (UCI Repository)

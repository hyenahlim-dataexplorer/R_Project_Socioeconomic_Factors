# R_Project_Socioeconomic_Factors

## Socioeconomic Factors in U.S. Census: An Analytical Approach

### Introduction

The Adult Census Income dataset, derived from the 1994 U.S. Census database, contains a wide range of socio-economic and demographic features. It has been widely used for modeling classification problems related to income, particularly distinguishing individuals who earn more than $50,000 annually from those who do not. This project aims to explore the effect of marital status on income level, while accounting for other individual-level characteristics. 

**Data Overview**

The dataset consists of **44,993 observations** with 14 attributes describing demographic (e.g., age, sex, race), economic (e.g., hours per week, work class, education), and income-related information.

- Variables Used in This Analysis

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

### Statistical Analysis

1. **EDA**
- Univariate Insights:
    - **Age** is right-skewed, with a median around 37 and a maximum of 90.
    - **Hours worked per week** clusters heavily at 40 hours, with a slight right skew.
    - **Capital gains and losses** are mostly zero — with only a small subset of the population reporting positive values, indicating extreme skewness.
    - The `pay` variable is imbalanced: most individuals earn `≤50K`.

- Categorical Distributions: 
    - **Workclass** is dominated by `Private` employment, especially among U.S. citizens.
    - **Race** is predominantly `White`, followed by `Black`.
    - **Marital status** (after recoding) shows a large portion are `Married`( = 22863), followed by `NeverMarried` (= 14578) and `FormerlyMarried` (= 7552).
      
- Bivariate Patterns:
    - A **bivariate table** between `workclass` and `race` shows strong race-based concentration in employment types.
    - A **three-way table** (`workclass` x `race` x `sex`) reveals differences in gender representation across job types and racial groups.
    
    - The **relative frequency bar chart** for `marital` x `pay` shows a clear trend: married individuals are more likely to earn `>50K`.
    
These patterns support the hypothesis that marital status and other demographic/work variables might influence income level, justifying their inclusion in the predictive model. 

2. **Logistic Regression**

Fit a logistic regression model to estimate the probability of earning more than $50K 

(`pay_binary = 1`), using demographic and employment variables.

```r
pay_binary ~ marital + age + education + sex + race + workclass + hourspweek
```

- Key Interpretations:
- Marital Status (ref: `FormerlyMarried`)
    - `Married`: β = 1.90, p < 0.001 → Strong positive association. Married individuals are significantly more likely to earn >$50K compared to formerly married ones.
    - `NeverMarried`: β = -0.51, p < 0.001 → Significantly less likely to earn >$50K compared to formerly married individuals.
- Age
    - β = 0.0303, p < 0.001 → Every additional year of age increases the log odds of earning >$50K, holding other variables constant.
- Education
    - Strong positive coefficients for higher education:
        - `Masters` (β = 3.15), `Doctorate` (β = 3.68), `Prof-school` (β = 3.84) all show very high odds of income >$50K.
        - Lower education (e.g., `5th-6th grade`, `1st-4th grade`) has negative coefficients, indicating much lower income probabilities.
- Sex
    - `Male`: β = 0.38, p < 0.001 → Males are significantly more likely to earn >$50K than females, all else equal.
- Race (ref: `Amer-Indian-Eskimo`)
    - `White`: β = 0.53, p = 0.001 → ****Statistically significant.
    - Others (`Black`, `Asian-Pac-Islander`, `Other`) are not significant in this model.
- Workclass
    - Compared to `Federal-gov` (baseline), most other groups have lower odds of earning >$50K:
        - `Private`: β = -0.54, `Self-emp-not-inc`: β = -1.16
        - `Without-pay`: β = -1.99, which makes sense.
- Hours Worked
    - β = 0.03, p < 0.001 → More hours per week is strongly associated with higher income.

- Model Performance Summary
    - Null deviance: 50002 → baseline model with intercept only
    - Residual deviance: 34145 → improved after adding predictors
    - AIC: 34207 → relatively low, indicating good model fit
    - Significant predictors: Marital status, education, sex, age, workclass, and hours worked

3. **Model Evaluation**

To assess how well the logistic regression model predicts income level, we evaluated it using both a confusion matrix and the ROC curve.

- Confusion Matrix

|             | Actual ≤50K (0) | Actual >50K (1) |
|-------------|-----------------|-----------------|
| Predicted 0 | 31,473          | 5,633           |
| Predicted 1 | 2,541           | 5,346           |
- Accuracy ≈ 81.8% → The model correctly classified about 82% of all individuals, indicating strong overall performance.

- ROC Curve & AUC
    
    - The ROC curve illustrates the trade-off between true positive rate (sensitivity) and false positive rate (1 - specificity).
    - The AUC (Area Under the Curve) is 0.8663, which indicates:
        - Excellent discriminative ability: The model can distinguish between high-income and low-income earners with high reliability.
        - AUC values between 0.8 and 0.9 are considered very good in classification tasks.

### Conclusion

This analysis explored how demographic and work-related factors influence the probability of earning more than $50,000 annually the Adult Census Income dataset.

- After recoding marital status and fitting a logistic regression model, we found that:
    - Married individuals are significantly more likely to earn >$50K than others.
    - Education plays a major role: higher degrees (Master’s, Doctorate, Professional School) are strongly associated with high income.
    - Men, older individuals, and those who work more hours per week also increased odds of earning >$50K.

The model performed well, achieving:

- Accuracy: 81.8%
- AUC: 0.8663

These results confirms the research hypothesis: marital status is significantly associated with income level, even after accounting for other socioeconomic and occupational variables.

### References
Dataset: Adult Census Income (UCI Repository)

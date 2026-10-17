# Predicting Football Player Market Value

**Regression · scikit-learn, LightGBM · R² 0.992**

## Problem
Transfer fees and wage structures depend on an estimate of what a player is worth, and that
estimate is usually produced by judgement rather than measurement. The question here: how much of
a player's market value can be explained by their recorded attributes and performance alone?

## Data
Player-level dataset covering demographics, position, contract status, and performance metrics.

## Approach
1. Cleaning and feature engineering on player attributes
2. Baseline linear models to establish a floor
3. Tree ensembles — Random Forest, Decision Tree Regressor, Gradient Boosting, LightGBM
4. `RandomizedSearchCV` hyperparameter tuning on the leading model
5. Model comparison on R², MAE, MSE and training time together, not accuracy alone

## Result
Gradient Boosting was the strongest model, and tuning moved it a little further:

| Model | R² | MAE |
|---|---|---|
| Gradient Boosting (tuned) | **0.9920** | 148,729 |
| Gradient Boosting (baseline) | 0.9917 | 195,245 |
| LightGBM | 0.9918 | 188,589 |
| Random Forest | 0.9709 | 468,715 |
| Decision Tree | 0.9652 | 485,635 |

Best parameters: `n_estimators=350, max_depth=4, learning_rate=0.1, min_samples_split=10, subsample=0.8`

Tuning cut mean absolute error by roughly 24% (195k → 149k) for a 0.0003 gain in R² — the error
metric moved, the variance explained barely did. On a transfer valuation, the MAE is the number
that matters.

## What I'd do differently
An R² of 0.992 on market value is high enough to be suspicious. Market value in these datasets is
often itself a derived or crowd-estimated figure correlated with the inputs, so the model may be
partly recovering a formula rather than predicting an independent outcome. I'd check for leakage
between the target and the feature set, and validate against actual realised transfer fees.

[📓 Open the notebook](Football_Player_Value.ipynb)

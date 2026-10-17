# Business Analytics

Seven machine-learning projects in Python, plus 137 SQL queries. Each folder has a write-up
covering the problem, the method, the measured result, and what I'd do differently.

## Machine learning

| Project | Type | Headline result |
|---|---|---|
| [Football player valuation](football-player-valuation/) | Regression | R² 0.992, MAE 149k — Gradient Boosting, tuned |
| [Credit card fraud detection](credit-card-fraud-detection/) | Imbalanced classification | 87.8% fraud recall via SMOTE, at 6.4% precision |
| [NYC schools demographics](nyc-schools-eda/) | EDA + clustering | k=2, silhouette 0.254 across ~1,800 schools |
| [Breast cancer diagnosis](breast-cancer-classification/) | Feature selection | 97.98% with LASSO; 2 features carry the signal |
| [Titanic survival](titanic-survival/) | Model comparison | 81.0% — scaling helps KNN/SVM, not trees |
| [Airbnb Vienna pricing](airbnb-vienna-regression/) | Regression (SEMMA) | R² 0.13 on 8,302 listings — honestly weak |
| [PCA on handwritten digits](pca-digit-recognition/) | Dimensionality reduction | Component loadings mapped back to pixel space |

## SQL

| | |
|---|---|
| [DreamHome database labs](sql-dreamhome-labs/) | 137 queries across 4 progressive labs — aggregation and `HAVING`, inner and outer joins across 5+ tables, set operations, correlated subqueries, DDL |

## Toolkit

`pandas` · `numpy` · `scikit-learn` · `LightGBM` · `imbalanced-learn` (SMOTE) · `matplotlib` ·
`seaborn` · `scipy` · SQL

**Methods:** linear and logistic regression · decision trees · random forests · gradient boosting ·
SVM/SVR · KNN · K-Means · PCA · feature selection (KBest, LASSO) · hyperparameter tuning
(`RandomizedSearchCV`) · ROC/AUC and precision–recall evaluation · SEMMA

## A note on the results

Two of these models are weak — Airbnb Vienna explains 13% of price variance, and the fraud
classifier runs at 6.4% precision. They are included with those numbers stated up front rather
than quietly dropped, because knowing that a model is weak, and being able to say why, is the
part of the work that transfers. The Airbnb write-up explains what data would be needed to do
better; the fraud write-up frames the precision/recall trade-off as a cost decision rather than
a modelling failure.

The one result I'd treat with suspicion is the 0.992 R² on player valuation — that is flagged
in its own write-up as a likely target-leakage problem rather than presented as a success.

# Credit Card Fraud Detection

**Imbalanced classification · SMOTE, logistic regression · 284,807 transactions**

## Problem
Fraud is 0.17% of this dataset — 492 fraudulent transactions in 284,807. That imbalance makes the
obvious metric worthless: a model that predicts "not fraud" every single time scores 99.83%
accuracy and catches nothing. The real problem is the trade-off between missed fraud and false
alarms.

## Data
284,807 transactions, 31 features (PCA-anonymised components `V1`–`V28`, plus `Time` and `Amount`).

## Approach
1. EDA with attention to the class distribution
2. Baseline logistic regression on the raw, imbalanced data
3. SMOTE oversampling of the minority class, then retrain
4. Evaluation on the **confusion matrix and per-class precision/recall**, not accuracy

## Result

| | Accuracy | Fraud recall | Fraud precision |
|---|---|---|---|
| Logistic regression | 0.9786 | — | — |
| Logistic regression + SMOTE | 0.9774 | **0.878** | 0.064 |

Confusion matrix after SMOTE:

|  | Predicted legit | Predicted fraud |
|---|---|---|
| **Actually legit** | 83,383 | 1,912 |
| **Actually fraud** | 18 | 130 |

SMOTE caught 130 of 148 frauds (87.8% recall) at the cost of 1,912 false positives. Headline
accuracy *fell* slightly — which is the point. Accuracy went down while the model got
dramatically more useful.

**The business read:** whether this is a good model depends entirely on relative cost. If
reviewing a flagged transaction costs $5 and missing a fraud costs $500, then 1,912 reviews
($9,560) to prevent 130 frauds ($65,000) is clearly worth it. At 6.4% precision, a reviewer
is wrong 15 times out of 16 — tolerable for an automated hold, not for declining a card outright.

## What I'd do differently
Logistic regression is a floor, not an answer. I'd compare gradient boosting and isolation
forests, tune the decision threshold explicitly against a cost matrix rather than accepting 0.5,
and report precision–recall AUC instead of ROC AUC, which flatters models on data this imbalanced.

[📓 Open the notebook](SML_Final.ipynb)

# Titanic Survival — Classification Model Comparison

**Classification · 7+ models, scaled vs unscaled · 81.0% accuracy**

## Problem
Predict passenger survival, and use it as a controlled comparison of classification algorithms —
specifically, which models are sensitive to feature scaling and which are indifferent to it.

## Approach
1. Imputation — median for `age`, mode for `embarked`
2. Encoding of categorical variables
3. Train every model twice: once on raw features, once on scaled features
4. Compare on accuracy, precision, recall, F1, and ROC curves with AUC

## Result

| | Accuracy | Precision | Recall | F1 |
|---|---|---|---|---|
| Best model | **0.8101** | 0.7966 | 0.6812 | 0.7344 |
| Second | 0.7877 | 0.7627 | 0.6522 | 0.7031 |
| Baseline | 0.78 | — | — | — |

The pattern that matters: **distance-based models (KNN, SVM) improved substantially with scaling;
tree-based models did not move at all.** That is the expected behaviour — trees split on
thresholds within a single feature, so a monotonic rescaling cannot change the split — and
confirming it on real data is more instructive than the accuracy number.

Recall sits well below precision (0.68 vs 0.80) across every model: these classifiers are
conservative, missing roughly a third of actual survivors while being right about most of the
ones they do identify.

## What I'd do differently
Single train/test split on 891 rows gives a noisy estimate — the gap between 0.81 and 0.79 is
probably within the error bar. Cross-validation would make the comparison defensible, and
engineering title-from-name and family-size features is where the real accuracy gains sit.

[📓 Open the notebook](Case_Study_II_Titanic_dataset.ipynb)

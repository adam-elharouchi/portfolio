# Breast Cancer Diagnostic Classification

**Feature selection · KBest vs LASSO · 97.98% accuracy on 2 features**

## Problem
Classify breast tumours as benign or malignant from the Wisconsin Diagnostic dataset. The
interesting question is not whether this is possible — it is — but how few features it actually
takes, and whether two different selection methods agree on which ones matter.

## Approach
1. EDA across the 30 geometric and texture features
2. **SelectKBest** univariate selection at k = 1, 2, 4
3. **LASSO** (L1) regularisation at α = 0.01, 0.15, 0.3
4. Compare which features each method keeps, and the accuracy each achieves

## Result

| Method | Accuracy |
|---|---|
| LASSO, α = 0.01 | **0.9798** |
| LASSO, α = 0.15 | 0.9697 |
| LASSO, α = 0.30 | 0.9596 |
| KBest, k = 1 / 2 / 4 | 0.9495 |

Two findings stand out.

**The methods agree.** KBest works by univariate variance, LASSO by coefficient shrinkage — very
different mechanisms — and both converge on *mean concave points* and *worst radius* as the most
diagnostically powerful predictors. Agreement across independent methods is much stronger evidence
than either result alone.

**One feature gets you to 94.95%.** KBest at k=1, k=2 and k=4 all score identically, meaning
features beyond the first add nothing this model can use. Most of the diagnostic signal in a
30-feature dataset lives in a couple of geometric measurements.

## What I'd do differently
On a medical classifier, accuracy is the wrong headline metric — a false negative (missed
malignancy) and a false positive (unnecessary biopsy) are not remotely equivalent costs. I'd lead
with sensitivity and the confusion matrix, and tune the threshold to favour recall on the
malignant class.

[📓 Open the notebook](Breast_Cancer_Case_Study.ipynb)

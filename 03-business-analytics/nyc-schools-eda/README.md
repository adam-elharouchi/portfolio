# NYC Public School Demographic Analysis

**EDA · PCA · K-Means clustering · ~1,800 schools**

## Problem
New York City runs the largest public school system in the United States — over a million
students across roughly 1,800 schools. The question: do schools fall into natural demographic
groupings, and what distinguishes them?

## Data
School-level demographic data from the NYC Department of Education.

**The data-quality problem came first.** NYC DOE applies privacy suppression markers to small
subgroups to prevent identifying individual students. These are non-numeric values sitting in
numeric columns — no analysis is possible until they are handled. I replaced suppressed values
with `NaN` and applied median imputation, which preserved high coverage across key fields.

## Approach
1. Handle suppression markers, impute, and validate coverage
2. Univariate and bivariate exploration of demographic distributions
3. Standardise features, then PCA for dimensionality reduction
4. K-Means, with **both** the elbow method and silhouette score for choosing k
5. Radar charts to characterise what differentiates each cluster

## Result
Optimal k = 2, silhouette score 0.2538.

I used silhouette as the deciding criterion rather than inertia. The elbow method measures only
within-cluster compactness, which always improves as k rises and so gives no real stopping rule;
silhouette measures how well each school fits its own cluster *relative to the next nearest*,
which is the question actually being asked. The clusters separate cleanly in PCA space, and the
radar charts show the distinguishing demographic profile of each.

**A silhouette of 0.25 is honest, not strong.** It indicates real but weak structure — NYC schools
do not fall into sharply separated demographic types so much as sit on a continuum with two
loose centres of mass.

## What I'd do differently
Two clusters on a system this large is a coarse description. I'd try DBSCAN or hierarchical
clustering, which don't assume spherical clusters, and join in performance and funding data —
demographic clustering is only interesting if it connects to outcomes.

[📓 Open the notebook](nyc_schools_eda.ipynb)

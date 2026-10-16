<div align="center">

# Adam El Harouchi

**Finance · Business Analytics · Software**

Hult International Business School, Boston

[Portfolio site](https://adam-elharouchi.github.io/portfolio) ·
[LinkedIn](https://www.linkedin.com/in/adam-el-harouchi) ·
[Email](mailto:adamelharouchi5@gmail.com)

</div>

---

I work at the intersection of financial analysis and applied data science — valuation and
forensic accounting on one side, machine learning and production software on the other. The
projects below are organised by discipline, each with a write-up covering the problem, the
method, the measured result, and the limitations.

---

## Featured — AnalytIQ

> **An AI-powered analytics learning platform that generates coursework from a professor's own
> material and grades student code by executing it.**
>
> 🔗 **[myanalytiq.org](https://www.myanalytiq.org)** · [Source](https://github.com/adam-elharouchi/AnalytIQ) · **[Full write-up →](01-analytiq/)**

Analytics professors can't assign much code, because grading it means either reading every
submission by hand or comparing it to a reference answer as text — and text comparison doesn't
measure correctness. AnalytIQ takes a professor's own chapter, generates exercises *with
executable test cases* from it, and scores submissions by **running the code and checking the
actual output**. No string-similarity comparison anywhere in the grading path. It plugs into an
institution's existing LMS over LTI 1.3, so students never create an account and grades flow back
to the gradebook automatically.

| | |
|---|---|
| **Stack** | Python 3.9 · Flask 3.0 · PostgreSQL (Supabase) · Redis + Celery · Google Gemini · Render |
| **Scale** | 710 commits · ~39,800 lines of Python · ~13,900 of JavaScript · 66 test files |
| **Grades** | Python, R, JavaScript, SQL, Java — sandboxed execution with `RLIMIT_*` and import blocklists |
| **Auth** | JWT · bcrypt · per-tenant OIDC SSO · LTI 1.3 with grade passback |
| **Role** | Sole developer and founder — product, architecture, implementation, deployment |

---

## [Finance →](03-finance/)

| Project | Method | Conclusion |
|---|---|---|
| [TechnoGlobal forensic accounting](03-finance/technoglobal-forensic-accounting/) | US GAAP review, full restatement | 8 red flags, 3 fraudulent; net income overstated **$141M**; uncovered a hidden debt-covenant breach |
| [Amazon (AMZN) equity research](03-finance/amazon-investment-proposal/) | DCF / FCFF bottom-up, scenarios | **BUY**, $292.99 target (+29.5%), bear case $212.05 |
| [Coca-Cola (KO) equity analysis](03-finance/coca-cola-equity-analysis/) | Comparables + DDM + market sentiment | Fairly valued; DDM outlier explained by model sensitivity |

## [Business Analytics & Machine Learning →](02-business-analytics/)

| Project | Type | Headline result |
|---|---|---|
| [Football player valuation](02-business-analytics/football-player-valuation/) | Regression | R² 0.992, MAE 149k (tuned Gradient Boosting) |
| [Credit card fraud detection](02-business-analytics/credit-card-fraud-detection/) | Imbalanced classification | 87.8% fraud recall via SMOTE on 284,807 transactions |
| [NYC schools demographics](02-business-analytics/nyc-schools-eda/) | EDA + K-Means | k=2 by silhouette across ~1,800 schools |
| [Breast cancer diagnosis](02-business-analytics/breast-cancer-classification/) | Feature selection | 97.98% with LASSO; KBest and LASSO agree on 2 features |
| [Titanic survival](02-business-analytics/titanic-survival/) | Model comparison | 81.0%; scaling moves KNN/SVM, not trees |
| [Airbnb Vienna pricing](02-business-analytics/airbnb-vienna-regression/) | Regression (SEMMA) | R² 0.13 on 8,302 listings |
| [PCA on handwritten digits](02-business-analytics/pca-digit-recognition/) | Dimensionality reduction | Component loadings mapped back to pixel space |

## [SQL →](04-sql/)

137 queries across four progressive labs on the DreamHome relational schema — aggregation and
`HAVING`, multi-table inner and outer joins, set operations, correlated subqueries, and DDL.

## [Operations →](05-operations/)

[AeroShield capstone](05-operations/aeroshield/) — throughput and cycle-time analysis, bottleneck
identification, and capacity planning for an advanced-materials manufacturer scaling from pilot
to industrial production.

## [Software →](06-software/)

| Project | Stack |
|---|---|
| [Personal finance dashboard](06-software/budgeting-app/) | Next.js 15, TypeScript, Plaid API, Zustand |
| [Voice interview simulator](06-software/interview-simulator/) | Node.js, Express, Anthropic API, Web Speech API |

---

## Technical summary

**Languages** — Python · SQL · TypeScript / JavaScript · R

**Data & ML** — pandas · numpy · scikit-learn · LightGBM · imbalanced-learn · matplotlib ·
seaborn · regression · classification · clustering · PCA · feature selection · hyperparameter
tuning

**Finance** — DCF / FCFF · WACC & CAPM · DDM · comparable company analysis · multiples ·
scenario & sensitivity analysis · US GAAP (ASC) · financial statement restatement ·
earnings-management detection

**Engineering** — Flask · Next.js / React · Node.js · PostgreSQL · Redis · Celery · Docker ·
REST API integration · LTI 1.3 · OIDC SSO · pytest

**Tools** — Git · Excel (financial modelling) · Jupyter / Colab · Render · Supabase

---

<div align="center">

**Open to roles in financial analysis, business analytics, and data science.**

[adamelharouchi5@gmail.com](mailto:adamelharouchi5@gmail.com)

</div>

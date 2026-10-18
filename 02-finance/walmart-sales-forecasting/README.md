# Walmart — Sales Forecasting and Financial Planning

**Time-series forecasting · method comparison · forecasted financial statements**

## Problem
Forecast Walmart's sales and build out forecasted financial statements from them. The harder
question underneath: *which* forecasting method, and on what basis do you choose?

## Approach — seven methods, compared

Rather than pick one technique, the model builds the same forecast seven ways and compares
them across 12 sheets:

| Method | Sheet |
|---|---|
| Centered moving average | `CMA` |
| Simple exponential smoothing | `Expo Smooth` |
| Holt's linear trend exponential smoothing | `HLTES` |
| Holt-Winters additive seasonal | `HWAS` |
| Holt-Winters multiplicative seasonal | `HWMS` |
| Time-series regression | `Time Series Reg` |
| Error-Trend-Seasonal, for scenario analysis | `ETS` |

Plus `%Sales & Trend` for percent-of-sales forecasting, `Walmart Q Rev` for the quarterly
revenue base, seasonal indices and raw seasonals, and regression statistics for the regression
fit.

The additive-versus-multiplicative Holt-Winters comparison is the one that matters for a
retailer. Additive assumes the holiday uplift is a fixed dollar amount; multiplicative assumes
it scales with the level of the business. For Walmart, where Q4 moves with total volume rather
than adding a constant, multiplicative is the defensible choice — and running both is what
demonstrates that rather than asserting it.

Forecast output feeds **forecasted financial statements** and scenario analysis, so the method
choice flows through to the planning numbers rather than stopping at a sales line.

## Company and industry analysis
A 10-K based overview covering the three segments — Walmart U.S. ($420B+), International
($101B across 19 countries) and Sam's Club ($84.3B), for $605.6B total — the omnichannel
strategy, 160+ U.S. distribution centres, supply-chain automation, Project Gigaton and the
2040 zero-emissions goal, fintech (Walmart Pay, MoneyCard), and the Flipkart position in India.
Industry section covers the shift to omnichannel and competitive pressure from Amazon, Target,
Costco and direct-to-consumer entrants.

## Skills
Time-series forecasting (moving average, exponential smoothing, Holt's linear trend,
Holt-Winters additive and multiplicative, ETS) · seasonal index construction · time-series
regression · percent-of-sales forecasting · forecasted financial statements · scenario analysis ·
10-K analysis

Built from a blank forecasting template provided by the professor. Every model, forecast and
statement in the workbook is mine.

📄 [Report](walmart-report.docx) · 📊 [Forecasting models](walmart-forecasting-models.xlsx)

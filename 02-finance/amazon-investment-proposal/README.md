# Equity Research — Amazon.com, Inc. (AMZN)

**DCF valuation · FCFF bottom-up · 33-sheet model · BUY, $292.99 target**

> Corporate Finance (FIN-0300), Hult International Business School, December 2025. Sole author.

## Recommendation

**BUY AMZN — target price $292.99, implying 29.5% upside from $226.19 (12 December 2025).**

## Valuation method

Discounted Cash Flow using **Free Cash Flow to the Firm (FCFF)** built bottom-up, rather than a
top-down margin assumption applied to consolidated revenue. Amazon's segments have structurally
different economics — retail runs on thin margins and heavy fulfilment cost, AWS does not — so a
blended assumption hides the thing that actually drives the valuation.

## The model

[`amazon-dcf-model.xlsx`](amazon-dcf-model.xlsx) — 33 sheets. The parts worth looking at:

| Sheet | What it does |
|---|---|
| `HWMS Model` | **Holt-Winters multiplicative seasonal** forecast of quarterly sales — Amazon's Q4 is structurally different from its other quarters, so a linear trend forecast misprices the business |
| `Revenue` | Segment build, including **AWS Remaining Performance Obligations (RPO)** as a forward demand signal and global IT spend as the AWS driver |
| `Reg. Beta` | Equity beta regressed on **5 years of monthly AMZN vs. S&P 500 returns**, rather than taking a published beta |
| `Bonds` | Cost of debt built from Amazon's **actual outstanding note issues** (2014–2025 maturities) rather than a single blended rate |
| `WACC` | Cost of capital from the regressed beta, the bond schedule, 10-year T-bill, and tax rate |
| `Scenarios` / `Scenario Summary` | Bull, base and bear cases with the drivers switched explicitly |
| `Multiples` / `Peer Fin Info` | Relative valuation against comparables — Microsoft/Azure as the AWS proxy, Alibaba for global e-commerce and cloud |
| `DCF` | The valuation itself |
| `Forecasted FS` / `Actuals FS` | Three-statement actuals and forecast |

Sources are cited per sheet: Amazon investor relations, the 10-K, the 2024 annual report,
Yahoo Finance price history, GuruFocus and Finbox for working-capital ratios.

The model is built on a course-provided workbook shell; the Amazon analysis, forecasts and
outputs in it are mine.

## Investment thesis

**1. Revenue growth acceleration.** Sales growth is modelled rising from 7% in 2025 to 10% by
2028–2029.

**2. Operating leverage and margin expansion.** Fulfilment cost as a percentage of sales is the
hinge variable in the model.

**3. Dominance in high-margin segments.** AWS carries the thesis — it is where the incremental
margin is.

## Scenario analysis

| Scenario | Target | vs. current |
|---|---|---|
| Base | **$292.99** | +29.5% |
| Bear — fulfilment to 17% of sales, growth 5–7% | $212.05 | −6.25% |

The bear case is the useful half of this. A valuation with only an upside number is an opinion;
the bear case states what has to be true for the thesis to fail — fulfilment cost rising to 17%
of sales while growth decelerates to 5–7% — and prices it. The spread from −6% to +30% is the
honest description of the risk being taken.

## Risks
- Macroeconomic pressure on consumer discretionary spend
- Execution risk on the margin-expansion assumption
- Saturated markets with aggressive competitive pricing, requiring sustained R&D and capex to
  hold position

## Skills
DCF / FCFF modelling · WACC from regressed beta and an issue-level bond schedule ·
Holt-Winters seasonal forecasting · bottom-up segment forecasting · comparable company analysis ·
scenario and sensitivity analysis · three-statement modelling · equity research report writing

📄 [Full report](amazon-investment-proposal.docx) · 📊 [Valuation model](amazon-dcf-model.xlsx)

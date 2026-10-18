# Best Buy — Capital Budgeting and Investment Decision

**NPV · IRR · PI · discounted payback · WACC**

> Accounting & Finance final project, Hult International Business School. Team 3, BOS 1.
> The written report is mine; the model I built jointly with a teammate.

## Problem
Evaluate a capital investment at Best Buy on its merits — build the cost of capital, project the
cash flows, and run the full set of investment criteria rather than a single number.

## Approach

**Cost of capital.** WACC built from the standard structure:

```
WACC = (E/V × Re) + (D/V × Rd × (1 − Tc))
```

**Investment criteria — four, not one:**

| Criterion | Why it's there |
|---|---|
| **NPV** | The decision rule. Positive NPV means the project creates value |
| **IRR** | Comparability. Benchmarked against the 6–11% investors look for on a 5–10 year hold; the project's IRR lands around 10% |
| **PI** | Value created per dollar invested — the tiebreaker under capital rationing |
| **Discounted payback** | How long the capital is at risk, which NPV alone does not say |

Running all four matters because they can disagree. NPV and IRR rank mutually exclusive projects
differently when cash flow timing or scale differs, and a project can clear NPV while tying up
capital for longer than the business can tolerate. The discounted payback is what surfaces that.

## Financial analysis
10-K based: the two reporting segments (Domestic including Best Buy Health, and International),
the omnichannel model across 1,138 locations, supplier concentration — Apple, Samsung, HP, LG
and Sony account for roughly **57%** of merchandise purchases, which is the key margin risk
given Best Buy holds no long-term supply contracts — and Q4 seasonality.

**Risk management** from the MD&A: interest rate swaps as fair-value hedges against the $500M
notes due 2028, and foreign currency forward contracts on receivables and payables, with gains
and losses recorded directly in earnings.

## Skills
Capital budgeting (NPV, IRR, PI, discounted payback) · WACC construction · cash flow projection ·
10-K and MD&A analysis · hedging instruments (interest rate swaps, FX forwards) · supplier
concentration risk

📄 [Report](best-buy-report.docx) · 📊 [Model](best-buy-capital-budgeting-model.xlsx)

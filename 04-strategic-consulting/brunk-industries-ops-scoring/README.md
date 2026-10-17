# Brunk Industries — Operational Performance Scoring

**Composite metric design · formula validation · portfolio segmentation**

> Delivered during my Financial Analyst internship at **Brunk Industries** (May–Jun 2025),
> working with Max Morales, Nithin Reddy and Jonathan Lang. One of three executive
> presentations delivered that summer.

## Problem
Brunk Industries, a precision contract manufacturer, needed a way to tell which of its
manufactured parts were quietly losing money. The existing in-house "OPS" metric produced
values so small they offered no real prioritisation between parts. The brief: build a better
composite score, prove it works against the incumbent, and use it to guide where the business
should invest.

## The metric we built

A weighted composite — the higher the score, the more problems and lost opportunity a part
carries:

```
OPS = ( SC × (1.5·S + 5000·R + 100·NC) + 71.185 × (SH + Q + I + SU) ) / Revenue or Manufacturing
```

| Term | Meaning |
|---|---|
| `SC` | Standard cost per unit |
| `S` | Scrap generated per production run |
| `R` | RMA count (returns) |
| `NC` | Non-conformance count |
| `SH` | Sorting hours |
| `Q` | Quality inspection time |
| `I` | Inspection time |
| `SU` | Setup time |

The weights are the argument. Returns carry a 5000× multiplier and non-conformances 100× against
scrap's 1.5× — because a returned part has already consumed its full manufacturing cost, shipping,
and the customer relationship, while scrap is caught in-house and costs only materials and time.
A metric that treats those as comparable will keep recommending scrap reduction while returns
quietly destroy margin.

Scoring against both **revenue** and **manufacturing cost** gives two lenses: operational burden
and return efficiency per dollar earned.

## Validation

Tested against Brunk's existing metric on five critical parts. The two approaches disagreed
sharply — which was the finding, not a problem:

- One part ranked **highest** on our manufacturing-based OPS (1.0567) and near the bottom on
  Brunk's (0.0686).
- Another ranked high on Brunk's per-part metric (0.2656) but showed low manufacturing impact
  on ours (0.0269).

Brunk's "OPS Per Part" values are extremely small in absolute terms and don't separate parts
meaningfully unless scaled or contextualised. Our formula surfaces the operational burden —
scrap, rework, quality time — more clearly, and the revenue-based variant adds financial context
that Brunk's metric misses entirely.

## Portfolio segmentation

Plotting manufacturing OPS against revenue OPS by industry, with medians and outliers, sorted
Brunk's book into four groups:

| Group | Industries | Read | Action |
|---|---|---|---|
| **Stars** | Industrial, Electronics | High efficiency, high revenue retention | Grow — they absorb scale efficiently. Study and replicate the processes |
| **Cash cows** | Automotive, Medical, Marine | High efficiency, consistent | Hold production; the losses are post-production, so investigate there |
| **Question mark** | Computer | Low efficiency, high revenue retention | High sale prices are masking manufacturing problems. Target for lean |
| **Dogs** | Consumer, Government | Low efficiency, low revenue retention | Scale down or exit absent a strategic reason; reallocate |

The useful call is the Computer segment. High revenue retention makes it look healthy on a
financial view alone, and the two-axis plot is what exposes that the margin is coming from
pricing power rather than operational performance — which makes it the best lean target in the
portfolio rather than a segment to leave alone.

## Structure
Framed as **Situation–Complication–Question**, then Identification → Analysis → Conclusion →
Recommendation.

## Outcome
Presented to Brunk's leadership as part of a set of three proposals, all of which were approved.

## Skills
Composite metric design and weighting · formula validation against an incumbent benchmark ·
outlier and median analysis · two-axis portfolio segmentation (BCG-style) · manufacturing
operations · SCQ framing · client-facing recommendation

📄 [Full presentation](brunk-ops-score-presentation.pdf) · 19 slides

# Gourmet Wafers — Operations Strategy

**Demand forecasting · capacity planning · inventory policy · facility layout**

## Problem
A small artisan bakery scaling up. Work out what next year's demand actually looks like, whether
the existing equipment can meet it, and how to hold the supply chain together through a severe
seasonal peak — without losing the gourmet quality the brand sells on.

## Approach and findings

**Forecasting.** Applied a 20% annual growth factor to a seasonally indexed baseline. Last year
averaged 1,625 boxes/month → next-year average of **1,950 boxes/month**. But the December
seasonality index is **1.97**, so the number that matters for planning is peak demand of
**3,842 boxes** — roughly 2,096 cookies per day through the holiday rush.

Planning to the average here would have under-built capacity by nearly half. The seasonal index
is the whole analysis.

**Capacity.** Oven capacity is 3,840 cookies per 8-hour shift, so one oven covers the 2,096/day
peak with room to spare. The recommendation is still a **semi-automated** portioning and topping
step — not for throughput, but to hold each cookie at 25g ± 2g. That cuts ingredient giveaway
and protects the quality claim, while leaving a 20% buffer for surges and downtime.

**Inventory.** Reorder point for pecans set at **131 kg**, from a safety stock sized to a 95%
service level (z ≈ 1.65) against a 7-day lead time and observed demand variability. The point of
a service-level-based ROP rather than a fixed reorder quantity is that it prices the risk of a
stockout explicitly — at 95%, the line stops roughly one cycle in twenty, which is acceptable in
March and not in December.

**Layout and location.** Product-oriented line flow (mixing → baking → cooling → packaging) to
minimise movement and maintain hygiene. Siting near the Massachusetts demand cluster saves an
estimated **$2/box** in logistics and supports a single tight 8-hour December shift at 10 batches
daily, with slack for cleaning and admin rather than overtime.

## What I'd do differently
Every number rests on one seasonality index from a single year of history. One year cannot
separate genuine seasonality from a one-off good December. I'd want three years before committing
capital to the capacity plan, and I'd run the ROP at several service levels to show what the
safety stock actually costs.

## Skills
Demand forecasting with seasonal indexing · capacity planning · process selection ·
reorder point and safety stock (service-level method) · facility layout · location analysis ·
work measurement

📄 [Full analysis](gourmet-wafers-operations-strategy.pdf)

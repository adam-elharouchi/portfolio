# AeroShield — Operations Management Platform

**Client capstone · throughput and cycle-time analysis · bottleneck identification · capacity planning**

### ▶ [Open the live platform](https://adam-elharouchi.github.io/portfolio/04-strategic-consulting/aeroshield-operations-capstone/platform.html)

> Operations Management capstone, Hult International Business School, Spring 2026.
> Team 5. The platform, deck and throughput model here are my own work.

## Problem
AeroShield Materials manufactures aerogel-insulated glass units (IGUs). The company was moving
from a low-volume pilot line to industrial-scale production and needed an operational
diagnostic: where the bottleneck sits, what throughput the proposed line can actually sustain,
and what has to change to hit the target.

## What we delivered

Rather than hand the client a slide deck and a spreadsheet, the final deliverable is a working
**operations management platform** — a plant manager can open it and use it. Six modules:

| Module | What it does |
|---|---|
| **Plant Manager Dashboard** | Live operational KPIs — aerogels produced, IGUs completed, yield rate post-CPD, scrap/rework, molding output, order fulfilment — each against target |
| **Capacity & Scheduling** | Shift and line scheduling against demand |
| **Inventory Management** | Stock levels and reorder control |
| **KPI Tracker** | Weekly performance trending with targets |
| **Lean Manufacturing Analysis** | Waste identification across the process |
| **Implementation Plan** | Phased rollout |

Built as a self-contained HTML application with interactive inputs and charts — no install, no
licence, nothing for the client to maintain.

The point of shipping a tool rather than a report is that a report is read once and filed. The
constraint analysis underneath this only stays useful if someone re-runs it when the inputs
change, which means the plant manager has to be able to do it without us.

## The analysis underneath

The operational profile sits at **high volume / low variety / low variation / low visibility** —
the left side of the 4Vs spectrum, characteristic of standardised batch process manufacturing.
That classification is what justifies capital-intensive automation and high equipment
utilisation over flexibility.

The analysis is built around **cycle time per stage**, because in a batch chemical process the
stage with the longest cycle sets the rate for the entire line regardless of how fast every
other stage runs. Adding capacity anywhere other than the binding constraint buys nothing. The
model compares two operating phases stage by stage to locate that constraint, then sizes the
recommendations against it — which is why the leading technology recommendation targets the
vessel stage specifically rather than proposing general capacity increases.

## Files
- **[`platform.html`](platform.html)** — the operations platform
  ([open live](https://adam-elharouchi.github.io/portfolio/04-strategic-consulting/aeroshield-operations-capstone/platform.html))
- [`aeroshield-operations-portfolio.pptx`](aeroshield-operations-portfolio.pptx) — 10-slide
  operations portfolio: 4Vs analysis, polar diagram, process map, throughput and cycle time,
  delivery strategy, technology recommendations
- [`throughput-cycle-time-model.xlsx`](throughput-cycle-time-model.xlsx) — 5-sheet model: key
  assumptions and shift structure, throughput time, cycle time, phase comparison, delivery strategy

## Skills
4Vs framework · process mapping and classification · throughput and cycle-time analysis ·
bottleneck / theory-of-constraints reasoning · capacity planning · operational KPI definition ·
lean analysis · building a usable client tool rather than a static report

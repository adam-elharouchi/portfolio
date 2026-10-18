# Korn Ferry — Measuring Whether AI Makes Consulting Work Better

**Live client challenge · strategy · metric design · productisation**

> Business Strategy, Hult International Business School. Team 2 — Adam El Harouchi,
> Artur Khlgatyan, Beatrice Mockute, Daniela Guachalla, Ellie Scalzo.

## The question
Korn Ferry has 10,000+ employees on GenAI tools. Early signals show value in speed, quality and
capacity — but adoption is uneven and the top 25% of users generate nearly all the meaningful
gains. KF put the problem to us directly: *"Beyond time saved, how do you define and measure
AI's impact on performance and outcomes? We don't have a clear answer."*

## The reframe

Everyone in the industry measures **time saved**: hours per week, daily active users, token
consumption, self-reported productivity, adoption percentage.

**Saving two hours producing a mediocre report is not value.** For a consulting firm, quality
*is* the product and speed is a byproduct — so the entire industry is measuring the wrong thing.

Time saved also fails on its own terms. It is **biased** (self-report creates positivity bias),
**unscalable** (surveying 10,000+ people repeatedly is unreliable — KF confirmed this), and
**meaningless to shareholders** ("we saved X hours" says nothing about competitive output).

## What the data showed

| How consultants use AI | Share |
|---|---|
| Assistant — simple tasks | 85% |
| Researcher — pull information | 71% |
| Creator — drafting | 64% |
| Thought partner — strategic | 53% |

Usage drops as strategic complexity rises. High-proficiency users operate in all four modes and
report stronger impact; low-proficiency users stay in assistant tasks. 30–45% report gains but
only ~25% see large ones.

And the root cause: **KF has no defined quality benchmark for consulting deliverables.** You
cannot measure improvement against a baseline that does not exist.

## The proposal — two connected systems

**System 1 · AI Output Audit Trail** — stop asking employees how AI helped; let the work answer.
1. Define a quality rubric per recurring deliverable type — completeness, insight depth, client
   relevance, accuracy, turnaround — with existing high-rated outputs as the benchmark
2. A binary AI-assisted flag in existing project tools. No behavioural tracking, no prompt capture
3. Managers score deliverables against the rubric, building a dataset of AI-assisted vs. baseline
   by type, team, practice area and proficiency
4. A quality dashboard showing score trends against AI adoption

**System 2 · Knowledge Flywheel** — every KF consultant using generic AI starts from zero,
ignoring decades of proprietary frameworks. Feed Success Profiles, competency models, assessment
frameworks and anonymised high-scoring deliverables into a RAG layer. When the Audit Trail
identifies a high-scoring output, it is reviewed and added back.

**The loop:** consultant prompts AI using the KF knowledge layer → output tagged → Audit Trail
scores it → high scorers feed the Flywheel → the knowledge layer improves → the next interaction
starts smarter. Every cycle raises the quality floor.

The metric stops being hours saved and becomes **time-to-insight compression** — how much faster
the firm reaches a high-quality output on a given deliverable type, quarter over quarter.

## Why it was credible

We ran a feasibility table rather than asserting it was buildable. The quality rubric, AI-assist
flag, PII sanitisation and time-to-insight metric are all **ready now** on what KF already has;
manager scoring and the dashboard are a small lift; only the RAG layer is a medium build.

Delivered with a three-phase roadmap (0–3, 3–6, 6–12 months) from baseline through pilot to
firm-wide scale.

## The commercial turn
The recommendation does not stop at fixing an internal problem. Every KF client facing the same
measurement question is a buyer, so the system becomes a **client-facing offering** under KF's
own "AI Ready" framework — backed by *"here's how we measured it on our own work, here's the
data, we can build the same for you."* Plus a compounding moat: as the Flywheel grows, KF's AI
becomes more capable than any generic model.

> **They measure time saved. We measure quality gained.**

## Skills
Problem reframing · metric and rubric design · Situation–Complication–Question framing ·
survey-data analysis · feasibility assessment against existing infrastructure · phased
implementation roadmapping · productising an internal capability · client-facing presentation

📄 [Full presentation](korn-ferry-ai-quality-measurement.pdf) · 13 slides

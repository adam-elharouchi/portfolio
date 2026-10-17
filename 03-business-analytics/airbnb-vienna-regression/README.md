# Airbnb Vienna — Price Regression

**Regression · SEMMA methodology · 8,302 listings**

## Problem
What drives the nightly price of an Airbnb listing in Vienna, and how much of it can be explained
from the data a host controls?

## Data
8,302 active Vienna listings from [Inside Airbnb](https://insideairbnb.com/get-the-data/).

## Approach
Structured end to end on **SEMMA** — Sample, Explore, Modify, Model, Assess — rather than an
ad-hoc notebook flow, so each stage's decisions are documented and reviewable.

## Result
**R² = 0.13.** The model explains 13% of the variance in listing price.

That is a weak model, and the write-up says so plainly rather than dressing it up. The remaining
87% is driven by factors absent from the dataset: photo quality, amenities, host responsiveness,
and proximity to specific attractions.

The coefficients are still informative where the model is confident:

- **Room type is the strongest predictor.** Entire homes command roughly a **+€27** premium over
  private rooms — the single largest effect in the model.

## Business recommendations
Delivered for two audiences:

- **Hosts** — list as an entire home wherever the property allows it; it is the largest
  controllable price lever in the data.
- **Platform/analysts** — pricing guidance built only on structured listing attributes will be
  weak. The variance lives in unstructured signals (images, review text, amenity detail).

The report includes an explicit section translating R² and MSE into plain language for
non-technical readers.

## What I'd do differently
A linear model on raw price is the wrong shape for this problem. Price distributions are heavily
right-skewed, so a log transform of the target would likely improve fit considerably. Gradient
boosting would capture the interactions a linear model misses, and amenity text is the obvious
missing feature set.

[📓 Open the notebook](Vienna_Airbnb_Regression_Group3.ipynb) · Group project, Group 3

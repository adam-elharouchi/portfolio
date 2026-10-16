# PCA on Handwritten Digits

**Dimensionality reduction · principal component interpretation**

## Problem
Apply PCA to handwritten digit images and, rather than treating the components as abstract
coordinates, work out **what each principal component actually represents** in the original
8×8 pixel space.

## Approach
1. Isolate the digit-8 subset of the digits dataset
2. Fit PCA and extract component loadings
3. Reshape each component's pixel weights back into the 8×8 image layout
4. Render as heatmaps and interpret the visual pattern

## Result
Reshaping the loadings back into image space makes the components legible:

- **PC1** — strongest weights concentrated in the central region, capturing the dominant mode of
  variation in how an 8 is formed overall.
- **PC2** — strongest positive weights around the upper loop, capturing variation in how people
  draw the top of the 8: thicker, rounder, or narrower.

The point of the exercise is that a principal component is not an abstraction. Mapped back to the
input space, PC2 has a concrete meaning — "how is the top loop drawn" — and that interpretability
is what makes PCA a reasoning tool rather than just a compression step.

## What I'd do differently
Scope is a single digit class. Running the same loading-visualisation across all ten digits would
show which components are shared handwriting variation versus digit-specific, and I'd quantify
the explained-variance ratio to say how much structure the first two components actually capture.

[📓 Open the notebook](Digit_8.ipynb)

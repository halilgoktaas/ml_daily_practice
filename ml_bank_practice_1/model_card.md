```markdown
# Model Card — Bank Marketing Term Deposit Prediction

## Model Overview

This project builds machine learning models to predict whether a customer will subscribe to a bank term deposit based on campaign and customer features.

Two separate models are produced to avoid data leakage and support different operational use cases:

1. Post-call prediction model (includes call duration)
2. Pre-call targeting model (excludes call duration — deployment realistic)

Both models are implemented as full sklearn Pipelines including preprocessing and classifier.

Best performing algorithm in both scenarios: **XGBoost**

---

## Intended Use

### Primary Use Case — Pre-Call Targeting (Recommended)

Predict subscription probability **before calling** a customer to:

- prioritize outreach lists
- optimize call center capacity
- improve conversion per call
- support threshold-based campaign strategy

Model file:
```

models/model_pre_call_no_duration.joblib

```

---

### Secondary Use Case — Post-Call Analysis

Estimate conversion likelihood after call interaction features are known.

Model file:
```

models/model_post_call_with_duration.joblib

```

Not suitable for pre-call targeting due to duration leakage.

---

## Dataset

UCI Bank Marketing — bank-additional-full

- Samples: 41,188
- Features: demographic, financial, macroeconomic, campaign history
- Target: term deposit subscription (binary)
- Class imbalance: ~11% positive
- Missing values: none

---

## Preprocessing

Implemented inside Pipeline:

- Numeric → StandardScaler
- Categorical → OneHotEncoder(handle_unknown="ignore")
- No manual preprocessing outside pipeline
- Prevents train/validation leakage

Split strategy:

- Stratified train/validation split
- test_size = 20%
- fixed random_state

---

## Models Evaluated

- Logistic Regression (balanced)
- Random Forest (balanced_subsample)
- XGBoost

Selection metric priority:

1. ROC-AUC
2. PR-AUC (important for imbalance)

---

## Performance Summary

### Post-Call Scenario (with duration)

Best model: XGBoost

- ROC-AUC: 0.954
- PR-AUC: 0.691

---

### Pre-Call Scenario (no duration)

Best model: XGBoost

- ROC-AUC: 0.808
- PR-AUC: 0.484

Performance reduction is expected and confirms proper leakage control.

---

## Threshold Strategy

Predictions are probability-based.  
Final class decision depends on threshold selection.

Two threshold strategies are supported:

### F1-Optimal Threshold
Balances precision and recall.

### Cost-Optimal Threshold
Based on business assumption:

- False Positive cost = 1
- False Negative cost = 6

This supports recall-oriented campaign strategies.

---

## Feature Importance (Pre-Call Model)

Top predictive signals include:

- nr.employed
- poutcome_success
- month
- emp.var.rate
- pdays
- euribor3m
- contact channel

These features align with campaign timing and macroeconomic context.

---

## Limitations

- Dataset is historical and static
- No time-based validation split
- No concept drift handling
- Cost assumptions are hypothetical
- Model not calibrated
- No fairness analysis performed
- Not validated on external dataset

---

## Leakage Considerations

Feature: **duration**

- Only known after call completion
- Causes unrealistic performance if used for pre-call prediction

Mitigation:

- Separate no-duration model trained and evaluated
- Recommended model excludes duration

---

## Ethical & Operational Risks

- Outreach optimization may affect customer experience
- Aggressive recall thresholds increase call volume
- Should be used with contact frequency limits
- Requires campaign policy constraints

---

## Deployment Notes

- Model artifact includes preprocessing + classifier
- Input schema must match training columns
- OneHotEncoder handles unseen categories safely
- Recommended to monitor prediction distribution after deployment

---

## Future Improvements

- Cross-validation tuning
- Probability calibration
- Cost curve visualization
- Uplift modeling
- Time-based validation
- Real campaign ROI simulation

```

---

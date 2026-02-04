```markdown
# Bank Marketing Term Deposit Prediction — End-to-End ML Project

This project builds an end-to-end machine learning pipeline to predict whether a bank customer will subscribe to a term deposit based on marketing campaign data.  
The goal is to support smarter call targeting and improve campaign efficiency using probability-based ranking and threshold optimization.

The project includes full preprocessing, model comparison, threshold strategy, cost-sensitive decision analysis, and leakage-aware scenario design.

---

## Problem Definition

Banks run outbound call campaigns to sell term deposits. Contacting every customer is costly and inefficient.  
We aim to build a model that estimates **subscription probability** and supports:

- better lead prioritization
- threshold-based outreach decisions
- cost-aware campaign strategy

Target variable:  
`y = 1` → customer subscribes  
`y = 0` → customer does not subscribe

---

## Dataset

Source: UCI Bank Marketing Dataset (bank-additional-full)

- Rows: 41,188
- Features: 20 predictors + target
- Mixed numeric and categorical variables
- Missing values: none
- Class distribution:
  - Positive ≈ 11.3%
  - Negative ≈ 88.7%
- Strong class imbalance → PR-AUC and threshold tuning are emphasized.

---

## Leakage-Aware Modeling Design

One feature — **call duration** — is only known after the call is completed.  
Using it for pre-call targeting would create data leakage.

Therefore, two separate scenarios are modeled:

### Scenario A — Post-Call Prediction (with duration)
Use case: predict conversion after call features are known.

### Scenario B — Pre-Call Targeting (no duration)
Use case: decide **who to call** before dialing.  
This scenario is deployment-realistic and leakage-free.

Both scenarios are trained and evaluated separately.

---

## Preprocessing Pipeline

Implemented using sklearn Pipeline + ColumnTransformer:

- Numeric features → StandardScaler
- Categorical features → OneHotEncoder(handle_unknown="ignore")
- Full preprocessing is inside the model pipeline (no manual leakage)

Train/validation split:

- test_size = 0.20
- stratified by target
- fixed random_state for reproducibility

---

## Models Compared

Three classifiers are trained and evaluated under identical pipelines:

- Logistic Regression (class_weight=balanced)
- Random Forest (balanced_subsample)
- XGBoost

Evaluation metrics:

- ROC-AUC
- PR-AUC (primary due to class imbalance)

---

## Model Performance

### Scenario A — Post-Call (with duration)

| Model | ROC-AUC | PR-AUC |
|--------|---------|---------|
| XGBoost | **0.9544** | **0.6907** |
| Random Forest | 0.9490 | 0.6779 |
| Logistic Regression | 0.9438 | 0.6222 |

Best model: **XGBoost**

---

### Scenario B — Pre-Call (no duration)

| Model | ROC-AUC | PR-AUC |
|--------|---------|---------|
| XGBoost | **0.8078** | **0.4837** |
| Logistic Regression | 0.8009 | 0.4600 |
| Random Forest | 0.7846 | 0.4313 |

Best model: **XGBoost**

Performance drops as expected when removing the leakage feature — this confirms correct scenario separation.

---

## Threshold Strategy

Default threshold (0.50) is not optimal under class imbalance.  
Thresholds are evaluated across a grid using:

- Precision
- Recall
- F1
- Positive prediction rate
- Expected business cost

Two operating points are selected:

### Best F1 Threshold
Balanced precision/recall tradeoff.

### Cost-Aware Threshold
Uses cost assumptions:

- False Positive cost = 1
- False Negative cost = 6  
(missing a real subscriber is more expensive than an extra call)

Example — Pre-Call scenario:

| Strategy | Threshold | Precision | Recall | F1 |
|------------|------------|------------|------------|------|
F1-optimal | 0.25 | 0.512 | 0.555 | 0.533 |
Cost-optimal | 0.15 | 0.438 | 0.625 | 0.515 |

---

## Feature Importance (Pre-Call XGBoost)

Top drivers include:

- nr.employed
- poutcome_success
- month_oct
- emp.var.rate
- pdays
- cons.conf.idx
- contact type
- euribor3m

These variables strongly influence subscription probability and can guide campaign strategy.

---

## Saved Artifacts

Trained pipelines are saved for reuse:

```

models/model_post_call_with_duration.joblib
models/model_pre_call_no_duration.joblib

```

Each artifact includes preprocessing + model in a single pipeline.

---

## Key Business Takeaways

- Probability ranking is more useful than raw class prediction.
- Threshold selection must reflect campaign capacity and cost structure.
- Duration creates leakage for pre-call targeting and must be excluded.
- XGBoost consistently performs best across both realistic and post-call scenarios.
- Cost-aware thresholds significantly change outreach volume vs capture rate.

---

```

# Daily ML Practice — Bank Marketing Classification and Threshold Optimization

## Overview

This study is a daily machine learning practice project built after completing a 30-day data scientist challenge, with the goal of maintaining modeling, evaluation, and business interpretation skills through continuous hands-on work.

The project focuses on predicting whether a bank customer will subscribe to a term deposit based on marketing campaign and customer profile features. Multiple classification models are trained and compared, and the decision threshold is optimized using both metric-based and cost-aware approaches.

## Dataset

Dataset: Bank Marketing (UCI Bank Marketing dataset variant)

- Rows: 41,188  
- Features: 20 input features + 1 target  
- Target: `y` (yes/no → converted to binary)  
- Class distribution: ~11% positive, ~89% negative (imbalanced)  
- Missing values: None detected

Important operational note:  
The feature `duration` (call duration) may only be known after a call is completed. If the deployment scenario is pre-call targeting, the model should be retrained without this feature to avoid data leakage.

## Objective

Build and evaluate classification models that can:

- Rank customers by likelihood of subscription
- Support campaign targeting decisions
- Optimize decision threshold based on business priorities
- Translate model outputs into operational recommendations

## Workflow

1. Data loading and validation
2. Target encoding (yes/no → 1/0)
3. Exploratory checks and class balance analysis
4. Train/validation split with stratification
5. Preprocessing pipeline
   - Numeric: median imputation + standard scaling
   - Categorical: most frequent imputation + one-hot encoding
6. Model training and comparison
7. Probability-based evaluation (ROC-AUC, PR-AUC)
8. Threshold analysis
   - Metric-based (F1)
   - Cost-aware threshold selection
9. Final evaluation and business interpretation

## Models Compared

- Logistic Regression (class-balanced)
- Random Forest
- XGBoost

Evaluation metrics:

- ROC-AUC
- PR-AUC
- Precision / Recall / F1 at different thresholds

Best validation performance:

- Best model: XGBoost
- ROC-AUC ≈ 0.95
- PR-AUC ≈ 0.69

## Threshold Optimization

Because the dataset is imbalanced, the default 0.50 threshold is not optimal.

Two operating thresholds were analyzed:

### Metric-Balanced Threshold (Best F1)

- Threshold ≈ 0.35
- Higher precision–recall balance
- Lower outreach volume
- Suitable when call capacity is limited

### Cost-Aware Threshold

Using an example cost model:

- False Positive cost = 1 (unnecessary call)
- False Negative cost = 6 (missed potential subscriber)

Result:

- Threshold ≈ 0.15
- Much higher recall
- More customers contacted
- Suitable when missing a subscriber is more expensive than making extra calls

## Business Interpretation

The model can be used as a campaign scoring tool:

- Score all customers
- Rank by predicted probability
- Select threshold based on operational capacity and ROI targets

If campaign capacity is constrained:
- Use higher threshold (precision-oriented)

If revenue capture is prioritized:
- Use lower threshold (recall-oriented)

Threshold should be reviewed together with business stakeholders using real call cost and conversion revenue figures.

## Reproducibility

Main steps are implemented in a single end-to-end notebook:

- Data loading
- Pipeline preprocessing
- Model comparison
- Threshold table generation
- Cost-based threshold evaluation
- Final confusion matrix and classification report

Random seeds are fixed where applicable.

## Next Improvements

- Retrain without post-outcome features such as call duration for pre-call deployment scenarios
- Add probability calibration
- Perform cross-validation
- Add cost curves and lift charts
- Convert notebook into modular training and evaluation scripts

## Purpose of This Project

This project is part of a continuous daily ML practice routine designed to:

- Maintain modeling fluency
- Practice threshold and cost-based decision logic
- Strengthen business-oriented ML interpretation
- Produce recruiter-reviewable, reproducible ML work samples

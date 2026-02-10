# SQL + Python Analytics Practice — Bank Marketing Dataset

## Project Overview

This practice study focuses on analytical exploration of the Bank Marketing dataset using a combined **SQL + Python analytics workflow**. The objective is to simulate a real-world data analyst process: importing data into a relational database, performing segmentation queries in SQL, and reproducing analytical insights in Python with EDA and visualizations.

The study intentionally excludes predictive modeling and focuses on **data understanding, segmentation, and business insight generation**.

---

## Dataset

Source: Bank Marketing Dataset (Kaggle)

The dataset contains customer demographics, financial attributes, and campaign interaction variables related to a term deposit marketing campaign.
Target variable:

* `deposit` — whether the client subscribed to the term deposit (yes/no)

Main feature groups:

* Demographic: age, job, marital, education
* Financial: balance, housing loan, personal loan, default status
* Campaign: contact type, duration, campaign count, previous outcome

---

## Folder Structure

```
sql_with_python_2_analytics/
│
├── data/
│   └── bank.csv
│
├── sql/
│   └── 01_queries.sql
│
└── notebook/
    └── 02_python.ipynb
```

---

## Workflow

### 1. Database Layer (PostgreSQL / pgAdmin)

* Created relational table
* Imported CSV dataset into database
* Performed analytical SQL queries including:

  * target distribution
  * segment conversion rates
  * age bands
  * job-based performance
  * balance quintiles (NTILE)
  * campaign attempt bands
  * call duration bands
  * contact channel comparison
  * cross-segment conversion analysis

SQL queries focus on **conversion rate computation and segment behavior**.

---

### 2. Python Analytics Layer

Python notebook reproduces and extends SQL findings using pandas and matplotlib.

Main steps:

* Data loading with relative path
* Structure inspection (shape, info, describe)
* Duplicate check
* Missing value ratio analysis
* Target distribution analysis
* Segment feature engineering:

  * age bands
  * balance quintiles
  * duration bands
  * campaign attempt bands
* Grouped conversion rate calculations
* Segment-based visualizations
* Crosstab analysis for key categorical variables

No predictive model was built in this practice by design.

---

## Data Quality Findings

* No duplicate records detected
* No missing values across columns
* Dataset is analysis-ready without preprocessing imputation
* Target distribution is moderately imbalanced but usable for segmentation analysis

---

## Key Analytical Findings

* Customers aged 60+ show the highest conversion rates among all age groups
* Conversion increases consistently across higher balance segments
* Students and retired customers are the most responsive job segments
* Conversion decreases as campaign contact count increases, indicating diminishing returns
* Longer call durations correlate with higher acceptance, but this variable represents post-contact information and may cause leakage in predictive models
* Cellular and telephone channels outperform unknown contact types
* Customers without housing loans convert at higher rates than those with active housing credit

---

## Business Recommendations

* Prioritize high-balance and senior customer segments
* Target responsive job categories such as retirees and students
* Focus on first-contact quality rather than repeated contact attempts
* Optimize channel selection toward known and direct contact methods
* Exclude post-interaction variables such as call duration in predictive modeling scenarios

---

## Purpose of This Practice

This project demonstrates:

* SQL analytical querying skills
* Python EDA and segmentation analytics
* Cross-tool analytical consistency
* Business-oriented interpretation of data
* Structured daily analytics practice workflow

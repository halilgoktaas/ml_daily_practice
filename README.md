## Day 04 — SaaS Churn Analytics (SQL + Python)

In this practice, a real-world telecom subscription dataset (Telco Customer Churn) was analyzed using SQL and Python.

### Scope
- SQL churn and segmentation queries (PostgreSQL)
- Python analytics and KPI computation
- Segment-based churn analysis
- Tenure-based retention proxy
- High-risk customer rule definition
- Revenue loss and LTV proxy estimation

### Key Analyses
- Overall churn rate and revenue exposure
- Churn by contract, payment method, and internet service
- Tenure group retention proxy analysis
- High-risk segment rule: Month-to-month + low tenure + high monthly fee
- LTV proxy = MonthlyCharges × Tenure
- Top revenue-risk churned customers

### Business Outcome
Identified high-risk customer segments and contract-driven churn patterns. Results support targeted retention campaigns and early-lifecycle intervention strategies.
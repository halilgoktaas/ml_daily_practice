--Q1)Genel Churn Oranı
SELECT
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS churn_rate_pct
FROM public.deneme;

--Q2) CONTRACT Türüne göre churn oranı ve en riskli contract
SELECT
    contract,
    COUNT(*) AS n,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS churn_rate
FROM public.deneme
GROUP BY contract
ORDER BY churn_rate DESC;

--Q3) Tenure segment chrun rate
SELECT
    CASE
        WHEN tenure < 12 THEN '0-12'
        WHEN tenure < 24 THEN '12-24'
        WHEN tenure < 48 THEN '24-48'
        ELSE '48+'
    END AS tenure_group,
    COUNT(*) AS n,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM public.deneme
GROUP BY tenure_group
ORDER BY tenure_group;

--Q4) Ortalama monthly charges chrun vs non-churn
SELECT
    churn,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly
FROM public.deneme
GROUP BY churn;

--Q5) En yüksek churn olan payment method
SELECT
    paymentmethod,
    COUNT(*) AS n,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS churn_rate
FROM public.deneme
GROUP BY paymentmethod
ORDER BY churn_rate DESC;

--Q6) İnternet servis türüne göre churn
SELECT
    internetservice,
    COUNT(*) AS n,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM public.deneme
GROUP BY internetservice
ORDER BY churn_rate DESC;

--Q7) Churn eden müşteriler arasında en pahalı aylık ücrete sahip ilk 10 kişi
SELECT * 
FROM (
    SELECT
        customerid,
        monthlycharges,
        RANK() OVER(ORDER BY monthlycharges DESC) AS rnk
    FROM public.deneme
    WHERE churn = 'Yes'
) t
WHERE rnk <= 10;

--Q8) Tenur'a göre müşteri yüzdelik dilimi
SELECT
    customerid,
    tenure,
    NTILE(5) OVER (ORDER BY tenure) AS tenure_quintile
FROM public.deneme;

--Q9) High-risk segment month to month + tenure < 12 + high fee churn oranı
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2
    ) AS churn_rate_high_risk
FROM public.deneme
WHERE contract = 'Month-to-month'
    AND tenure < 12
    AND monthlycharges > 70;

--Q10) Aylık tahmini gelir kaybı
SELECT
    ROUND(SUM(monthlycharges), 2) AS monthly_revenue_lost
FROM public.deneme
WHERE churn = 'Yes';

--Q11)
SELECT
  contract,
  paymentmethod,
  COUNT(*) AS n,
  ROUND(100.0 * SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS churn_rate
FROM public.deneme
GROUP BY contract, paymentmethod
ORDER BY churn_rate DESC;

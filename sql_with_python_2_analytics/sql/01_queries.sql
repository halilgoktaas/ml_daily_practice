--Q1) Hedef dağılımı
SELECT
    deposit,
    COUNT(*) AS cnt,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM bank_datasett
GROUP BY deposit
ORDER BY cnt DESC;

--Q2) Yaş segmentine göre dönüşüm oranı
WITH t AS (
    SELECT
        CASE
            WHEN age < 30 THEN '<30'
            WHEN age BETWEEN 30 AND 49 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            WHEN age BETWEEN 50 AND 59 THEN '50-59'
            ELSE '60+'
        END AS age_band,
        deposit
    FROM bank_datasett
)
SELECT
    age_band,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)* 100,2) AS conversion_pct
FROM t
GROUP BY age_band
ORDER BY age_band;

--Q3) İş bazında hacim + dönüşüm oranı
SELECT
    job,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) *100,2) AS conversion_pct
FROM bank_datasett
GROUP BY job
ORDER BY n DESC
LIMIT 10;

--Q4) Eğitim sevisine göre dönüşüm oranı
SELECT
    education,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100,2) AS conversion_pct
FROM bank_datasett
GROUP BY education
ORDER BY conversion_pct DESC;

--Q5) Konut kredisi ve ihtiyaç kredisi etkisi
SELECT
    housing,
    loan,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)*100,2) AS conversion_pct
FROM bank_datasett
GROUP BY housing,loan
ORDER BY n DESC;

--Q6) Bakiye kuantil analizi
WITH t AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY balance) AS balance_quintile
    FROM bank_datasett
)
SELECT
    balance_quintile,
    COUNT(*) AS n,
    ROUND(AVG(balance), 0) AS avg_balance,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) *100,2) AS conversion_pct
FROM t
GROUP BY balance_quintile
ORDER BY balance_quintile;

--Q7) İletişim tipi contract dönüşüm
SELECT
    contact,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)*100,2) AS conversion_pct
FROM bank_datasett
GROUP BY contact
ORDER BY conversion_pct DESC;

--Q8) Arama süresi ile dönüşüm ilişkisi
WITH t AS (
    SELECT
        CASE
            WHEN duration < 60 THEN '<1m'
            WHEN duration BETWEEN 60 AND 179 THEN '1-3m'
            WHEN duration BETWEEN 180 AND 359 THEN '3-6m'
            ELSE '6m+'
        END AS duration_band,
        deposit
    FROM bank_datasett
)
SELECT
    duration_band,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END)*100,2) AS conversion_pct
FROM t
GROUP BY duration_band
ORDER BY n DESC;

--Q9) Kampanya yoğunluğu arttıkça dönüşüm oranı düşüyor mü
WITH t AS (
    SELECT
        CASE
            WHEN campaign = 1 THEN '1'
            WHEN campaign BETWEEN 2 AND 3 THEN '2-3'
            WHEN campaign BETWEEN 4 AND 6 THEN '4-6'
            ELSE '7+'
        END AS campaign_band,
        deposit
    FROM bank_datasett
)
SELECT
    campaign_band,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) *100,2) AS conversion_pct
FROM t
GROUP BY campaign_band
ORDER BY campaign_band;

--Q10) Önceki kampanya sonucu(poutcome) dönüşüm etkisi
SELECT
    poutcome,
    COUNT(*) AS n,
    ROUND(AVG(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) *100,2) AS conversion_pct
FROM bank_datasett
GROUP BY poutcome
ORDER BY conversion_pct DESC;
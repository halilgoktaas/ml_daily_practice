import duckdb
import pandas as pd

df = pd.read_csv('sql_with_python_analytics/data/WA_Fn-UseC_-Telco-Customer-Churn.csv')

con = duckdb.connect('telco.duckdb')   # 👈 dosya burada oluşur

con.execute("CREATE TABLE telco_churn AS SELECT * FROM df")

con.execute("""
COPY telco_churn TO 'telco_churn_export.csv' (HEADER, DELIMITER ',');
""")


con.execute("""
SELECT Contract, COUNT(*)
FROM telco_churn
GROUP BY Contract
""").df()

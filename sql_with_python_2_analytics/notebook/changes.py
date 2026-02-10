import pandas as pd

df = pd.read_csv("sql_with_python_2_analytics/data/bank.csv")

df.columns = df.columns.str.replace("\ufeff", "", regex=False).str.strip()

df = df.rename(columns={"default": "default_status"})
print(df.columns.tolist())

df.to_csv("bank_fixed.csv", index=False, encoding="utf-8")
with open("bank_fixed.csv", "r", encoding="utf-8") as f:
    print(f.readline())




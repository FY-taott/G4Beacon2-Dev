import pandas as pd

df = pd.concat([
    pd.read_csv("HepG2/HepG2_ES00_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("HepG2/HepG2_ES01_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("HepG2/HepG2_ES02_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("HepG2/HepG2_ES03_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("HepG2/HepG2_ES04_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("H9/H9_ES00_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("H9/H9_ES01_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("H9/H9_ES02_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("H9/H9_ES03_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("H9/H9_ES04_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("WT26/WT26_ES00_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("WT26/WT26_ES01_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("WT26/WT26_ES02_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("WT26/WT26_ES03_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
    pd.read_csv("WT26/WT26_ES04_importance_Seq_ranked.csv", usecols=["Feature","Rank"]),
])

res = df.pivot_table(index="Feature", values="Rank", aggfunc="median")
res.to_csv("rank_median_pivot.csv", index=True)
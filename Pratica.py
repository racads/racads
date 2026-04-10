# ATIVIDADE ORIENTADA 1

import pandas as pd
import time
arquivos = [
"202501_NovoBolsaFamilia.csv", "202502_NovoBolsaFamilia.csv", "202503_NovoBolsaFamilia.csv", "202504_NovoBolsaFamilia.csv",
"202505_NovoBolsaFamilia.csv", "202506_NovoBolsaFamilia.csv"
]
inicio = time.time()
dfs = [pd.read_csv(f, encoding="LATIN1", sep=";", engine="python", on_bad_lines="skip") for f in arquivos]
df = pd.concat(dfs)
print(df.head())
tempo = time.time() - inicio
print(f"Pandas: {tempo:.2f}s")


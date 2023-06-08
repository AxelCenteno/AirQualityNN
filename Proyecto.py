import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split

df = pd.read_csv("Cancer_Data.csv")

df["diagnosis"].replace({'B':-1, 'M':1}, inplace=True)

df["diagnosis"] = df["diagnosis"].astype(int)

train, test = train_test_split(df, test_size=0.2)

train.to_csv("train.csv", index=False)
test.to_csv("test.csv", index=False)

plt.show()
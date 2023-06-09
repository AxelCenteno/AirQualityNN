import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split

df = pd.read_csv("Cancer_Data.csv")

df.rename(columns={'radius_mean':'radius', 'texture_mean':'texture', 'perimeter_mean':'perimeter','area_mean':'area',
                   'smoothness_mean':'smoothness', 'compactness_mean':'compactness','concavity_mean':'concavity',
                   'concave points_mean':'concave points','symmetry_mean':'simmetry',
                   'fractal_dimension_mean':'fractal_dimension'}, inplace=True)

df["diagnosis"].replace({'B':-1, 'M':1}, inplace=True)
df["diagnosis"] = df["diagnosis"].astype(int)
df = df.loc[:,['diagnosis','radius','texture','perimeter','area','smoothness','compactness','concavity','concave points','simmetry','fractal_dimension']]
print(df.head())

#Se ajustaron los datos para hacerlos entre un rango aproximado de 0 a 1
#radius 30:1
#texture 40:1
#perimeter 190:1
#area 2500:1
#smoothness 1:5
#compactness 1:3
#concavity 1:2
#concave points 1:5
#simmetry 1:3
#fractal_dimension 1:10

df['radius'] = df['radius'] / 30
df['texture'] = df['texture'] / 40
df ['perimeter'] = df['perimeter'] / 190
df['area'] = df['area'] /2500
df['smoothness'] = df['smoothness'] * 5
df['compactness'] = df['compactness'] * 3
df['concavity'] = df['concavity'] * 2
df['concave points'] = df['concave points'] * 5
df['simmetry'] = df['simmetry'] * 3
df['fractal_dimension'] = df['fractal_dimension'] * 10

print(df.max())
print(df.min())

train, test = train_test_split(df, test_size=0.2)

train.to_csv("train.csv", index=False)
test.to_csv("test.csv", index=False)

plt.show()
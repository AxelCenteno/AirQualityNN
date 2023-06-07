import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split

df = pd.read_csv("AQI and LAT Long of Countries.csv")

plt.subplot(2, 2, 1)
plt.scatter(df["AQI Value"], df["CO AQI Value"])
    
plt.subplot(2, 2, 2)
plt.scatter(df["AQI Value"], df["Ozone AQI Value"])

plt.subplot(2, 2, 3)
plt.scatter(df["AQI Value"], df["NO2 AQI Value"])

plt.subplot(2, 2, 4)
plt.scatter(df["AQI Value"], df["PM2.5 AQI Value"])

df["AQI Category"].replace({"Hazardous":0, "Very Unhealthy":1, "Unhealthy":2, "Unhealthy for Sensitive Groups":3, "Moderate":4, "Good":5}, inplace=True)
df["CO AQI Category"].replace({"Hazardous":0, "Very Unhealthy":1, "Unhealthy":2, "Unhealthy for Sensitive Groups":3, "Moderate":4, "Good":5}, inplace=True)
df["Ozone AQI Category"].replace({"Hazardous":0, "Very Unhealthy":1, "Unhealthy":2, "Unhealthy for Sensitive Groups":3, "Moderate":4, "Good":5}, inplace=True)
df["NO2 AQI Category"].replace({"Hazardous":0, "Very Unhealthy":1, "Unhealthy":2, "Unhealthy for Sensitive Groups":3, "Moderate":4, "Good":5}, inplace=True)
df["PM2.5 AQI Category"].replace({"Hazardous":0, "Very Unhealthy":1, "Unhealthy":2, "Unhealthy for Sensitive Groups":3, "Moderate":4, "Good":5}, inplace=True)

df["AQI Category"] = df["AQI Category"].astype(int)
df["CO AQI Category"] = df["CO AQI Category"].astype(int)
df["Ozone AQI Category"] = df["Ozone AQI Category"].astype(int)
df["NO2 AQI Category"] = df["NO2 AQI Category"].astype(int)
df["PM2.5 AQI Category"] = df["PM2.5 AQI Category"].astype(int)

train, test = train_test_split(df, test_size=0.2)

train.to_csv("train.csv", index=False)
test.to_csv("test.csv", index=False)

plt.show()
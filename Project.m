df = importdata("train.csv");
datos = df.data;
AQI = datos(:,2);
CO = datos(:,4);
OZONE = datos(:,6);
NO2 = datos(:,8);
PM2_5 = datos(:,10);


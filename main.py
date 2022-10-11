import pandas as pd
from sqlalchemy import create_engine
import urllib
import requests
params = urllib.parse.quote_plus("DRIVER={SQL Server Native Client 11.0};"
                                 "SERVER=JPAM;"
                                 "DATABASE=PayU;"
                                 "Trusted_Connection=yes")

engine = create_engine("mssql+pyodbc:///?odbc_connect={}".format(params))
dfFraud = pd.read_sql(
      'Select * FROM PayU.JPAM.tbFraudTestPayU',
  engine)
#Merchant transactions of the categories (column 'category'), that have less than 15000 records.
count_trans_15k = dfFraud.groupby('category').value_counts()
trans_15k = dfFraud.groupby('category').filter(lambda x: len(x) < 15000)
# for x in trans_15k['category']:
# print(x)
# print(trans_15k['category'].value_counts())
#Extract exchange rates from the API and create a new column with the exchange rate all/COP.
exc = requests.get('https://api.exchangerate.host/latest')
#print(exc.json())
#print(dfFraud.columns)
amt_cop=[]
for index,row in dfFraud.iterrows():
    if row['currency'] == 'COP': 
        amt_cop.append(round(row['amt'],2))
    else:
        amt_cop.append(round(row['amt']*(1/exc.json()['rates'][row['currency']])*exc.json()['rates']['COP'],2))
dfFraud['amt_cop'] = amt_cop
#print(dfFraud.iloc[[0,1,2,3,4,5],[4,22,23]])
#Calculate a new column with the first 6 numbers from the 'cc_num' column and name it 'bin'.
dfFraud['bin']= dfFraud['cc_num'].astype(str).str[:6]
#print(dfFraud.iloc[[0,1,2,3,4,5],[1,24]])
#Calculate in a new column in the same table the count of unique card numbers per 'bin' and per 'merchant' in the entire database.
dfFraud['calculation'] = dfFraud.groupby(['bin','merchant'])['cc_num'].transform('nunique')
#Calculate how many ZIP codes were registered for each city.
dfFraud['count_zip'] = dfFraud.groupby(['city'])['zip'].transform('count')
#In different columns, calculate the number of transactions that each payer (first and last name) made at the same time and on the same day as the date of each transaction.
dfFraud['full_name'] = dfFraud['first'] + ' ' + dfFraud['last']
dfFraud['count_trans_person']= dfFraud.groupby(['trans_date_trans_time','full_name'])['cc_num'].transform('count')
#Assign the value 1 in the 'is_fraud' column when the values calculated in the three previous points are above the average. Otherwise, leave the values that are already in that variable.
for index,row in dfFraud.iterrows():
    if row['calculation'] > dfFraud['calculation'].mean() and row['count_zip'] > dfFraud['count_zip'].mean() and row['count_trans_person'] > dfFraud['count_trans_person'].mean():
        row['is_fraud'] = 1
    else:
        row['is_fraud']
#print(dfFraud['calculation'].mean(),dfFraud['count_zip'].mean(),dfFraud['count_trans_person'].mean()) 
dfFraud.to_sql('tbOutTestPayU', engine, schema = 'JPAM' ,if_exists='replace', index=False)
#In a new table, calculate for each merchant ('merchant'), the number of transactions, the sum of the amount of all transactions in Colombian pesos, the number of frauds, the sum of the amount with fraud, the percentage of fraud by number of transactions and by amount, the number of different cards ('cc_num').
dfInfoC = pd.DataFrame()
dfInfoC = dfFraud.groupby('merchant').agg({'trans_num':'count','amt_cop':'sum','is_fraud':'sum','cc_num':'nunique'})
dfInfoC['total_fraud_amt_cop']=dfFraud.groupby('merchant').apply(lambda x: x[x['is_fraud'] == 1]['amt_cop'].sum())
dfInfoC['perc_fraud_trans']=round((dfInfoC['is_fraud']/dfInfoC['trans_num'])*100,2)
dfInfoC['perc_fraud_total']=round((dfInfoC['total_fraud_amt_cop']/dfInfoC['amt_cop'])*100,2)
dfInfoC.rename(columns={'amt_cop':'total_amt_cop','is_fraud':'count_is_fraud','cc_num':'countDis_cc_num'},inplace=True)
dfInfoC = dfInfoC.reset_index()
dfInfoC.to_sql('tbP10PayU', engine, schema = 'JPAM' ,if_exists='replace', index=False)




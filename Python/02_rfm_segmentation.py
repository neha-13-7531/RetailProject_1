import pandas as pd
from datetime import datetime
from data_loader import load_sales_data

df = load_sales_data()

df['invoice_date'] = pd.to_datetime(df['invoice_date'])

snapshot_date = df['invoice_date'].max()

rfm = df.groupby('customer_id').agg({
    'invoice_date': lambda x: (snapshot_date - x.max()).days,
    'invoice_no': 'count',
    'price': 'sum'
})

rfm.columns = ['Recency','Frequency','Monetary']

rfm['R_score'] = pd.qcut(rfm['Recency'],5,labels=[5,4,3,2,1])
rfm['F_score'] = pd.qcut(rfm['Frequency'],5,labels=[1,2,3,4,5])
rfm['M_score'] = pd.qcut(rfm['Monetary'],5,labels=[1,2,3,4,5])

rfm['RFM_SCORE'] = (
    rfm['R_score'].astype(str) +
    rfm['F_score'].astype(str) +
    rfm['M_score'].astype(str)
)

rfm.to_csv("rfm_segments.csv")

print("RFM Segmentation Completed")

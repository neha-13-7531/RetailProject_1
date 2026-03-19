#Purpose:
          # Find products frequently bought together
          # Used for cross-selling insights

import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules
from data_loader import load_sales_data

df = load_sales_data()

basket = df.groupby(['invoice_no','product'])['quantity'] \
           .sum().unstack().fillna(0)

basket = basket.applymap(lambda x: 1 if x > 0 else 0)

frequent_items = apriori(
    basket,
    min_support=0.02,
    use_colnames=True
)

rules = association_rules(
    frequent_items,
    metric="lift",
    min_threshold=1
)

rules.to_csv("product_association_rules.csv")

print(rules.head())

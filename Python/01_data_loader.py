import pandas as pd
import psycopg2

def load_sales_data():

    connection = psycopg2.connect(
        host="localhost",
        database="retail_db",
        user="postgres",
        password="your_password"
    )

    query = """
    SELECT *
    FROM sales;
    """

    df = pd.read_sql(query, connection)

    connection.close()

    return df


if __name__ == "__main__":
    data = load_sales_data()
    print(data.head())

import pandas as pd
from sqlalchemy import create_engine, text
import urllib.parse

host = 'localhost'
username = 'root'
password = urllib.parse.quote_plus('@Badkey..26')

conn_string = f'mysql+pymysql://{username}:{password}@{host}/'

db = create_engine(conn_string)
conn = db.connect()
conn.execute(text("CREATE DATABASE IF NOT EXISTS baby_names"))
conn.close()

database = 'baby_names'
conn_string = f'mysql+pymysql://{username}:{password}@{host}/{database}'
db = create_engine(conn_string)
conn = db.connect()
files = ['usa_baby_names']
for file in files:
    df = pd.read_csv(f'C:\\Users\\Jackson Tengeya\\Desktop\\Baby_Names\\{file}.csv')
    df.to_sql(file, con=conn, if_exists='replace', index=False)
conn.close()

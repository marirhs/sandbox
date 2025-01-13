import duckdb

# Connect to an in-memory DuckDB database
con = duckdb.connect()

# Read the CSV file into a DuckDB relation
df = con.execute("SELECT * FROM read_csv('/Users/shri/Documents/tableau_repository/Datasources/CC_Transactions_01_01_2024_to_09_27_2024.csv')").df()

print(df)
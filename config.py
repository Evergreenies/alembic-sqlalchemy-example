import os

# Database configurations
username = os.getenv("PGUSER", "postgres")
password = os.getenv("PGPASSWORD", "root")
host = os.getenv("PGHOST", "localhost")
port = os.getenv("PGPORT", "5432")
database = os.getenv("BID_DB_NAME", "bidding_db")
connection_timeout = 10
database_engine = "postgresql"

import subprocess
from dotenv import load_dotenv
import os
import sys

# Load environment variables
load_dotenv()

# Variables
DB_NAME = "health_db"
DB_USER = "postgres"
DB_PASS = os.getenv("postgress_pw")

# Check if DB_PASS is None
if DB_PASS is None:
    print("DB_PASS is not set in the .env file")
    sys.exit(1)

# Check if SQL file name is provided
if len(sys.argv) < 2:
    print("No SQL file provided. Usage: python script.py your_sql_file.sql")
    sys.exit(1)

# SQL file
SQL_FILE = sys.argv[1]

# Output file
OUTPUT_DIR = "output"
os.makedirs(OUTPUT_DIR, exist_ok=True)
OUTPUT_FILE = os.path.join(OUTPUT_DIR, os.path.splitext(os.path.basename(SQL_FILE))[0] + "_output.txt")

# Set the PGPASSWORD environment variable and run the psql command
with open(OUTPUT_FILE, 'w') as f:
    env = os.environ.copy()
    env['PGPASSWORD'] = DB_PASS
    subprocess.run(['psql','-d', DB_NAME, '-U', DB_USER, '-f', SQL_FILE], env=env, stdout=f)
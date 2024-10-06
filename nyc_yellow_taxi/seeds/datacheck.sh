#!/usr/bin/env python3
import duckdb
import os.path

try:
  con = duckdb.connect('dbt.duckdb', read_only=True)
  print(con.sql('select * from nynj_zipcodes'))
  if (con.execute('select count(*) as total_zipcodes from nynj_zipcodes').fetchall()[0][0] == 2877):
    print("Your data counts are correct!")
    with open('/home/repl/workspace/successful_data_check', 'w') as f:
      f.write('2877')
  else:
    print("There appears to be an issue with your data counts.")
except duckdb.CatalogException:
  if not os.path.isfile('/home/repl/workspace/nyc_yellow_taxi/seeds/nynj_zipcodes.csv'):
    print("It looks like the nynj_zipcodes.csv file is\n not present in the seeds/ directory.\n\nPlease move the file and try again.\n")
  else:
    print("It looks like your data warehouse doesn't exist yet\n\n Please run the dbt seed command and try again.\n")
# -*- coding: utf-8 -*-
"""
Created on Tue May 23 21:39:43 2023

@author: Giuliana Castellini
"""

import psycopg2
import os
import shutil

os.chdir(input("Please input working directory: "))
database=input("Please enter database name: ")
host=input("Please enter host name: ")
user=input("Please enter user name: ")
password=input("Please enter password: ")
port=input("Please enter port: ")

shutil.unpack_archive("ce.data.0.AllCESSeries.zip",os.getcwd())


insert_query= f"INSERT INTO mydatabase.dataset (series_id,year,period,value,footnote_code) VALUES (%s, %s, %s,%s, %s)"

def import_txt_file(txt_file_path, connection):
    global insert_query
    with open(txt_file_path, 'r') as txt_file:
        lines = txt_file.readlines()

    with connection.cursor() as cursor:
        for i,line in enumerate(lines):
            if i == 0:
                continue
            # Clean the line if necessary and split it into values
            values = line.strip().split('|')

            # Insert values into the table
            cursor.execute(insert_query, values)

        connection.commit()

with open(os.getcwd()+"\script.sql",'r') as sql_file:
    sql_script = sql_file.read()
    

conn=psycopg2.connect(database=database,
                      host=host,
                      user=user,
                      password=password,
                      port=port)

cursor=conn.cursor()
cursor.execute('DROP SCHEMA IF EXISTS mydatabase CASCADE')
cursor.execute('DROP ROLE IF EXISTS web_anon')
cursor.execute('CREATE SCHEMA mydatabase')
cursor.execute('CREATE TABLE mydatabase.dataset (series_id VARCHAR,year INT,period VARCHAR,value float,footnote_code VARCHAR)')
cursor.execute('CREATE TABLE mydatabase.series (series_id VARCHAR,supersector_code VARCHAR,industry_code VARCHAR,data_type_code VARCHAR,seasonal VARCHAR,series_title VARCHAR,footnote_codes VARCHAR, begin_year INT, begin_period VARCHAR,end_year INT, end_period VARCHAR)')

import_txt_file(os.getcwd()+'\ce.data.0.AllCESSeries.txt',conn)
insert_query=f"INSERT INTO mydatabase.series (series_id,supersector_code,industry_code,data_type_code,seasonal,series_title,footnote_codes,begin_year,begin_period,end_year,end_period) VALUES (%s, %s, %s,%s, %s,%s, %s, %s,%s, %s,%s)"
import_txt_file(os.getcwd()+'\ce.series.txt',conn)

cursor.execute(sql_script)
cursor.execute('SELECT * FROM mydatabase.women_in_government')
for role in cursor.fetchall():
    print(role)

conn.close()

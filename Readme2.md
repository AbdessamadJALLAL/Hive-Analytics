# Hive Analytics using Sqoop, Spark in AWS

### RDBMS - Read and Write Many times mechanism, suitable for OLTP operations
### SQOOP - used to load data from RDBMS into HDFS. Does not support aggregation operations, supports MAP only.
### HDFS - Storage layer. HDFS offers High Availability, fault tolerance,Data localization   
### Hive - Data warehousing tool , used for OLAP processing. Write once, Read Many time mechanism. 
### Spark - - IN-MEMORY processing is used when the data is stored in an in-memory data store or an in-memory data structure.


# Dataset used for analysis - AdventureWorks
### Refer data schema's in file : 00_AdventureWorks2008_db_diagram.pdf

# We will try creating customers,creditcard, Individual tables with a subset of data.
### Complete dataset can be located in folder name : AdventureWorks - Complete dataset


# Data Flow : Mysql -> Sqoop -> HDFS -> HIVE -> SPARK -> HIVE

### 1. Refer 01_partial_dataset_creation.sql contains MYsql table creation for partial dataset 
### 2. Refer 02_v_customer_demo.sql , created view for the purpose of data import
### 3. Refer 03_Sqoop-import-commands.txt , contains scoop import commands to import data from Mysql database
### 4. Refer 04_Hive_tables_creation.hql , Contains HIVE tables create statements
### 5. Refer 05_customer_demographic.scala , this is used to fetch demographic XML values into Parquet files
### 6. Refer 06_File_copy_commands(only if needed - optional).txt , in my case have used docker containers and parquet file created in spark ocal directory
###                                                  , if the parquet files are created in HDFS location this step can be skipped.
### 7. Refer 07_customer_demograhics_creation.hql.txt , Creating demographic parquet tables and loading data for performing HIVE analytics
### 8. Refer 08_Hive_analytic_queries.hql , contains advanced analytic queries used on demographics tables. 

			

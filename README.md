
# Hadoop Project for Beginners-SQL Analytics with Hive

## Agenda

We will dig deeper into some of Hive's analytical features for this hive project. 
This big data project will look at the Hive capabilities that let us run analytical queries on
massive datasets. We will be using the adventure works dataset in a MySQL dataset for
this project. As a result, before we can go on to analytics, we'll need to ingest and
modify the data.

## Aim
To perform Hive analytics on Customer Demographics data using big data tools such as
Sqoop, Spark, and HDFS.

## Data Description
Adventure Works is a free sample database of retail sales data. In this project, we will
be only using Customer test, Individual test, and Credit card tables from this database.
Customer test table contains data like Customer ID, Territory ID, Account number,
Customer Type etc. Individual test table contains data like Customer ID, Contact ID and
Demographics. Credit card table contains data like Credit card ID, Card type, Card
number, Expiry month, Expiry year.

## Tech Stack
➔ Language: SQL, Scala
➔ Services: AWS EC2, Docker, MySQL, Sqoop, Hive, HDFS, Spar

## Approach
● Create an AWS EC2 instance and launch it.

● Create docker images using docker-compose file on EC2 machine via ssh.

● Create tables in MySQL.

● Load data from MySQL into HDFS storage using Sqoop commands.

● Move data from HDFS to Hive.

● Integrate Hive into Spark.

● Using scala programming language, extract Customer demographics information
from data and store it as parquet files.

● Move parquet files from Spark to Hive.

● Create tables in Hive and load data from Parquet files into tables.

● Perform Hive analytics on Customer demographics data.

## Project Takeaways

● Creating an AWS EC2 instance and launching it

● Connecting to an AWS EC2 instance via SSH

● Copying a file from a local machine to an EC2 machine

● Dockerization

● Understanding the schema of the dataset

● Data ingestion/transformation using Sqoop, Spark, and Hive

● Moving the data from MySQL to HDFS

● Creating Hive table and troubleshooting it

● Using Parquet and Xpath to access schema

● Understanding the use of GROUP BY, GROUPING SETS, ROLL-UP, CUBE
clauses in Hive analytics.

● Understanding different analytic functions in Hive.





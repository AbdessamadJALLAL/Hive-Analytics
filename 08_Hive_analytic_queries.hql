-- HIVE ANALYTICS

Analytics :
-- AGGREGATE FUNCTIONS
--------
GROUP BY
--------
-- group by rule all the groupby column should be in query

-- Problem Statement : To Find total number of customers.
 
select count(*) num_of_occurence from customer_demo

-- To Find total number of male and female customers.

select gender, count(1) num_of_occurence from customer_demo
group by gender

-- To Find total number of male and female customers based on maritalstatus

select maritalstatus, gender, count(1) num_of_occurence from customer_demo
group by maritalstatus, gender

-- To Find total number of male and female customers based on yearly income

select gender, yearlyincome, count(1) num_of_occurence from customer_demo
group by gender, yearlyincome

-- To Find total number of male and female customers based on maritalstatus , yearly income

select maritalstatus, gender, yearlyincome, count(1) num_of_occurence from customer_demo
group by maritalstatus,  gender, yearlyincome

-- GROUPING SETS
-- Helps to understand and evolving data in different angles
-- Answering Two different questions using one query
-- We can see the same data in two different dimensions
-- () - means everything

-- In th eblow query grouping is done into result sets respectively.
-- 1. global dimensions
-- 2. column level grouping based on yearly income
-- 3. column level grouping based on status and gender

select maritalstatus, gender, yearlyincome,count(1) num_of_occurence from customer_demo
group by maritalstatus, gender, yearlyincome
grouping sets ((maritalstatus, gender), yearlyincome,())

-- addding education to the above query

select maritalstatus, gender, yearlyincome, education, count(1) num_of_occurence from customer_demo
group by maritalstatus, gender, yearlyincome, education
grouping sets ((maritalstatus, gender), (yearlyincome, education),())

-- Using 'groupID' keyword

select grouping__id,maritalstatus, gender, yearlyincome, education, count(1) num_of_occurence from customer_demo
group by maritalstatus, gender, yearlyincome, education
grouping sets ((maritalstatus, gender), (yearlyincome, education),())
order by grouping__id;

-- Finding 'total year to date sales' based on customer demographics

select grouping__id,maritalstatus, gender, yearlyincome, education,sum(totalpurchaseytd) total_purchase_ytd from customer_demo
group by maritalstatus, gender, yearlyincome, education
grouping sets ((maritalstatus, gender), (yearlyincome, education),())

-- creating all possible grouping sets manually
select grouping__id, maritalstatus, gender, yearlyincome, education, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by maritalstatus, gender, yearlyincome, education
grouping sets ((maritalstatus, gender, yearlyincome, education), (maritalstatus, gender, yearlyincome), (maritalstatus, gender), maritalstatus, ())

-----------
-- ROLL-UP - one step up and all probablities
-----------
-- ROLL-UP
select grouping__id, yearlyincome, education, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education
with rollup

-- the above rollup is equivalent to the below grouping set

select grouping__id, yearlyincome, education, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education
grouping sets ((yearlyincome, education), (yearlyincome), ())

-- Another example

select grouping__id, yearlyincome, education, gender, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education,gender
with rollup

select grouping__id, yearlyincome, education, gender,sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education,gender
grouping sets ((yearlyincome, education,gender), (yearlyincome, education), (yearlyincome), ())
order by grouping__id;

---------
-- CUBE
-- permutation and combination of all of them
-- we may miss out a combination in that cube comes in to picture
---------

select grouping__id, yearlyincome, education, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education
with cube

-- the above cube is equivalent to below grouping sets
select grouping__id, yearlyincome, education, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education
grouping sets ((yearlyincome, education), (yearlyincome), (education), ())
order by grouping__id;

-- Example : 02
select grouping__id, yearlyincome, education, maritalstatus, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education, maritalstatus
with cube

-- the above cube is equivalent to below grouping sets
select grouping__id, yearlyincome, education, maritalstatus, sum(totalpurchaseytd) num_of_occurence from customer_demo
group by yearlyincome, education, maritalstatus
grouping sets ((yearlyincome, education, maritalstatus), 
(yearlyincome, education), (yearlyincome, maritalstatus), (education, maritalstatus), 
(yearlyincome), (education), (maritalstatus), ())


-------------------------
HIVE - Analytic function
-------------------------

RANK
ROW_NUMBER
DENSE_RANK
CUME_DIST
PERCENT_RANK
NTILE

-- ROW_NUMBER
-- 'cte' stands for common table expression
-- get nine records from credit each card type
-- to display first 9 rows in each card type
-- even though its one query we considered as four dataset
-- we did this in one pass(1 MR job)

with cte as (select row_number() over (partition by cardtype) as serial_no, creditcardid, cardnumber,cardtype from creditcard)
select * from cte where serial_no < 10;

-- create a sample of the creditcard table that contains an equal amount of all cardtype(in this case 50 records for each card type)
create table cc_sample as 
select * from 
(select row_number() over (partition by cardtype) as serial_no, creditcardid, cardnumber, cardtype from creditcard) v where v.serial_no < 51

--------
-- NTILE
--------
-- NTILE is used to split data evenly, avoid biased data, in order to split partition by -- keyword is used.

select ntile(5) over (partition by cardtype) as groups, creditcardid, cardnumber, cardtype from cc_sample
order by groups;

-------------------
-- Windowing Analytics
-------------------
-- A window can have 
---- partition by
---- Order by
---- row between
---- range between

-- Problem Statement : 
-- To find the sales contribution by customers on the overall year to date sales 
-- belong to categorised by gender, maritial status, yearly income and education.

-- finding sale percentage contributed by each customer

select customerid, (sum(totalpurchaseytd)
over (partition by customerid) / sum(totalpurchaseytd) over ()) percentage from customer_demo cd 

-- Find the customerset based on percentage contribution on the total sales (YTD)

select  maritalstatus, yearlyincome, education, 
   sum(v.percentage) as percentage_of_purchase from customer_demo cd
   join 
   (select customerid, (sum(totalpurchaseytd) over (partition by customerid) / sum(totalpurchaseytd) over ()) percentage from customer_demo cd) as v
   on v.customerid = cd.customerid
group by maritalstatus, yearlyincome, education

-- To find the sales contribution by customers on the overall year to date sales 
-- belong to categorised by same maritial status, gender, yearly income

select  maritalstatus, gender, yearlyincome,
sum(v.percentage) as percentage_of_purchase from customer_demo cd
join 
(select customerid, (sum(totalpurchaseytd) over (partition by customerid) / sum(totalpurchaseytd) over ()) percentage from customer_demo cd) as v
on v.customerid = cd.customerid
group by maritalstatus, gender, yearlyincome

-- To find the sales contribution by customers on the overall year to date sales 
-- belong to categorised by same gender, yearly income.

select  gender, yearlyincome,
sum(v.percentage) as percentage_of_purchase from customer_demo cd
join 
(select customerid, (sum(totalpurchaseytd) over (partition by customerid) / sum(totalpurchaseytd) over ()) percentage from customer_demo cd) as v
on v.customerid = cd.customerid
group by gender, yearlyincome
order by gender


create external table customer_test (
`CustomerID` int,
`AccountNumber`  string,
`CustomerType` varchar(1),
`Demographics` string, 
`TerritoryID` int,
`ModifiedDate` timestamp
)
row format delimited fields terminated by ',';


create table creditcard (
`creditcardid` int,
`cardtype` string,
`cardnumber` string,
`expmonth` int,
`expyear` int,
`modifieddate` timestamp
)
row format delimited fields terminated by ',';


load data inpath '/input/customerdemo/part-m-00000' overwrite into table customer_test;
load data inpath '/input/customerdemo/part-m-00001' into table customer_test;
load data inpath '/input/customerdemo/part-m-00002' into table customer_test;
load data inpath '/input/customerdemo/part-m-00003' into table customer_test;


load data inpath '/input/creditcard/part-m-*' overwrite into table creditcard;

select * from customer_test;
select CustomerID,Demographics from customer_test;

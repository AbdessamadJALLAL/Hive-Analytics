USE testdb;


create view v_customer_demo as 
select cus.CustomerID,cus.AccountNumber, cus.CustomerType, ind.Demographics, cus.TerritoryID,cus.ModifiedDate 
from customer_test cus join individual_test ind on ind.CustomerID = cus.CustomerID ;

select * from v_customer_demo;

select Demographics from v_customer_demo

create database fun;
use fun;
create table sales(
saleid int,
saledate date,
customerid int,
productid int,
amount decimal(10,2));
insert into sales(saleid,saledate,customerid,productid,amount)values
(1,'2024-01-01',101,1001,150.00),
(2,'2024-01-02',102,1002,200.00),
(3,'2024-01-03',101,1001,100.00),
(4,'2024-01-04',103,1003,300.00),
(5,'2024-01-05',102,1002,250.00),
(6,'2024-01-06',101,1001,175.00),
(7,'2024-01-07',104,1004,400.00),
(8,'2024-01-08',105,1005,350.00),
(9,'2024-01-09',102,1002,225.00),
(10,'2024-01-10',101,1001,125.00);
#1 calculate the running total of sales amount.

select saleid,saledate,amount,sum(amount) over(order by saledate )as runningtotal from sales;

#2 calculate the average sales amount over the last 3sales

select saleid,saledate,amount,
avg(amount)over( order by saledate rows between 2 preceding and current row )as avergelst3 from sales ;

#3 rank the sales by amount for each customer.
select saleid,amount,
row_number()over(order by saleid asc)as"row_number",
rank()over( order by saleid  asc)as"rank"from sales;

#4 calculate the cumulative distribuution of sales amount
select saleid, amount,
       CUME_DIST() OVER (ORDER BY saleid) AS cumulative_distribution
FROM sales;
#5 CALCULATE THE DIFFERENCE IN SALES AMOUNT BETWEEN TH CURRENT SALE AND THE PREVIOUS SALE
SELECT 
    saleid,
    amount, 
    amount - LAG(Amount) OVER (ORDER BY saledate) AS Sales_Difference
FROM sales;

#6 calculate the lead sale amount for the next sale.

select
saleid,
amount,
lead(amount)over(order by saledate)as nextsale from sales;

#7 find the first sale amount for each customer

SELECT 
    saleid, 
    saledate, 
    customerid, 
    amount,
    FIRST_VALUE(amount) OVER (PARTITION BY customerid ORDER BY saledate) AS FirstSaleAmount from sales;






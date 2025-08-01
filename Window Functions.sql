CREATE DATABASE sales_db;

USE sales_db;

CREATE TABLE sales (
  id INT PRIMARY KEY,
  employee VARCHAR(50),
  department VARCHAR(50),
  sales_amount INT,
  sale_date DATE
);

INSERT INTO sales VALUES
(1, 'Alice', 'A', 1000, '2023-01-01'),
(2, 'Alice', 'A', 1200, '2023-01-05'),
(3, 'Bob', 'B', 1500, '2023-01-03'),
(4, 'Bob', 'B', 1600, '2023-01-06'),
(5, 'Alice', 'A', 1300, '2023-01-10'),
(6, 'Bob', 'B', 1700, '2023-01-12');

select * from sales;

# 1. Total sales per employee (Running Total)

SELECT employee, SUM(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS running_total FROM sales;

# 2. Row number per employee

SELECT employee, ROW_NUMBER() OVER (PARTITION BY employee ORDER BY sale_date) AS row_num FROM sales;

# 3. Rank of sales per department.

SELECT employee, ROW_NUMBER() OVER (PARTITION BY employee ORDER BY sale_date) AS row_num FROM sales;

# 4. Lead (next sale) per employee.

SELECT employee, LEAD(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS next_sale FROM sales;

# 5. Lag (previous sale) per employee.

SELECT employee, LAG(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS prev_sale FROM sales;

# 6. Average sales per employee.

SELECT employee, AVG(sales_amount) OVER (PARTITION BY employee) AS avg_sales FROM sales;

# 7. First and last sales per employee.

SELECT employee,
       FIRST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS first_sale,
       LAST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date 
                                      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale
FROM sales;

# 8. Dense rank (no gaps).

SELECT employee, DENSE_RANK() OVER (ORDER BY sales_amount DESC) AS dense_rank FROM sales;

# 9. Cumulative average per employee.

SELECT employee, AVG(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date 
                                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_avg FROM sales;

# 10. Find highest sale per employee..

SELECT employee, MAX(sales_amount) OVER (PARTITION BY employee) AS highest_sale FROM sales;

# 11. Sales difference from previous record.

SELECT employee, sales_amount - LAG(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date) AS sales_diff FROM sales;

# 12.	Cumulative count of sales per employee. 

SELECT employee, COUNT(*) OVER (PARTITION BY employee ORDER BY sale_date) AS cumulative_count FROM sales;

# 13.Show if sale is above average per employee.   

SELECT employee,
       CASE WHEN sales_amount > AVG(sales_amount) OVER (PARTITION BY employee)
            THEN 'Above Avg' ELSE 'Below Avg' END AS status FROM sales;

# 14.	Find second highest sale per employee.

  WITH r AS (
  SELECT employee, sales_amount,
         DENSE_RANK() OVER (PARTITION BY employee ORDER BY sales_amount DESC) AS rnk
  FROM sales
)
SELECT employee, sales_amount FROM r WHERE rnk = 2;
                       

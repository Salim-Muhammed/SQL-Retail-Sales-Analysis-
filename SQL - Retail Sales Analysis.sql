CREATE DATABASE sql_project;

CREATE TABLE sales_data(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(20),
		age INT,
		category VARCHAR(20),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
);

--Exploring the dataset
SELECT * FROM sales_data;

--Data manipulation
SELECT * FROM sales_data
WHERE transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;


DELETE FROM sales_data
WHERE transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

-- Data analysis

--1. write a sql query to retrieve all columns for sale made on 2022-11-05
SELECT *
FROM sales_data
WHERE sale_date = '2022-11-05';


--2. write a sql query to retieve all transactions where the category is clothing and the quantity sold is more than 4 in the month of nov 2022
SELECT 
    transactions_id
FROM sales_data
WHERE category = 'Clothing'
AND quantiy >= 4 
AND EXTRACT(month from sale_date) = 11
AND EXTRACT (year from sale_date) = 2022;


--3. write a sql query to calculate the total sales for each category
SELECT 
     category,
	 SUM(total_sale) as total_sales
FROM sales_data
GROUP BY 1;


--4. write a sql query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	ROUND(AVG(age)) as avg_age
FROM sales_data
WHERE category = 'Beauty';


--5. write a sql query to find the all transactions where the total sale is greater than 1000.
SELECT * FROM sales_data
WHERE total_sale > 1000;


--6. write a sql query to find the total number of transactions made by each gender in each category
SELECT 
     category,
	 gender,
	 COUNT(transactions_id) as total_transaction
FROM sales_data
GROUP BY 1,2
ORDER BY 1,2 DESC;


--7. write a sql query to calculate the average sale for each month. Find out best selling month in each year.
WITH cte1 AS(
SELECT 
     EXTRACT(YEAR FROM sale_date) as year,
     EXTRACT(MONTH FROM sale_date) as month,
	 ROUND(AVG(total_sale)::NUMERIC,2) AS avg_sale
FROM sales_data
GROUP BY 1,2
ORDER BY 1),

cte2 as(
SELECT *,
     DENSE_RANK() OVER(PARTITION BY year ORDER BY avg_sale desc) as drnk
FROM cte1)

SELECT
    year,
	month,
	avg_sale
FROM cte2 WHERE drnk = 1;


--8. write a sql query to find the top 5 customers based on the highest total sales.
SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--9. write a sql query to find the number of unique customers who purchased items from each category.
SELECT 
     category,
	 COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data
GROUP BY 1;


--10. write a sql query to create each shift and number of orders (Example Morning <= 12, Afternoon between 12 & 17, Evening > 17)
SELECT 
     CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
		  END as shift,
	COUNT(*) AS total_orders
FROM sales_data
GROUP BY 1;

     
                        ---------------------------------------END----------------------------------------






# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project`.
- **Table Creation**: A table named `sales_data` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * FROM sales_data;
SELECT COUNT(*) FROM sales_data;
SELECT COUNT(DISTINCT customer_id) FROM sales_data;
SELECT DISTINCT category FROM sales_data;

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

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM sales_data
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
    transactions_id
FROM sales_data
WHERE category = 'Clothing'
AND quantiy >= 4 
AND EXTRACT(month from sale_date) = 11
AND EXTRACT (year from sale_date) = 2022;
```

3. **Write a SQL query to calculate the total sales for each category.**:
```sql
SELECT 
     category,
	 SUM(total_sale) as total_sales
FROM sales_data
GROUP BY 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
	ROUND(AVG(age)) as avg_age
FROM sales_data
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM sales_data
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
     category,
	 gender,
	 COUNT(transactions_id) as total_transaction
FROM sales_data
GROUP BY 1,2
ORDER BY 1,2 DESC;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
     category,
	 COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data
GROUP BY 1;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
     CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
		  END as shift,
	COUNT(*) AS total_orders
FROM sales_data
GROUP BY 1;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

- **LinkedIn**: [Connect with me](https://www.linkedin.com/in/salim-muhammed-b349b925b)

Thank you 

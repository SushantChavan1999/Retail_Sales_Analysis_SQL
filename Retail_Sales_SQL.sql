-- SQL retail sales analysis 
CREATE DATABASE retail_sales_project;

-- Use database
USE retail_sales_project;

-- If table is already in databse
DROP TABLE IF EXISTS retail_sales;

-- Table creation
CREATE TABLE retail_sales 
			(
				transactions_id INT PRIMARY KEY,
                sale_date DATE,
                sale_time TIME,
                customer_id INT,
                gender VARCHAR(15),
                age INT,
                category VARCHAR(15),
                quantiy INT,
                price_per_unit FLOAT,
                cogs FLOAT,
                total_sale FLOAT
			);
            
-- Show table
SELECT * FROM retail_sales
LIMIT 10;

-- Count of records in table
SELECT
	COUNT(transactions_id)
FROM retail_sales;

--  Finding null values
SELECT * FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		sale_date IS NULL
		OR
		sale_time IS NULL
        OR 
        customer_id IS NULL
        OR
        gender IS NULL
        OR 
        age IS NULL
        OR 
        category IS NULL
        OR 
        quantiy IS NULL
        OR 
        price_per_unit IS NULL
        OR 
        cogs IS NULL
        OR 
        total_sale IS NULL;
        
--  Safe mode turn off
SET SQL_SAFE_UPDATES = 0;

-- Deleting null records from table

DELETE FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		sale_date IS NULL
		OR
		sale_time IS NULL
        OR 
        customer_id IS NULL
        OR
        gender IS NULL
        OR 
        age IS NULL
        OR 
        category IS NULL
        OR 
        quantiy IS NULL
        OR 
        price_per_unit IS NULL
        OR 
        cogs IS NULL
        OR 
        total_sale IS NULL;
        
-- Data exploration

-- How many sales
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many unique customer
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Which type of category 
SELECT DISTINCT category FROM retail_sales;

-- Data Analysis
-- Data Analysis & Findings

-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
	WHERE 
		category = 'clothing' 
        AND 
        quantiy >= 4
        AND
		DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
			
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category
SELECT 
	category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_order
FROM retail_sales
GROUP BY 1;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) AS avg_age
	FROM retail_sales
WHERE
	category = 'Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE 
	total_sale > 1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
	category,
	gender,
	COUNT(*) AS total_tran
FROM retail_sales
GROUP BY 
	category,
	gender
ORDER BY 1;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	YEAR(sale_date) AS year,
	MONTH(sale_date) AS  month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, avg_sale DESC;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT 
	customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
    category,
	COUNT(DISTINCT customer_id) AS customer
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift,
    COUNT(*) AS num_orders
    FROM retail_sales
GROUP BY 1;

-- End of project
CREATE DATABASE IF NOT EXISTS sql_project_1;
USE sql_project_1;

CREATE TABLE IF NOT EXISTS retail_analysis (
transactions_id	INT,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(20),
age	INT,
category VARCHAR(20),
quantiy	INT,
price_per_unit INT,	
cogs FLOAT,
total_sale INT
);

-- Number of rows
SELECT COUNT(*) FROM retail_analysis;

-- First 100 rows
SELECT * FROM retail_analysis
ORDER BY transactions_id
LIMIT 100;

-- Checking if rows with NULL values exists
SELECT * FROM retail_analysis
WHERE
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR 
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender	IS NULL
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
     total_sale	IS NULL;		

-- HOW many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_analysis;

-- Q1. Write a SQL query to retrieve all columns for sales made on 2022-11-05
SELECT * FROM retail_analysis
WHERE sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category sold is clothing and the quantity sold is more than 3 in the month of Nov-2022
SELECT * FROM retail_analysis
WHERE category = 'Clothing' 
AND quantiy>3
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q3. Write a SQL query to the total sales for each category
 SELECT DISTINCT category, SUM(total_sale) FROM retail_analysis
 GROUP BY category;
 
 -- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
 SELECT AVG(age) FROM retail_analysis
 WHERE category = 'Beauty';
 
 -- Q5. Write a SQL query to find all transactions where the total sale is greater than 1000
 SELECT * FROM retail_analysis
 WHERE total_sale>1000;
 
 -- Q6. Write a SQL query to find all the transcations (transaction_id) made by each gender in each category
 SELECT gender, category, COUNT(transactions_id) AS total_transactions FROM retail_analysis
 GROUP BY gender, category
 ORDER BY 1;
 
 -- Q7. Write a SQL query to calculate the average sale for each month in each year. Find out best selling month in each year.
 SELECT YEAR(sale_date) AS Year, MONTH(sale_date) AS Month, AVG(total_sale) FROM retail_analysis
 GROUP BY Year,Month
 ORDER BY Year ASC, Month ASC;
 
 -- Q8. Write a SQL query to find the top 5 customers based on the highest total sales
 SELECT customer_id,SUM(total_sale) AS total_sales FROM retail_analysis
 GROUP BY customer_id
 ORDER BY total_sales DESC
 LIMIT 5;
 
 -- Q9. Write a SQL query to find the number of unique customers who purchased items for each category
 SELECT category, COUNT(DISTINCT customer_id) FROM retail_analysis
 GROUP BY category;
 
 -- Q10. Write a SQL query to create each shift and number of orders
 SELECT * FROM retail_analysis
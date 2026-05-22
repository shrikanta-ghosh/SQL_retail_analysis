

---

```markdown
# Retail Sales Analysis using SQL

## Project Overview
This project focuses on analyzing retail sales data using SQL.  
The dataset contains transaction-level details such as customer demographics, product category, quantity sold, pricing, cost of goods sold, and total sale amount.

The goal of this project is to explore the dataset, clean it, and answer business questions through SQL queries.

---

## Database Setup

```sql
CREATE DATABASE IF NOT EXISTS sql_project_1;
USE sql_project_1;

CREATE TABLE IF NOT EXISTS retail_analysis (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale INT
);
```

---

## Dataset Description

The table `retail_analysis` contains the following columns:

| Column Name       | Data Type    | Description |
|------------------|-------------|-------------|
| transactions_id  | INT         | Unique transaction ID |
| sale_date        | DATE        | Date of transaction |
| sale_time        | TIME        | Time of transaction |
| customer_id      | INT         | Unique customer ID |
| gender           | VARCHAR(20) | Gender of customer |
| age              | INT         | Age of customer |
| category         | VARCHAR(20) | Product category |
| quantiy          | INT         | Quantity of items sold |
| price_per_unit   | INT         | Price per unit of product |
| cogs             | FLOAT       | Cost of goods sold |
| total_sale       | INT         | Total sale value |

> **Note:** The column name `quantiy` appears to be misspelled. It should ideally be `quantity`.

---

## Data Exploration

### 1. Count total number of rows
```sql
SELECT COUNT(*) FROM retail_analysis;
```

### 2. View first 100 rows
```sql
SELECT * FROM retail_analysis
ORDER BY transactions_id
LIMIT 100;
```

### 3. Check for NULL values
```sql
SELECT * FROM retail_analysis
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
```

### 4. Count unique customers
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_analysis;
```

---

## Business Questions and SQL Queries

### Q1. Retrieve all columns for sales made on `2022-11-05`
```sql
SELECT * FROM retail_analysis
WHERE sale_date = '2022-11-05';
```

### Q2. Retrieve all transactions where the category is Clothing and quantity sold is more than 3 in November 2022
```sql
SELECT * FROM retail_analysis
WHERE category = 'Clothing'
AND quantiy > 3
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

### Q3. Find total sales for each category
```sql
SELECT category, SUM(total_sale) AS total_sales
FROM retail_analysis
GROUP BY category;
```

### Q4. Find the average age of customers who purchased items from the Beauty category
```sql
SELECT AVG(age) AS avg_age
FROM retail_analysis
WHERE category = 'Beauty';
```

### Q5. Find all transactions where the total sale is greater than 1000
```sql
SELECT * FROM retail_analysis
WHERE total_sale > 1000;
```

### Q6. Find the total number of transactions made by each gender in each category
```sql
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM retail_analysis
GROUP BY gender, category
ORDER BY gender;
```

### Q7. Calculate the average sale for each month in each year
```sql
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM retail_analysis
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year ASC, month ASC;
```

#### Best selling month in each year
```sql
SELECT *
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY SUM(total_sale) DESC
        ) AS ranking
    FROM retail_analysis
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) ranked_sales
WHERE ranking = 1;
```

### Q8. Find the top 5 customers based on the highest total sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_analysis
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### Q9. Find the number of unique customers who purchased items in each category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_analysis
GROUP BY category;
```


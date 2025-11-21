-- ============================================================
-- SQL SALES ANALYTICS PROJECT: RETAIL SALES DATA
-- Table: RetailSales
-- Columns:
--   TransactionID, Date, CustomerID, Gender, Age,
--   ProductCategory, Quantity, PricePerUnit, TotalAmount
-- ============================================================

---------------------------------------------------------------
-- 1️⃣ BASIC KPIs
---------------------------------------------------------------

-- Total revenue
SELECT SUM(TotalAmount) AS total_revenue
FROM RetailSales;

-- Total quantity sold
SELECT SUM(Quantity) AS total_quantity_sold
FROM RetailSales;

-- Number of transactions
SELECT COUNT(*) AS total_transactions
FROM RetailSales;

-- Average order value (AOV)
SELECT SUM(TotalAmount) / COUNT(*) AS avg_order_value
FROM RetailSales;


---------------------------------------------------------------
-- 2️⃣ SALES BY PRODUCT CATEGORY
---------------------------------------------------------------

SELECT 
    ProductCategory,
    SUM(TotalAmount) AS total_revenue,
    SUM(Quantity) AS total_quantity
FROM RetailSales
GROUP BY ProductCategory
ORDER BY total_revenue DESC;


---------------------------------------------------------------
-- 3️⃣ REVENUE BY GENDER
---------------------------------------------------------------

SELECT 
    Gender,
    SUM(TotalAmount) AS total_revenue,
    COUNT(*) AS total_transactions,
    AVG(TotalAmount) AS avg_order_value
FROM RetailSales
GROUP BY Gender
ORDER BY total_revenue DESC;


---------------------------------------------------------------
-- 4️⃣ AGE GROUP ANALYSIS
---------------------------------------------------------------

-- Example: bucket ages into groups
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    SUM(TotalAmount) AS total_revenue,
    COUNT(*) AS transactions,
    AVG(TotalAmount) AS avg_order_value
FROM RetailSales
GROUP BY
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END
ORDER BY total_revenue DESC;


---------------------------------------------------------------
-- 5️⃣ MONTHLY REVENUE TREND (CTE + DATE_TRUNC)
---------------------------------------------------------------

WITH MonthlyRevenue AS (
    SELECT 
        DATE_TRUNC('month', Date) AS month,
        SUM(TotalAmount) AS total_revenue,
        SUM(Quantity) AS total_quantity
    FROM RetailSales
    GROUP BY DATE_TRUNC('month', Date)
)
SELECT *
FROM MonthlyRevenue
ORDER BY month;


---------------------------------------------------------------
-- 6️⃣ TOP 10 CUSTOMERS BY REVENUE (WINDOW FUNCTION)
---------------------------------------------------------------

SELECT
    CustomerID,
    SUM(TotalAmount) AS total_revenue,
    SUM(Quantity) AS total_quantity,
    RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS revenue_rank
FROM RetailSales
GROUP BY CustomerID
ORDER BY revenue_rank
LIMIT 10;


---------------------------------------------------------------
-- 7️⃣ PRODUCT CATEGORY RANKING (WINDOW FUNCTION)
---------------------------------------------------------------

SELECT
    ProductCategory,
    SUM(TotalAmount) AS total_revenue,
    SUM(Quantity) AS total_quantity,
    RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS category_rank
FROM RetailSales
GROUP BY ProductCategory
ORDER BY category_rank;


---------------------------------------------------------------
-- 8️⃣ WEEKDAY VS WEEKEND PERFORMANCE (OPTIONAL)
---------------------------------------------------------------

-- This assumes your SQL dialect has EXTRACT(DOW FROM Date)
-- 0 = Sunday, 6 = Saturday (PostgreSQL)
SELECT
    CASE 
        WHEN EXTRACT(DOW FROM Date) IN (0,6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(TotalAmount) AS total_revenue,
    COUNT(*) AS transactions,
    AVG(TotalAmount) AS avg_order_value
FROM RetailSales
GROUP BY
    CASE 
        WHEN EXTRACT(DOW FROM Date) IN (0,6) THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY total_revenue DESC;

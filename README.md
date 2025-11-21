-- ============================================================
-- SQL SALES ANALYTICS PROJECT: CORE QUERIES
-- Demonstrates Joins, Aggregations, CTEs, Window Functions
-- ============================================================

---------------------------------------------------------------
-- 1️⃣ BASIC KPIs
---------------------------------------------------------------

-- Total sales
SELECT SUM(Sales) AS total_sales
FROM SalesData;

-- Total profit
SELECT SUM(Profit) AS total_profit
FROM SalesData;

-- Average order value (AOV)
SELECT SUM(Sales) / COUNT(DISTINCT OrderID) AS avg_order_value
FROM SalesData;


---------------------------------------------------------------
-- 2️⃣ SALES BY CATEGORY
---------------------------------------------------------------

SELECT 
    Category, 
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM SalesData
GROUP BY Category
ORDER BY total_sales DESC;


---------------------------------------------------------------
-- 3️⃣ REGION-WISE PERFORMANCE
---------------------------------------------------------------

SELECT 
    Region,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    AVG(Profit/Sales) AS profit_margin
FROM SalesData
GROUP BY Region
ORDER BY total_sales DESC;


---------------------------------------------------------------
-- 4️⃣ BEST-SELLING PRODUCTS
---------------------------------------------------------------

SELECT 
    ProductName,
    SUM(Sales) AS total_sales,
    SUM(Quantity) AS total_qty
FROM SalesData
GROUP BY ProductName
ORDER BY total_sales DESC
LIMIT 10;


---------------------------------------------------------------
-- 5️⃣ CTE: MONTHLY TREND ANALYSIS
---------------------------------------------------------------

WITH MonthlySales AS (
    SELECT 
        DATE_TRUNC('month', OrderDate) AS Month,
        SUM(Sales) AS total_sales,
        SUM(Profit) AS total_profit
    FROM SalesData
    GROUP BY DATE_TRUNC('month', OrderDate)
)
SELECT *
FROM MonthlySales
ORDER BY Month;


---------------------------------------------------------------
-- 6️⃣ WINDOW FUNCTION: RANK TOP PRODUCTS
---------------------------------------------------------------

SELECT
    ProductName,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM SalesData
GROUP BY ProductName
ORDER BY sales_rank;


---------------------------------------------------------------
-- 7️⃣ CUSTOMER SEGMENT ANALYSIS
---------------------------------------------------------------

SELECT 
    Segment,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    COUNT(DISTINCT CustomerID) AS total_customers
FROM SalesData
GROUP BY Segment
ORDER BY total_sales DESC;

-- ============================================================
-- TABLE SCHEMA: RetailSales
-- Based on data/retail_sales_dataset.csv
-- ============================================================

CREATE TABLE RetailSales (
    TransactionID      INT,
    Date               DATE,
    CustomerID         VARCHAR(50),
    Gender             VARCHAR(10),
    Age                INT,
    ProductCategory    VARCHAR(100),
    Quantity           INT,
    PricePerUnit       DECIMAL(10, 2),
    TotalAmount        DECIMAL(10, 2)
);

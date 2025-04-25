
# 📊 Sales Data EDA Query Pack (SQL-Only)

This README outlines a comprehensive set of SQL queries used for performing exploratory data analysis (EDA) on the `sales_data` table from the `sales_RFM_analytics` database.

---

## ⚙️ Setup & Initial Checks

```sql
USE sales_RFM_analytics;

SELECT * FROM sales_data;
```

---

## 📊 Complete SQL EDA Query Pack

---

### 1. 📉 Dataset Overview & Basic Stats
**a. Total number of records**
```sql
-- Total number of records
SELECT COUNT(*) AS TotalRows FROM sales_data;
```

**Result:** TotalRows: 397880

**b. Preview first 10 rows**
```sql
-- Preview first 10 rows
SELECT * FROM sales_data LIMIT 10;
```
**Result:** 

![Preview first 10 rows](Result%20Output/2.png)

**c. Check for NULLs per column**

```sql
-- Check for NULLs per column
SELECT
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS NullInvoice,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS NullStockCode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS NullDescription,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS NullQuantity,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS NullInvoiceDate,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS NullUnitPrice,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS NullCountry
FROM sales_data;
```

**Result:**

![Check for NULLs per columns](Result%20Output/3.png)


---

###2. 💰 Sales Trends & Volume

**a. Total revenue**

```sql
-- Total revenue
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue FROM sales_data;
```

**Result:** TotalRevenue: 8911407.90

**b. Monthly revenue trend**
```sql
-- Monthly revenue trend
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY Month
ORDER BY Month
```
**Result:**

![Monthly revenue trend](Result%20Output/5.png)

**c. Daily sales trend**

```sql
-- Monthly revenue trend
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY Month
ORDER BY Month;

-- Daily sales trend
SELECT
    DATE(InvoiceDate) AS SalesDate,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY SalesDate
ORDER BY SalesDate;
```

**Result:**

![Monthly revenue trend](Result%20Output/6.png)

---

### 3. 🥇 Top & Bottom Performers

**a. Top 10 selling products (by quantity)**

```sql
-- Top 10 selling products (by quantity)
SELECT
    Description,
    SUM(Quantity) AS TotalUnitsSold
FROM sales_data
GROUP BY Description
ORDER BY TotalUnitsSold DESC
LIMIT 10;
```

**Result:**

![Top 10 selling products](Result%20Output/7.png)

**b. Top 10 products by revenue**

```sql
-- Top 10 products by revenue
SELECT
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM sales_data
GROUP BY Description
ORDER BY TotalRevenue DESC
LIMIT 10;
```

**Result:**

![Top 10 products by revenue](Result%20Output/8.png)

**c. Bottom 10 products by revenue**

```sql
-- Bottom 10 products by revenue
SELECT
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM sales_data
GROUP BY Description
HAVING TotalRevenue > 0
ORDER BY TotalRevenue ASC
LIMIT 10;
```

**Result:**

![Bottom 10 products by revenue](Result%20Output/9.png)

---

## 👥 Customer Analysis

```sql
-- Total number of unique customers
SELECT COUNT(DISTINCT CustomerID) AS UniqueCustomers FROM sales_data;

-- Top 10 customers by spend
SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalSpent
FROM sales_data
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;

-- Number of orders per customer
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM sales_data
GROUP BY CustomerID
ORDER BY TotalOrders DESC
LIMIT 10;
```

---

## 🌍 Country-wise Sales Distribution

```sql
-- Revenue by country
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY Country
ORDER BY Revenue DESC;

-- Customer count per country
SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM sales_data
GROUP BY Country
ORDER BY TotalCustomers DESC;
```

---

## 🧾 Invoice Analysis

```sql
-- Number of invoices
SELECT COUNT(DISTINCT InvoiceNo) AS TotalInvoices FROM sales_data;

-- Avg revenue per invoice
SELECT
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS AvgInvoiceRevenue
FROM sales_data;

-- Cancelled invoices count
SELECT COUNT(DISTINCT InvoiceNo) AS CancelledInvoices
FROM sales_data
WHERE InvoiceNo LIKE 'C%';
```

---

## ⏱️ Time-Based Insights

```sql
-- Sales by hour of day
SELECT
    HOUR(InvoiceDate) AS Hour,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY Hour
ORDER BY Hour;

-- Sales by weekday
SELECT
    DAYNAME(InvoiceDate) AS DayOfWeek,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM sales_data
GROUP BY DayOfWeek;
```

---

## 📦 Price & Quantity Analysis

```sql
-- Most expensive products (per unit)
SELECT
    Description,
    MAX(UnitPrice) AS MaxPrice
FROM sales_data
GROUP BY Description
ORDER BY MaxPrice DESC
LIMIT 10;

-- Products with highest quantity per order
SELECT
    Description,
    MAX(Quantity) AS MaxQtyInSingleOrder
FROM sales_data
GROUP BY Description
ORDER BY MaxQtyInSingleOrder DESC
LIMIT 10;
```

---

## ⚠️ Revenue Leakage (Returns & Zero Price)

```sql
-- Products with negative quantities (returns)
SELECT
    Description,
    COUNT(*) AS ReturnCount,
    SUM(Quantity * UnitPrice) AS ReturnValue
FROM sales_data
WHERE Quantity < 0
GROUP BY Description
ORDER BY ReturnValue ASC
LIMIT 10;

-- Zero or negative priced products
SELECT *
FROM sales_data
WHERE UnitPrice <= 0;
```

---

## 📈 Inventory Movement

```sql
-- Most stocked (fast-moving) products
SELECT
    Description,
    SUM(Quantity) AS TotalSold
FROM sales_data
GROUP BY Description
ORDER BY TotalSold DESC
LIMIT 10;

-- Least sold (slow-moving) products
SELECT
    Description,
    SUM(Quantity) AS TotalSold
FROM sales_data
GROUP BY Description
HAVING TotalSold > 0
ORDER BY TotalSold ASC
LIMIT 10;
```

---

> All queries are designed to provide insights purely using SQL and can be executed in any MySQL environment.

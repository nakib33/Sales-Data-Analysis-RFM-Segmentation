USE sales_RFM_analytics;

SELECT * FROM sales_data;

-- Top spending customers (high LTV)
SELECT
    CustomerID,
    ROUND(SUM(TotalPrice), 2) AS LifetimeValue
FROM sales_data
GROUP BY CustomerID
ORDER BY LifetimeValue DESC
LIMIT 10;

-- Products with declining monthly sales trend

WITH monthly_sales AS (
    SELECT
        Description,
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
        SUM(Quantity) AS MonthlyQty
    FROM sales_data
    GROUP BY Description, Month
)
SELECT Description
FROM monthly_sales
GROUP BY Description
HAVING COUNT(*) > 3
   AND SUM(MonthlyQty) < (SELECT AVG(MonthlyQty) * 0.5 FROM monthly_sales WHERE monthly_sales.Description = Description);

-- Customer purchase frequency by weekday
SELECT
    DAYNAME(InvoiceDate) AS Weekday,
    COUNT(DISTINCT InvoiceNo) AS TotalInvoices
FROM sales_data
GROUP BY Weekday
ORDER BY FIELD(Weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Best performing countries by average order value
SELECT
    Country,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) AS AvgOrderValue
FROM sales_data
GROUP BY Country
ORDER BY AvgOrderValue DESC;

-- Average time between purchases 
WITH purchase_dates AS (
    SELECT
        CustomerID,
        InvoiceDate,
        LAG(InvoiceDate) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate) AS PrevPurchase
    FROM sales_data
),
time_diff AS (
    SELECT
        CustomerID,
        DATEDIFF(InvoiceDate, PrevPurchase) AS DaysBetween
    FROM purchase_dates
    WHERE PrevPurchase IS NOT NULL
)
SELECT
    CustomerID,
    ROUND(AVG(DaysBetween), 2) AS AvgDaysBetweenPurchases
FROM time_diff
GROUP BY CustomerID
ORDER BY AvgDaysBetweenPurchases;

-- Customer acquisition by month
SELECT
    DATE_FORMAT(FirstPurchase, '%Y-%m') AS AcquisitionMonth,
    COUNT(*) AS NewCustomers
FROM (
    SELECT CustomerID, MIN(InvoiceDate) AS FirstPurchase
    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS FirstPurchases
GROUP BY DATE_FORMAT(FirstPurchase, '%Y-%m')
ORDER BY AcquisitionMonth;

-- Top 10 products by sales:
SELECT
    Description,
    SUM(Quantity) AS TotalQuantity
FROM sales_data
GROUP BY Description
ORDER BY TotalQuantity DESC
LIMIT 10;

-- Monthly revenue trend:

SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    SUM(TotalPrice) AS MonthlyRevenue
FROM sales_data
GROUP BY Month
ORDER BY Month;

-- Country-wise sales distribution:
SELECT
    Country,
    SUM(TotalPrice) AS TotalSales
FROM sales_data
GROUP BY Country
ORDER BY TotalSales DESC;

-- Identify products with consistent low sales
SELECT
    Description,
    COUNT(DISTINCT InvoiceNo) AS OrderCount,
    SUM(Quantity) AS TotalQty,
    ROUND(SUM(TotalPrice), 2) AS Revenue
FROM sales_data
GROUP BY Description
HAVING TotalQty < 20
ORDER BY Revenue ASC
LIMIT 20;

-- Top 5% Customers by Total Spend (Revenue Concentration)
WITH customer_spend AS (
    SELECT CustomerID, SUM(TotalPrice) AS TotalSpent
    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
),
ranked_customers AS (
    SELECT *,
           NTILE(100) OVER (ORDER BY TotalSpent DESC) AS percentile_rank
    FROM customer_spend
)
SELECT *
FROM ranked_customers
WHERE percentile_rank <= 5
ORDER BY TotalSpent DESC;

-- Products frequently discounted (potential margin killers)
SELECT
    Description,
    AVG(UnitPrice) AS AvgPrice,
    MIN(UnitPrice) AS LowestPrice,
    COUNT(DISTINCT InvoiceNo) AS SaleFrequency
FROM sales_data
GROUP BY Description
HAVING MIN(UnitPrice) < AVG(UnitPrice) * 0.8
ORDER BY (AvgPrice - LowestPrice) DESC
LIMIT 20;

-- Peak shopping time (hourly granularity)
SELECT
    HOUR(InvoiceDate) AS HourOfDay,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(TotalPrice), 2) AS Revenue
FROM sales_data
GROUP BY HourOfDay
ORDER BY HourOfDay;

-- Year-over-Year growth in revenue
SELECT
    YEAR(InvoiceDate) AS SalesYear,
    ROUND(SUM(TotalPrice), 2) AS TotalRevenue,
    LAG(ROUND(SUM(TotalPrice), 2)) OVER (ORDER BY YEAR(InvoiceDate)) AS PreviousYearRevenue,
    ROUND((SUM(TotalPrice) - LAG(SUM(TotalPrice)) OVER (ORDER BY YEAR(InvoiceDate))) * 100.0 / LAG(SUM(TotalPrice)) OVER (ORDER BY YEAR(InvoiceDate)), 2) AS YoY_Growth_Percent
FROM sales_data
GROUP BY SalesYear;

-- Avg basket size (items per transaction)
SELECT
    ROUND(SUM(Quantity) * 1.0 / COUNT(DISTINCT InvoiceNo), 2) AS AvgBasketSize
FROM sales_data;

-- Top Product Categories by Repeat Purchase Rate
SELECT
    CASE
        WHEN Description LIKE '%MUG%' THEN 'Mugs'
        WHEN Description LIKE '%CANDLE%' THEN 'Candles'
        WHEN Description LIKE '%BAG%' THEN 'Bags'
        WHEN Description LIKE '%CUSHION%' THEN 'Cushions'
        WHEN Description LIKE '%LIGHT%' THEN 'Lights'
        ELSE 'Other'
    END AS CategoryName,
    COUNT(DISTINCT CustomerID) AS UniqueBuyers,
    COUNT(CustomerID) AS TotalPurchases,
    ROUND(COUNT(CustomerID) * 1.0 / COUNT(DISTINCT CustomerID), 2) AS RepeatRate
FROM sales_data
WHERE CustomerID IS NOT NULL AND InvoiceNo NOT LIKE 'C%'
GROUP BY CategoryName
ORDER BY RepeatRate DESC;

-- Identify effective upselling opportunities
SELECT
    a.Description AS MainProduct,
    b.Description AS AddOnProduct,
    COUNT(*) AS TimesBoughtTogether,
    ROUND(AVG(a.UnitPrice), 2) AS MainPrice,
    ROUND(AVG(b.UnitPrice), 2) AS AddOnPrice
FROM sales_data a
JOIN sales_data b
    ON a.InvoiceNo = b.InvoiceNo
WHERE a.UnitPrice > 20 AND b.UnitPrice < 5 AND a.StockCode != b.StockCode
GROUP BY MainProduct, AddOnProduct
ORDER BY TimesBoughtTogether DESC
LIMIT 10;

-- Country-wise customer count vs revenue ratio
SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS Customers,
    ROUND(SUM(TotalPrice), 2) AS Revenue,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT CustomerID), 2) AS RevenuePerCustomer
FROM sales_data
GROUP BY Country
ORDER BY RevenuePerCustomer DESC;






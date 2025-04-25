# Sales Data Analysis & RFM Segmentation - SQL Project

This document explains each SQL query used in the **Sales Data Analysis & RFM Segmentation** project using the `sales_data` table from the `sales_RFM_analytics` database.

---

## 1. Top Spending Customers (High LTV)
```sql
SELECT CustomerID, ROUND(SUM(TotalPrice), 2) AS LifetimeValue
FROM sales_data
GROUP BY CustomerID
ORDER BY LifetimeValue DESC
LIMIT 10;
```
**Explanation**: Calculates total spending per customer (LTV) and lists the top 10 high-value customers.

---

## 2. Products with Declining Monthly Sales Trend
```sql
WITH monthly_sales AS (
    SELECT Description, DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(Quantity) AS MonthlyQty
    FROM sales_data
    GROUP BY Description, Month
)
SELECT Description
FROM monthly_sales
GROUP BY Description
HAVING COUNT(*) > 3 AND SUM(MonthlyQty) < (SELECT AVG(MonthlyQty) * 0.5 FROM monthly_sales WHERE monthly_sales.Description = Description);
```
**Explanation**: Identifies products with over 3 months of data and recent sales less than half the average, indicating decline.

---

## 3. Customer Purchase Frequency by Weekday
```sql
SELECT DAYNAME(InvoiceDate) AS Weekday, COUNT(DISTINCT InvoiceNo) AS TotalInvoices
FROM sales_data
GROUP BY Weekday
ORDER BY FIELD(Weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
```
**Explanation**: Displays how many invoices were generated each weekday, showing peak shopping days.

---

## 4. Best Performing Countries by Average Order Value
```sql
SELECT Country, ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) AS AvgOrderValue
FROM sales_data
GROUP BY Country
ORDER BY AvgOrderValue DESC;
```
**Explanation**: Calculates the average order value per country.

---

## 5. Average Time Between Purchases
```sql
WITH purchase_dates AS (
    SELECT CustomerID, InvoiceDate, LAG(InvoiceDate) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate) AS PrevPurchase
    FROM sales_data
),
time_diff AS (
    SELECT CustomerID, DATEDIFF(InvoiceDate, PrevPurchase) AS DaysBetween
    FROM purchase_dates
    WHERE PrevPurchase IS NOT NULL
)
SELECT CustomerID, ROUND(AVG(DaysBetween), 2) AS AvgDaysBetweenPurchases
FROM time_diff
GROUP BY CustomerID
ORDER BY AvgDaysBetweenPurchases;
```
**Explanation**: Calculates average number of days between purchases for each customer.

---

## 6. Customer Acquisition by Month
```sql
SELECT DATE_FORMAT(FirstPurchase, '%Y-%m') AS AcquisitionMonth, COUNT(*) AS NewCustomers
FROM (
    SELECT CustomerID, MIN(InvoiceDate) AS FirstPurchase
    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS FirstPurchases
GROUP BY AcquisitionMonth
ORDER BY AcquisitionMonth;
```
**Explanation**: Shows number of new customers acquired each month.

---

## 7. Top 10 Products by Sales
```sql
SELECT Description, SUM(Quantity) AS TotalQuantity
FROM sales_data
GROUP BY Description
ORDER BY TotalQuantity DESC
LIMIT 10;
```
**Explanation**: Lists the top 10 best-selling products by quantity.

---

## 8. Monthly Revenue Trend
```sql
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(TotalPrice) AS MonthlyRevenue
FROM sales_data
GROUP BY Month
ORDER BY Month;
```
**Explanation**: Tracks revenue trends month-by-month.

---

## 9. Country-wise Sales Distribution
```sql
SELECT Country, SUM(TotalPrice) AS TotalSales
FROM sales_data
GROUP BY Country
ORDER BY TotalSales DESC;
```
**Explanation**: Shows total sales per country.

---

## 10. Products with Consistently Low Sales
```sql
SELECT Description, COUNT(DISTINCT InvoiceNo) AS OrderCount, SUM(Quantity) AS TotalQty, ROUND(SUM(TotalPrice), 2) AS Revenue
FROM sales_data
GROUP BY Description
HAVING TotalQty < 20
ORDER BY Revenue ASC
LIMIT 20;
```
**Explanation**: Identifies underperforming products.

---

## 11. Top 5% Customers by Total Spend
```sql
WITH customer_spend AS (
    SELECT CustomerID, SUM(TotalPrice) AS TotalSpent
    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
),
ranked_customers AS (
    SELECT *, NTILE(100) OVER (ORDER BY TotalSpent DESC) AS percentile_rank
    FROM customer_spend
)
SELECT *
FROM ranked_customers
WHERE percentile_rank <= 5
ORDER BY TotalSpent DESC;
```
**Explanation**: Segments the top 5% of high-spending customers.

---

## 12. Products Frequently Discounted
```sql
SELECT Description, AVG(UnitPrice) AS AvgPrice, MIN(UnitPrice) AS LowestPrice, COUNT(DISTINCT InvoiceNo) AS SaleFrequency
FROM sales_data
GROUP BY Description
HAVING MIN(UnitPrice) < AVG(UnitPrice) * 0.8
ORDER BY (AvgPrice - LowestPrice) DESC
LIMIT 20;
```
**Explanation**: Highlights items that are heavily discounted.

---

## 13. Peak Shopping Times (Hourly)
```sql
SELECT HOUR(InvoiceDate) AS HourOfDay, COUNT(DISTINCT InvoiceNo) AS TotalOrders, ROUND(SUM(TotalPrice), 2) AS Revenue
FROM sales_data
GROUP BY HourOfDay
ORDER BY HourOfDay;
```
**Explanation**: Shows what hours of the day generate the most orders and revenue.

---

## 14. Year-over-Year Growth in Revenue
```sql
SELECT YEAR(InvoiceDate) AS SalesYear, ROUND(SUM(TotalPrice), 2) AS TotalRevenue,
    LAG(ROUND(SUM(TotalPrice), 2)) OVER (ORDER BY YEAR(InvoiceDate)) AS PreviousYearRevenue,
    ROUND((SUM(TotalPrice) - LAG(SUM(TotalPrice)) OVER (ORDER BY YEAR(InvoiceDate))) * 100.0 / LAG(SUM(TotalPrice)) OVER (ORDER BY YEAR(InvoiceDate)), 2) AS YoY_Growth_Percent
FROM sales_data
GROUP BY SalesYear;
```
**Explanation**: Compares revenue growth between years.

---

## 15. Average Basket Size
```sql
SELECT ROUND(SUM(Quantity) * 1.0 / COUNT(DISTINCT InvoiceNo), 2) AS AvgBasketSize
FROM sales_data;
```
**Explanation**: Calculates the average number of items per transaction.

---

## 16. Top Product Categories by Repeat Purchase Rate
```sql
SELECT CASE
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
```
**Explanation**: Segments product types and identifies those with high repeat purchase rates.

---

## 17. Effective Upselling Opportunities
```sql
SELECT a.Description AS MainProduct, b.Description AS AddOnProduct, COUNT(*) AS TimesBoughtTogether,
    ROUND(AVG(a.UnitPrice), 2) AS MainPrice, ROUND(AVG(b.UnitPrice), 2) AS AddOnPrice
FROM sales_data a
JOIN sales_data b ON a.InvoiceNo = b.InvoiceNo
WHERE a.UnitPrice > 20 AND b.UnitPrice < 5 AND a.StockCode != b.StockCode
GROUP BY MainProduct, AddOnProduct
ORDER BY TimesBoughtTogether DESC
LIMIT 10;
```
**Explanation**: Finds frequently paired purchases that show upsell potential.

---

## 18. Country-wise Customer Count vs Revenue Ratio
```sql
SELECT Country, COUNT(DISTINCT CustomerID) AS Customers, ROUND(SUM(TotalPrice), 2) AS Revenue,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT CustomerID), 2) AS RevenuePerCustomer
FROM sales_data
GROUP BY Country
ORDER BY RevenuePerCustomer DESC;
```
**Explanation**: Compares customer volume and revenue efficiency by country.

---

End of documentation.

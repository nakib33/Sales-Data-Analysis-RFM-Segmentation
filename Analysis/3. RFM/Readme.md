
# RFM Analysis & Customer Segmentation (SQL-Based)

This document provides a breakdown of SQL queries used for **Recency, Frequency, and Monetary (RFM) Analysis** and subsequent **Customer Segmentation** based on RFM scores using the `sales_data` table from the `sales_RFM_analytics` database.

---

## 1. Calculate RFM Metrics

```sql
SELECT
    CustomerID,
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    SUM(TotalPrice) AS Monetary
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;
```

📌 **Explanation**:
- **Recency**: Days since the last purchase (reference date: '2011-12-10').
- **Frequency**: Total number of unique invoices per customer.
- **Monetary**: Total spending by each customer.

---

## 2. Assign RFM Scores using NTILE (Quantile Method)

```sql
WITH rfm AS (
    SELECT
        CustomerID,
        DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(TotalPrice) AS Monetary
    FROM sales_data
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(5) OVER (ORDER BY Frequency) AS F_Score,
    NTILE(5) OVER (ORDER BY Monetary) AS M_Score
FROM rfm;
```

📌 **Explanation**:
- Assigns R, F, and M scores from 1 to 5 using SQL window functions.
- NTILE splits customers into quintiles.
- Recency sorted in descending order (lower days = higher rank).

---

## 3. Create RFM Segments using Business Rules

```sql
SELECT
    CustomerID,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Segment,
    (R_Score + F_Score + M_Score) AS RFM_Score
FROM (
    SELECT
        CustomerID,
        ...
        -- Recency scoring logic
        -- Frequency scoring logic
        -- Monetary scoring logic
    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS rfm_scores;
```

📌 **Explanation**:
- Uses conditional scoring instead of NTILE for control.
- Builds the full RFM segment (`e.g., 545`) and total RFM score (range: 3–15).

---

## 4. Customer Segmentation Based on RFM Score

```sql
SELECT
    CustomerID,
    RFM_Score,
    CASE
        WHEN RFM_Score >= 12 THEN 'Champions'
        WHEN RFM_Score BETWEEN 9 AND 11 THEN 'Loyal Customers'
        WHEN RFM_Score BETWEEN 6 AND 8 THEN 'Potential Loyalists'
        WHEN RFM_Score BETWEEN 3 AND 5 THEN 'At Risk'
        ELSE 'Lost'
    END AS Segment,
    ...
FROM (
    ...
) AS rfm_final;
```

📌 **Segments Explained**:
- `Champions`: RFM Score ≥ 12 (best customers).
- `Loyal Customers`: RFM Score 9–11.
- `Potential Loyalists`: Score 6–8.
- `At Risk`: Score 3–5.
- `Lost`: Score < 3.

This logic provides actionable customer segmentation for marketing and retention strategies.

---

## 📌 Notes:
- The reference date used: `'2011-12-10'` is assumed to be the analysis date.
- `sales_data` should include: `CustomerID`, `InvoiceNo`, `InvoiceDate`, `TotalPrice`.

---

**End of File**

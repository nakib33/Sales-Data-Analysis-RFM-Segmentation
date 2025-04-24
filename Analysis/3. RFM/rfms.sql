USE sales_RFM_analytics;

/*RFM Analysis*/


-- Calculate RFM metrics:
SELECT
    CustomerID,
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    SUM(TotalPrice) AS Monetary
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;


-- Assign RFM scores: Use NTILE to divide customers into quintiles (1 to 5).
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

-- Create RFM segments:
SELECT
    CustomerID,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Segment,
    (R_Score + F_Score + M_Score) AS RFM_Score
FROM (
    SELECT
        CustomerID,
        DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(TotalPrice) AS Monetary,
        
        -- R Score (1-5): Lower recency is better
        CASE
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 30 THEN 5
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 60 THEN 4
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 90 THEN 3
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 120 THEN 2
            ELSE 1
        END AS R_Score,

        -- F Score (1-5): Higher frequency is better
        CASE
            WHEN COUNT(DISTINCT InvoiceNo) >= 50 THEN 5
            WHEN COUNT(DISTINCT InvoiceNo) >= 40 THEN 4
            WHEN COUNT(DISTINCT InvoiceNo) >= 30 THEN 3
            WHEN COUNT(DISTINCT InvoiceNo) >= 20 THEN 2
            ELSE 1
        END AS F_Score,

        -- M Score (1-5): Higher monetary is better
        CASE
            WHEN SUM(TotalPrice) >= 20000 THEN 5
            WHEN SUM(TotalPrice) >= 10000 THEN 4
            WHEN SUM(TotalPrice) >= 5000 THEN 3
            WHEN SUM(TotalPrice) >= 1000 THEN 2
            ELSE 1
        END AS M_Score

    FROM sales_data
    WHERE CustomerID IS NOT NULL  
    GROUP BY CustomerID
) AS rfm_scores;

/*Customer Segmentation
Based on RFM scores, segment customers:
Champions: RFM_Score ≥ 12​
Loyal Customers: RFM_Score between 9 and 11​
Potential Loyalists: RFM_Score between 6 and 8​
At Risk: RFM_Score between 3 and 5​
Lost: RFM_Score ≤ 2​*/

SELECT
    CustomerID AS CustomerID,
    RFM_Score,
    CASE
        WHEN RFM_Score >= 12 THEN 'Champions'
        WHEN RFM_Score BETWEEN 9 AND 11 THEN 'Loyal Customers'
        WHEN RFM_Score BETWEEN 6 AND 8 THEN 'Potential Loyalists'
        WHEN RFM_Score BETWEEN 3 AND 5 THEN 'At Risk'
        ELSE 'Lost'
    END AS Segment,
    -- Optional: Repeat the same label in another column for clarity or display purposes
    CASE
        WHEN RFM_Score >= 12 THEN 'Champions: RFM_Score ≥ 12'
        WHEN RFM_Score BETWEEN 9 AND 11 THEN 'Loyal Customers: RFM_Score between 9 and 11'
        WHEN RFM_Score BETWEEN 6 AND 8 THEN 'Potential Loyalists: RFM_Score between 6 and 8'
        WHEN RFM_Score BETWEEN 3 AND 5 THEN 'At Risk: RFM_Score between 3 and 5'
        ELSE 'Lost: RFM_Score < 3'
    END AS Segment_Description
FROM (
    SELECT
        CustomerID,
        DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(TotalPrice) AS Monetary,

        -- R Score
        CASE
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 30 THEN 5
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 60 THEN 4
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 90 THEN 3
            WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 120 THEN 2
            ELSE 1
        END AS R_Score,

        -- F Score
        CASE
            WHEN COUNT(DISTINCT InvoiceNo) >= 50 THEN 5
            WHEN COUNT(DISTINCT InvoiceNo) >= 40 THEN 4
            WHEN COUNT(DISTINCT InvoiceNo) >= 30 THEN 3
            WHEN COUNT(DISTINCT InvoiceNo) >= 20 THEN 2
            ELSE 1
        END AS F_Score,

        -- M Score
        CASE
            WHEN SUM(TotalPrice) >= 20000 THEN 5
            WHEN SUM(TotalPrice) >= 10000 THEN 4
            WHEN SUM(TotalPrice) >= 5000 THEN 3
            WHEN SUM(TotalPrice) >= 1000 THEN 2
            ELSE 1
        END AS M_Score,

        -- Combined RFM Score
        (
            CASE
                WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 30 THEN 5
                WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 60 THEN 4
                WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 90 THEN 3
                WHEN DATEDIFF('2011-12-10', MAX(InvoiceDate)) <= 120 THEN 2
                ELSE 1
            END +
            CASE
                WHEN COUNT(DISTINCT InvoiceNo) >= 50 THEN 5
                WHEN COUNT(DISTINCT InvoiceNo) >= 40 THEN 4
                WHEN COUNT(DISTINCT InvoiceNo) >= 30 THEN 3
                WHEN COUNT(DISTINCT InvoiceNo) >= 20 THEN 2
                ELSE 1
            END +
            CASE
                WHEN SUM(TotalPrice) >= 20000 THEN 5
                WHEN SUM(TotalPrice) >= 10000 THEN 4
                WHEN SUM(TotalPrice) >= 5000 THEN 3
                WHEN SUM(TotalPrice) >= 1000 THEN 2
                ELSE 1
            END
        ) AS RFM_Score

    FROM sales_data
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS rfm_final;

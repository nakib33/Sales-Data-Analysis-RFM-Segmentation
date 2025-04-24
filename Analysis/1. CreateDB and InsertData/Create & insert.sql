CREATE DATABASE IF NOT EXISTS sales_RFM_analytics;
USE sales_RFM_analytics;

DROP TABLE IF EXISTS sales_data;

-- Step 1: Create the table
CREATE TABLE sales_data (
    InvoiceNo VARCHAR(20),
    StockCode INT,
    Description VARCHAR(255),
    Quantity INT,
    Timedate VARCHAR(50),
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(50),
    InvoiceDate DATE
);


-- Step 2: Insert data from CSV
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/EDA & RFM.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM sales_data;





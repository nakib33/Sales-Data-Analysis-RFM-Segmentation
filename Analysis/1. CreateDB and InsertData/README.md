# Create Database and Insert Data

This project performs sales data analysis and RFM (Recency, Frequency, Monetary) segmentation using SQL on e-commerce transactional data. The aim is to derive customer insights that can help increase sales, improve targeting, and optimize marketing strategies.

## 📁 Project Structure

- **Database:** `sales_RFM_analytics`
- **Main Table:** `sales_data`
- **Source File:** `EDA & RFM.csv` (must be placed in your MySQL `Uploads` directory)

## 🧱 Table Schema

```sql
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
```

## 🚀 Setup Instructions

1. **Create the Database and Table**
    ```sql
    CREATE DATABASE IF NOT EXISTS sales_RFM_analytics;
    USE sales_RFM_analytics;

    DROP TABLE IF EXISTS sales_data;

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
    ```

2. **Insert Data from CSV**

   Make sure the CSV file is saved in your MySQL `Uploads` directory (usually `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/`).

    ```sql
    LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/EDA & RFM.csv'
    INTO TABLE sales_data
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    ```

3. **Verify the Data**
    ```sql
    SELECT * FROM sales_data;
    ```

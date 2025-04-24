# Data Preprocessing

---

## Step 1:

---

## Data Cleaning and Preprocessing using python

---

### Overview
This project involves cleaning and preprocessing a sales dataset to prepare it for analysis. The dataset is loaded from a CSV file, and various cleaning operations are performed to ensure data integrity and usability.

### Requirements
- Python 3.x
- Pandas
- NumPy
- Google Colab (for file upload and download)

### Steps Taken

1. **Import Libraries**
   - Imported necessary libraries: `pandas` and `numpy`.

2. **Load Dataset**
   - Used Google Colab's file upload feature to load the dataset.
   - Attempted to read the CSV file with different encodings (`latin-1` and `ISO-8859-1`) to avoid Unicode errors.

3. **Initial Data Inspection**
   - Displayed the first 10 rows of the dataset using `df.head(10)`.
   - Checked the structure and data types of the DataFrame using `df.info()`.

4. **Data Type Conversion**
   - Converted the `CustomerID` column from float64 to integer, handling errors by coercing them to NaN.

5. **Remove Unnecessary Columns**
   - Dropped the `Unnamed: 7` column if it existed.

6. **Handle Missing Values**
   - Removed rows with null or empty values in the `InvoiceNo`, `Quantity`, `UnitPrice`, and `CustomerID` columns.
   - Ensured that `Quantity` and `UnitPrice` contained only numeric values and converted them to numeric types.

7. **Further Data Cleaning**
   - Iterated through all columns to replace empty/null values with the previous non-null value.
   - Renamed the `InvoiceDate` column to `Timedate`.

8. **Date Formatting**
   - Created a new `InvoiceDate` column with the date formatted as `%Y-%m-%d`.

9. **Stock Code Cleaning**
   - Cleaned the `StockCode` column to ensure it contains only 5 numeric characters, removing any extra characters.

10. **Export Cleaned Data**
    - Converted the cleaned DataFrame to a CSV file named `cleaned_sales_data.csv`.
    - Provided a download link for the cleaned CSV file using Google Colab's file download feature.

### Conclusion
The dataset has been successfully cleaned and is now ready for further analysis. The cleaned data can be downloaded for use in various data analysis tasks.

### Note
Make sure to replace `'data.csv'` with the actual path to your dataset when running the code.

---

Step 2:

---

## SQL Data Processing for Sales Data

---

### Overview
This project involves processing a sales dataset stored in a SQL database. The goal is to clean the data by removing unwanted records and adding a new calculated column for total sales price.

### Requirements
- SQL Database (e.g., MySQL, PostgreSQL)
- Access to the `sales_data` table

### Steps Taken

1. **Remove Null CustomerIDs**
   - Executed a DELETE statement to remove all records from the `sales_data` table where the `CustomerID` is NULL.
   ```sql
   DELETE FROM sales_data
   WHERE CustomerID IS NULL;
   ```

2. **Exclude Canceled Orders**
   - Executed a DELETE statement to remove all records where the `InvoiceNo` starts with 'C', indicating that the order was canceled.
     ```sql
     DELETE FROM sales_data
     WHERE InvoiceNo LIKE 'C%';
     ```

3. **Ensure Positive Quantities and Prices**
   - Executed a DELETE statement to remove all records where `Quantity` is less than or equal to 0 or where UnitPrice is less than or equal to 0.
     ```sql
     DELETE FROM sales_data
     WHERE Quantity <= 0 OR UnitPrice <= 0;
     ```

4. **Create a TotalPrice Column**
   -Altered the sales_data table to add a new column named `TotalPrice` with a DECIMAL data type.
   ```sql
      ALTER TABLE sales_data ADD COLUMN TotalPrice DECIMAL(10,2);
   ```
5. **Calculate Total Price**
   - Updated the TotalPrice column by multiplying `Quantity` and `UnitPrice` for all records where both values are not NULL.
     ```sql
      UPDATE sales_data
      SET TotalPrice = Quantity * UnitPrice
      WHERE Quantity IS NOT NULL AND UnitPrice IS NOT NULL;
     ```

### Conclusion
The sales dataset has been successfully processed to remove unwanted records and to include a new `TotalPrice` column, which provides a calculated value for each sale. This cleaned dataset is now ready for further analysis or reporting.

### Note
Ensure that you have the necessary permissions to execute DELETE and ALTER statements on the sales_data table

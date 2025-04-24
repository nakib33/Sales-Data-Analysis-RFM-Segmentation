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


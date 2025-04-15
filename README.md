# 🛒 Sales Data Analysis & RFM Segmentation (SQL-Only Project)

## 📌 Introduction

This project is a comprehensive **SQL-only Data Analytics & Customer Segmentation** project that focuses on uncovering insights from real-world e-commerce sales data. It uses **Exploratory Data Analysis (EDA)** and **RFM (Recency, Frequency, Monetary) segmentation** to identify key customer behaviors, optimize sales strategies, and help businesses make data-driven decisions to boost revenue.

---

## 🧾 Summary

Businesses today collect massive amounts of transactional data, but very few utilize it effectively. This project demonstrates how to:

- Clean and transform raw sales data
- Uncover hidden patterns in customer behavior
- Identify top-performing products and customer segments
- Improve marketing strategies through RFM segmentation
- Optimize inventory, revenue, and customer retention

> All done **100% in SQL**, without the use of any programming languages or visualization tools.

---

## 🧰 Technology Stack

- **Database:** MySQL / PostgreSQL (SQL-standard syntax)
- **Tools:** SQL Client (e.g., MySQL Workbench, DBeaver, pgAdmin)
- **Language:** SQL only (No Python, No Excel)
- **Dataset Source:** [Kaggle - E-Commerce Sales Data](https://www.kaggle.com/datasets/carrie1/ecommerce-data)

---

The project covers:
- 🔧 **Data Cleaning & Preprocessing**
- 📊 **Exploratory Data Analysis (EDA)**
- 📈 **Sales Trend Analysis**
- 🎯 **Customer Segmentation with RFM**
- 🛒 **Sales Optimization Queries**
- 📦 **Product Performance Insights**

---


## 📦 Dataset Description

The dataset comes from an online UK-based retail store that sells unique gift items. It contains **over 500,000 transactions** between **December 2010 and December 2011**. Fields include:

| Column        | Description                                 |
|---------------|---------------------------------------------|
| InvoiceNo     | Invoice number (canceled ones start with 'C') |
| StockCode     | Product identifier                          |
| Description   | Product description                         |
| Quantity      | Number of items purchased                   |
| InvoiceDate   | Timestamp of the invoice                    |
| UnitPrice     | Price per item                              |
| CustomerID    | Unique customer ID                          |
| Country       | Country of the customer                     |

---

## 🧹 Data Preprocessing

This folder contains all the scripts and notebooks used to clean and prepare the dataset before performing analysis.

Data Link: 🔗 [Data Set](https://drive.google.com/drive/folders/1t3oLkSQUluilEzn5HOht7SSkM_aX4C4S?usp=sharing)

### 📁 Folder Contents (Google Drive)

- `CSV Cleaning data.ipynb` – Python notebook using **Pandas** and **NumPy** to clean the raw CSV file.
- `sql_data_cleaning.sql` – SQL script to remove extra or garbage data after importing the dataset.
- `README.md` – This file (describes the preprocessing process).

### 🔍 Process Overview

We performed data preprocessing in **two major steps**:

**1. Python-Based Data Cleaning**
We used Pandas and NumPy in Python to prepare a clean and structured version of the dataset that would be easier to work with for SQL-based analytics.
The complete notebook used for this step is named: CSV Cleaning data.ipynb, located in the Data Preprocessing/ folder.
This was done using the notebook:  
📄 **[CSV Cleaning data.ipynb](Data%20Preprocessing/CSV%20Cleaning%20data.ipynb)**


**2. SQL-Based Data Cleaning**

After the initial cleanup, we further refined the dataset using SQL to remove any remaining unnecessary information and noise that could impact performance or skew analysis.
You can find the SQL file for this process inside the Data Preprocessing/ folder as well.
The SQL script for this step:  
📄 **[sql_data_cleaning.sql](Data%20Preprocessing/sql_data_cleaning.sql)**

### 📁 Raw Data Source

You can find the original uncleaned dataset in the Google Drive:  
📂 `Data Set/Row Data Set/`

🔗 [Raw Data](https://drive.google.com/file/d/1-FO8AQCkfhpwpFwUzt7FAKXq99GlJ3Vw/view?usp=drive_link)

Or download it directly from Kaggle:  
🔗 [Online Retail Dataset](https://www.kaggle.com/datasets/vijayuv/onlineretail)

### 📁 Main Data Set

You can find the original uncleaned dataset in the Google Drive:  
📂 `Data Set/Clean and main Data set/`

🔗 [EDA & RFM.csv](https://drive.google.com/file/d/1sEeb2H8rCSvIqSsmmCIFTsn9xwsEtWDi/view?usp=sharing)

### ✅ Final Output

After both cleaning phases, we obtained a **clean and analysis-ready dataset** which powers all further SQL queries and segmentation processes in the project.

Feel free to explore the `.ipynb` and `.sql` files in this folder to understand the cleaning process step-by-step.



---

## 📈 Project Highlights

### 1. **Data Cleaning & Preprocessing**
- Removal of nulls, cancellations, and zero or negative values
- Standardized product descriptions
- Duplicate detection
- Outlier filtering with IQR method

### 2. **Exploratory Data Analysis (EDA)**
- Top-selling products
- Country-wise and monthly sales trends
- Sales distribution by time and region
- Customer retention and behavior

### 3. **RFM Segmentation**
- Classify customers based on how recently, how often, and how much they purchase
- Create dynamic segments like:
  - Champions
  - Loyal Customers
  - Potential Loyalists
  - At Risk
  - Lost Customers

### 4. **Advanced Sales Analytics**
- Frequently bought together products
- Peak sales hours
- Underperforming SKUs
- Pareto (80/20) analysis on revenue

---

## 🎯 Why This Project?

Most analytics portfolios focus on tools like Python, Excel, or Power BI. This project sets itself apart by using **pure SQL** to show:

- Your **mastery of advanced SQL queries** for real-world business problems
- How SQL can be used for **data cleansing, analysis, and segmentation**
- Your ability to think like an analyst and act like a database expert

---

## ✅ Benefits / Use Cases

| Stakeholder     | Benefits                                           |
|------------------|----------------------------------------------------|
| 📊 Data Analysts | Learn advanced SQL for business analytics         |
| 📈 Marketing Teams | Identify high-value and at-risk customers       |
| 🧠 Business Strategists | Make smarter sales decisions              |
| 🧑‍💼 CRM Managers | Tailor campaigns by customer segments           |
| 🧑‍💻 SQL Learners  | Real-world project to showcase SQL proficiency  |

---

## 👥 Who Should Use This?

- **Aspiring Data Analysts or BI Developers** looking to enhance their portfolios
- **Startups & SMEs** needing SQL-only insights without hiring data teams
- **Students & job seekers** preparing for SQL-heavy analytics roles
- **Non-technical marketers** who want to collaborate with data teams

---

## 🛠️ Tools & Technologies

| Tool        | Purpose                       |
|-------------|-------------------------------|
| **MySQL**   | Data storage & query engine    |
| **SQL**     | Data cleaning & analysis       |
| **Kaggle**  | Dataset source                 |
| **CSV**     | Raw data format                |
| **TablePlus / MySQL Workbench** | Query interface (optional) |

---

## 📁 Project Structure

```
sales-data-analysis-rfm-segmentation-sql/
│
├── 📂 data/
│   └── [Kaggle - E-Commerce Sales Data](https://www.kaggle.com/datasets/carrie1/ecommerce-data)
├── 📂 Data Processing/
│   ├── 01_sql_data_cleaning.sql
│   ├── 02_CSV Cleaning data.ipynb
│
├── 📂 Analysis/
│   ├── 1. CreateDB and InsertData/Create & insert.sql
│   ├── 02_exploratory_data_analysis.sql
│   ├── 03_rfm_segmentation.sql
│   ├── 04_advanced_sales_queries.sql
│   └── 05_country_product_customer_insights.sql
│
├── 📄 README.md
└── 📄 ERD.png (optional: for visual schema)


```


---

## 🚀 How to Run

1. Import the `ecommerce_data.csv` into your SQL database (MySQL/PostgreSQL)
2. Run the queries in order:
   - `1_CreateDdatabase_and_data_cleaning.sql`
   - `2_data_cleaning.py`
   - `3_eda_queries.sql`
   - `4_rfm_segmentation.sql`
   - `5_sales_optimization_queries.sql`
3. Analyze the output or export to a dashboard tool if needed

---

## 💡 Final Words

This project is proof that you don’t need complex tools or languages to extract gold from data — just solid SQL skills and the right questions. Master this, and you’ll be equipped to tackle real business problems with confidence and clarity.

> ⭐ If you found this helpful, consider giving it a star on GitHub and sharing it with fellow analysts!

---

## ✅ Conclusion

Through this SQL-based project, we successfully demonstrated how raw transactional data can be transformed into meaningful business insights using structured querying alone. By applying:

- 🧹 **Rigorous data cleaning**
- 📊 **Exploratory data analysis**
- 🎯 **RFM segmentation for customer profiling**
- 🚀 **Advanced sales optimization queries**

…we were able to extract actionable intelligence that businesses can use to increase revenue, improve customer retention, reduce product returns, and optimize marketing and inventory strategies.

This project showcases that **SQL is more than just a database language** — it’s a powerful analytical tool when used to its full potential.

---

## 🔮 Future Enhancements

Here are several ideas that could take this project to the next level:

### 💻 Technical Enhancements
- **Automate the RFM Segmentation** using stored procedures or triggers
- Integrate this analysis into a **SQL-powered dashboard tool** like **Metabase**, **Superset**, or **Redash**
- Add **materialized views** or **data pipelines** for real-time analytics

### 📦 Dataset Expansion
- Merge with **Google Analytics or website clickstream data** for deeper funnel analysis
- Include **customer demographic data** for richer segmentation
- Add **marketing campaign data** to measure ROI and attribution

### 📈 Analytical Extensions
- Build a **churn prediction model** using SQL-based heuristics
- Calculate **Customer Lifetime Value (CLTV)** over time
- Perform **time-series forecasting** of revenue trends using SQL window functions

---

> With just SQL and structured thinking, you've now got a fully operational analytics engine in your portfolio. Add visuals, automate it, or combine it with real-time data — the foundation is rock-solid.

---

## 🙌 Thank You

If you found this project valuable or used it as a template to build your own, please consider:

- ⭐ Starring the GitHub repository
- 👥 Sharing it with fellow learners or colleagues
- 🛠️ Forking and extending it with your own ideas

Happy querying! 🚀

---

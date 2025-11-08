# zepto-data-analysis-sqlserver

Project Title

Zepto Inventory Data Analysis using SQL Server

📄 Project Overview

This project analyzes Zepto’s inventory dataset to uncover key business insights such as stock status, pricing patterns, revenue estimation, and discount-based performance.
The SQL analysis was performed in Microsoft SQL Server, focusing on data cleaning, transformation, and business reporting.

🧰 Tools & Technologies

Database: Microsoft SQL Server

Language: T-SQL (Transact-SQL)

Dataset Source: Kaggle – Zepto Inventory Dataset

File Used: zepto.xlsx

📂 Dataset Description

The dataset represents Zepto’s inventory information including:

Column	Description
category	Product category (e.g., Beverages, Snacks, Dairy)
name	Product name
mrp	Maximum Retail Price
discountPercent	Discount percentage applied
availableQuantity	Quantity available in stock
discountedSellingPrice	Final selling price after discount
weightInGms	Product weight (in grams)
outOfStock	1 = Out of Stock, 0 = In Stock
quantity	Number of units listed
🧹 Data Preparation & Cleaning

Key transformations performed before analysis:

Created schema zp and table zp.zpto

Added an identity primary key column (id)

Renamed inconsistent columns for readability (discSellingPrice → discSP, availableQuantity → avlQuantity)

Changed column data types:

mrp, discSP → NUMERIC(20,2)

discPercent → NUMERIC(5,2)

weightInGms → NUMERIC(10,2)

outOfStock → VARCHAR(10)

Converted outOfStock values to 'True' and 'False'

Removed invalid entries where mrp = 0 or discSP = 0

Converted values from paise to rupees by dividing price columns by 100

📊 Business Questions Answered
#	Analysis	SQL Concept Used
Q1	Top 10 products with highest discount percentage	ORDER BY, TOP, DISTINCT
Q2	Products with high MRP and out of stock	WHERE, logical filters
Q3	Estimated revenue by category	SUM, GROUP BY
Q4	Products with MRP > 500 and discount < 10%	WHERE, comparison operators
Q5	Categories with highest average discount	AVG(), GROUP BY, ROUND()
Q6	Price per gram for products above 100g	Arithmetic operation, ROUND(), CAST()
Q7	Categorize products by weight (Low, Medium, Bulk)	CASE WHEN
Q8	Total inventory weight per category	SUM(), aggregation
📈 Insights Derived

Top discounted items: Highlight best deals to attract customers.

Out-of-stock high-value items: Suggests potential restocking priorities.

Revenue by category: Identifies most profitable product groups.

Weight-based segmentation: Helps optimize delivery and packaging logistics.

Low-discount high-MRP products: Indicate premium or luxury items.

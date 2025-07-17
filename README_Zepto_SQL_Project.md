
# 🛒 Zepto Product Analysis SQL Project

## 📌 Project Overview
**Project Title**: Zepto Product Analysis  
**Level**: Beginner  
**Database Name**: `zepto`

This project is designed to demonstrate SQL skills and techniques used by data analysts to explore, clean, and analyze product-level retail data from Zepto. It includes setting up a product catalog database, performing exploratory data analysis (EDA), and solving real-world business queries using SQL.

---

## 🎯 Objectives

- Set up the Zepto product database
- Clean the data and handle invalid records
- Explore product categories, pricing, and stock details
- Use SQL to answer key business questions related to discounts, inventory, and pricing insights

---

## 🧱 Project Structure

### 1. Database Setup
A table named `zepto` is created with the following structure:

```sql
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,    
    quantity INTEGER
);
```

---

### 2. Data Exploration & Cleaning

- **Count Total Records**
```sql
SELECT COUNT(*) FROM zepto;
```

- **Check for NULL Values**
```sql
SELECT * FROM zepto WHERE
    name IS NULL OR category IS NULL OR mrp IS NULL OR
    discountPercent IS NULL OR availableQuantity IS NULL OR
    discountedSellingPrice IS NULL OR weightInGms IS NULL OR
    outOfStock IS NULL OR quantity IS NULL;
```

- **Delete Invalid MRP Entries**
```sql
DELETE FROM zepto WHERE mrp = 0;
```

- **Convert Paise to Rupees**
```sql
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

- **Find Duplicate Product Names**
```sql
SELECT name, COUNT(sku_id)
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1;
```

---

### 3. Data Analysis & Findings

- **Top 10 Best-Value Products**
```sql
SELECT name, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

- **High MRP but Out-of-Stock Products**
```sql
SELECT name, mrp
FROM zepto
WHERE outOfStock = TRUE
ORDER BY mrp DESC
LIMIT 10;
```

- **Estimated Revenue Per Category**
```sql
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS totalRevenue
FROM zepto
GROUP BY category;
```

- **High MRP with Low Discount**
```sql
SELECT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10;
```

- **Top 5 Categories by Average Discount**
```sql
SELECT category, ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
```

- **Best Price Per Gram (≥100g)**
```sql
SELECT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;
```

- **Weight Categorization**
```sql
SELECT name, weightInGms,
       CASE 
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;
```

- **Total Inventory Weight Per Category**
```sql
SELECT category, SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category;
```

---

## 📊 Key Findings

- **Discount Insights**: Identified the best-discounted products and high-discount categories.
- **Inventory Review**: Found high-MRP products that are out of stock—indicating supply risk.
- **Efficiency**: Evaluated price per gram to understand value.
- **Weight Classification**: Helps in logistics planning and storage optimization.

---

## 📝 Reports

- **Value Summary**: Products offering highest discounts
- **Stock Report**: Products out of stock vs. MRP
- **Pricing Analysis**: Best price per gram analysis

---

## ✅ Conclusion

This project offers a beginner-friendly and real-world introduction to SQL for retail product analysis. It includes data setup, cleaning, exploratory analysis, and deriving actionable insights—ideal for any aspiring Data Analyst’s portfolio.

---

## 🚀 How to Use

### 1. Clone the Repository
```bash
git clone https://github.com/V-Hemanth14/sql_retail_sales.git
```

### 2. Run SQL Script  
Open `zepto_sql_project.sql` in your preferred SQL tool (PostgreSQL, MySQL, DBeaver, etc.).

### 3. Explore & Extend  
Try modifying or adding queries to derive deeper business insights.

---

## 👤 Author – Hemanth V.

- 📷 Instagram: [@havoc_hemanth_7476](https://www.instagram.com/havoc_hemanth_7476)
- 📧 Email: hemanthvdv@gmail.com  
- 💼 LinkedIn: [Hemanth Vasanth](https://www.linkedin.com/in/hemanth-vasanth)

---

Thanks for checking out this project! Feel free to connect if you want to collaborate or give feedback.

# 🏬 Retail Inventory & Replenishment Optimizer (SQL | MySQL)

## 📌 Project Overview
This project analyzes retail sales, inventory, and supplier data to evaluate inventory health, demand variability, and replenishment risks across products and stores. The goal is to support data-driven inventory planning, minimize stockout risks, and optimize working capital utilization using SQL-based analysis.

---

## 🎯 Business Objectives
- Assess overall inventory health and demand patterns  
- Identify fast-moving and high-risk SKUs  
- Detect uneven demand across stores and categories  
- Evaluate supplier lead-time and MOQ constraints  
- Support proactive replenishment and inventory optimization  

---

## 🗂 Dataset Description
The project uses five realistic retail datasets:

| File Name | Description |
|---------|------------|
| `products.csv` | SKU master data (product, category, unit cost) |
| `stores.csv` | Store-level details and regions |
| `sales.csv` | Transaction-level sales data |
| `inventory_snapshots.csv` | Store-SKU inventory snapshots |
| `suppliers.csv` | Supplier constraints (lead time, MOQ, pack size) |

---

## 🧠 Analysis Workflow

### Step 1: Data Understanding & Sanity Checks
- Validated record counts, nulls, duplicates
- Verified SKU, store, and supplier consistency
- Confirmed sales and inventory data integrity

### Step 2: Core Business Analysis
- Identified fast-moving and revenue-driving SKUs
- Analyzed store-level revenue concentration
- Evaluated category-level demand patterns
- Assessed overall inventory health

### Step 3: Inventory Risk & Demand Patterns
- Analyzed demand variability across SKUs
- Identified uneven demand and localized inventory risks
- Highlighted categories needing tighter planning

### Step 4: Advanced Inventory & Replenishment Analysis
- Evaluated supplier lead-time exposure
- Assessed MOQ-driven working capital pressure
- Identified early warning signals for stockout risks
- Reviewed excess inventory scenarios

### Step 5: Executive-Level Insights & Recommendations
- Translated analysis into business actions
- Designed proactive inventory optimization strategies

---

## 🔍 Key Business Insights
- Fast-moving SKUs pose higher future stockout risk
- High revenue does not always imply high sales volume
- Demand is uneven across stores and categories
- Apparel shows high volatility and requires higher safety stock
- High supplier MOQ increases working capital pressure
- Current inventory is healthy but needs proactive monitoring

---

## 💡 Business Recommendations
- Implement SKU-level inventory prioritization
- Introduce early-warning inventory coverage metrics
- Apply category-specific safety stock policies
- Renegotiate supplier MOQ and replenishment terms
- Align replenishment cycles with store-level demand

---

## 💼 Overall Business Value Delivered
- Prevented future stockout risks through proactive analysis
- Improved replenishment prioritization and planning
- Reduced working capital lock-in risk
- Enabled category-specific inventory strategies
- Strengthened data-driven retail decision-making

---

## 🛠 SQL Concepts Used
- JOINs (INNER)
- GROUP BY & HAVING
- Aggregate functions
- Subqueries
- Date filtering & window logic
- Business KPI calculations

---

## 📊 Tools Used
- MySQL Workbench  
- SQL  
- Python (for data generation)  
- GitHub  

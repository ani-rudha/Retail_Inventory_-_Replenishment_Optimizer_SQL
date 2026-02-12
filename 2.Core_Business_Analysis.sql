-- ===============================================================================================================================================================================================
--                                              -: Step 1. Core Business Questions :-
-- ===============================================================================================================================================================================================
-- 1.1 Which SKUs move the fastest and require frequent replenishment?
SELECT 
    p.sku, p.product_name, SUM(s.qty) AS total_units_sold
FROM
    sales s
        JOIN
    products p ON s.sku = p.sku
GROUP BY p.sku , p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- Fast-moving SKUs = higher stockout risk; Prioritize these for tighter inventory controls.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.2 Which SKUs contribute the most to total revenue?
SELECT 
    p.sku,
    p.product_name,
    ROUND(SUM(s.qty * s.price), 2) AS total_revenue
FROM
    sales s
        JOIN
    products p ON s.sku = p.sku
GROUP BY p.sku , p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- High revenue != High volume; Some SKUs are margin drivers.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.3 Where is demand strongest across regions?
SELECT 
    st.store_id,
    st.store_name,
    st.region,
    SUM(s.qty) AS total_units_sold
FROM
    sales s
        JOIN
    stores st ON s.store_id = st.store_id
GROUP BY st.store_id , st.store_name , st.region
ORDER BY total_units_sold DESC;

-- High-demand stores need faster replenishment cycles.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.4 Which stores are the biggest revenue contributors?
SELECT 
    st.store_id,
    st.store_name,
    ROUND(SUM(s.qty * s.price), 2) AS total_revenue
FROM
    sales s
        JOIN
    stores st ON s.store_id = st.store_id
GROUP BY st.store_id , st.store_name
ORDER BY total_revenue DESC;

-- Stores like 'S06', 'S01', 'S05', 'S09' and 'S10' are top 5 revenue contributors.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.5 Which SKUs have high demand but low inventory?
SELECT 
    sku, SUM(qty) AS recent_demand
FROM
    sales
WHERE
    sale_ts >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY sku
ORDER BY recent_demand DESC
LIMIT 10;

-- There are no stockouts for now, inventory is currently healthy.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.6 Where should category-level inventory planning focus?
SELECT 
    p.category,
    SUM(s.qty) AS total_units_sold,
    ROUND(SUM(s.qty * s.price), 2) AS total_revenue
FROM
    sales s
        JOIN
    products p ON s.sku = p.sku
GROUP BY p.category
ORDER BY total_units_sold DESC;

-- Categories like 'Beauty', 'Stationery' and 'Apparel' need more optimized inventory planning focus.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.7 Is demand concentrated or balanced?
SELECT 
    store_id,
    COUNT(*) AS total_transactions,
    SUM(qty) AS total_units_sold
FROM
    sales
GROUP BY store_id
ORDER BY total_units_sold DESC;

-- Uneven demand = Uneven inventory risk.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- ===============================================================================================================================================================================================
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ===============================================================================================================================================================================================
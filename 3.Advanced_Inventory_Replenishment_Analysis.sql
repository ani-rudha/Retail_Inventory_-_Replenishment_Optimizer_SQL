-- ===============================================================================================================================================================================================
--                                         -: Step 2. Advanced Inventory & Replenishment Analysis :-
-- ===============================================================================================================================================================================================
-- 2.1 Which products have unstable demand and require higher safety stock?
SELECT 
    s.sku,
    ROUND(AVG(s.qty), 2) AS avg_daily_demand,
    ROUND(STDDEV(s.qty), 2) AS demand_std_dev
FROM
    sales s
GROUP BY s.sku
ORDER BY demand_std_dev DESC
LIMIT 10;

-- High variability = Forecasting risk; These SKUs need extra buffer stock.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.2 Which fast-moving products take longer to replenish?
SELECT 
    p.sku,
    p.product_name,
    SUM(s.qty) AS total_units_sold,
    sup.lead_time_days
FROM
    sales s
        JOIN
    products p ON s.sku = p.sku
        JOIN
    suppliers sup ON p.sku = sup.sku
GROUP BY p.sku , p.product_name , sup.lead_time_days
ORDER BY total_units_sold DESC , sup.lead_time_days DESC;

-- High demand + Long lead time = Stockout risk
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.3 Where should planners focus first?
SELECT 
    i.store_id,
    i.sku,
    SUM(s.qty) AS recent_demand,
    AVG(i.on_hand) AS avg_inventory,
    sup.lead_time_days
FROM
    inventory_snapshots i
        JOIN
    sales s ON i.store_id = s.store_id
        AND i.sku = s.sku
        JOIN
    suppliers sup ON i.sku = sup.sku
WHERE
    s.sale_ts >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY i.store_id , i.sku , sup.lead_time_days
ORDER BY recent_demand DESC , lead_time_days DESC;

-- Inventory is currently healthy, no need to plan restock.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.4 Are we forced to overstock due to supplier minimums?
SELECT 
    sup.sku,
    sup.order_min_qty,
    sup.order_pack_qty,
    ROUND(AVG(i.on_hand), 2) AS avg_inventory
FROM
    suppliers sup
        JOIN
    inventory_snapshots i ON sup.sku = i.sku
GROUP BY sup.sku , sup.order_min_qty , sup.order_pack_qty
ORDER BY order_min_qty DESC;

-- High MOQ(Minimum Order Quantity) = Working Capital Pressure; Suggest supplier renegotiation.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.5 Where are we holding too much stock relative to demand?
SELECT 
    i.store_id,
    i.sku,
    AVG(i.on_hand) AS avg_inventory,
    SUM(s.qty) AS recent_demand
FROM
    inventory_snapshots i
        JOIN
    sales s ON i.store_id = s.store_id
        AND i.sku = s.sku
WHERE
    s.sale_ts >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY i.store_id , i.sku
HAVING avg_inventory > recent_demand * 3
ORDER BY avg_inventory DESC;

-- Excess inventory = Tied-up cash; But in this case all good.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.6 Where should inventory policy differ by category?
SELECT 
    p.category,
    ROUND(AVG(s.qty), 2) AS avg_demand,
    ROUND(STDDEV(s.qty), 2) AS demand_variability,
    ROUND(AVG(i.on_hand), 2) AS avg_inventory
FROM
    sales s
        JOIN
    products p ON s.sku = p.sku
        JOIN
    inventory_snapshots i ON s.sku = i.sku
GROUP BY p.category
ORDER BY demand_variability DESC;

-- 'Apparel' requires much higher stock than 'Home' or 'Beauty' due to greater volatility and product variety.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- ===============================================================================================================================================================================================
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ===============================================================================================================================================================================================
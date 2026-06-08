-- =====================================================
-- Superstore Profitability Analysis
-- Objective: Investigate why company profit margin declined from 13.33% in 2016 to 12.80% in 2017.
-- =====================================================


-- =====================================================
-- 1. Company-Level Analysis
-- =====================================================

-- Annual company sales, profit and profit margin.

SELECT
	YEAR(order_date) AS yr,
	ROUND(SUM(sales), 2) AS total_sales,
	ROUND(SUM(profit), 2) AS total_profit,
	ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore
GROUP BY yr
ORDER BY yr;

-- =====================================================
-- 2. Category-Level Analysis
-- =====================================================

-- Category-level profit margin analysis.

SELECT
	category,
        YEAR(order_date) AS  yr,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore
GROUP BY 
	yr,
        category
	ORDER BY category, yr;


-- =====================================================
-- 3. Sub-Category Analysis
-- =====================================================


-- Sub-category level profit margin analysis within Office Supplies category.


SELECT
    sub_category,
    YEAR(order_date) AS yr,
    ROUND(SUM(sales), 2) AS sales,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin
FROM superstore
WHERE category = 'Office Supplies' 
GROUP BY sub_category, yr
ORDER BY sub_category, yr;



-- Identify sub-categories with the largest profit margin decline between 2016 and 2017.


WITH margins AS (

SELECT	
    sub_category,
    SUM(CASE WHEN YEAR(order_date) = 2016 THEN profit END) / SUM(CASE WHEN YEAR(order_date) = 2016 THEN sales END) * 100 AS margin_2016,
    SUM(CASE WHEN YEAR(order_date) = 2017 THEN profit END) / SUM(CASE WHEN YEAR(order_date) = 2017 THEN sales END) * 100 AS margin_2017
FROM superstore
GROUP BY sub_category)

SELECT 
    sub_category,
    ROUND(margin_2016, 2) AS margins_2016,
    ROUND(margin_2017, 2) AS margins_2017,
    ROUND(margin_2017 - margin_2016, 2) AS margin_change
FROM margins
ORDER BY margin_change;

-- =====================================================
-- 4. Binder Investigation
-- =====================================================


-- Test whether increased discounting explains the Binder margin decline.

	
SELECT 
    sub_category,
    YEAR(order_date) AS yr,
    ROUND(AVG(discount), 2) AS avg_discounts
FROM superstore
WHERE sub_category = 'Binders'
GROUP BY yr, sub_category
ORDER BY yr DESC;
    

-- Identify Binder products with negative profit margins in 2017.

SELECT 
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS total_margins
FROM superstore
WHERE sub_category = 'Binders' AND YEAR(order_date) = 2017
GROUP BY 
    sub_category,
    product_name
HAVING total_margins < 0
ORDER BY
	total_margins;

-- =====================================================
-- 5. Product-Level Investigation
-- =====================================================


-- Compare key Binder products between 2016 and 2017 to identify drivers of margin decline.

WITH binder_info AS (SELECT 
    product_name,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2016 THEN sales END), 2) AS sales_2016,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2016 THEN profit END), 2) AS profit_2016,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2016 THEN profit END) / SUM(CASE WHEN YEAR(order_date) = 2016 THEN sales END) * 100, 2) AS margin_2016,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2017 THEN sales END), 2) AS sales_2017,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2017 THEN profit END), 2) AS profit_2017,
    ROUND(SUM(CASE WHEN YEAR(order_date) = 2017 THEN profit END) / SUM(CASE WHEN YEAR(order_date) = 2017 THEN sales END) * 100, 2) AS margin_2017
FROM superstore
WHERE product_name IN (
	'Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind', 
	'Ibico Hi-Tech Manual Binding System', 
	'Ibico EPK-21 Electric Binding System', 
	'GBC Ibimaster 500 Manual ProClick Binding System')
GROUP BY product_name)

SELECT
    product_name,
    sales_2016,
    profit_2016,
    margin_2016,
    sales_2017,
    profit_2017,
    margin_2017,
    ROUND(sales_2017 - sales_2016, 2) AS sales_change,
    ROUND(profit_2017 - profit_2016, 2) AS profit_change,
    ROUND(margin_2017 - margin_2016, 2) AS margin_change
FROM binder_info
; 


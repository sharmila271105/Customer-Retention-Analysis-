select count( * ) from  online_retail_ii

-- Group by all key columns; count > 1 = duplicate

SELECT Invoice, StockCode, `Customer ID`, InvoiceDate, Quantity, Price,
    COUNT(*) AS duplicate_count
FROM online_retail_ii
GROUP BY
    Invoice, StockCode, `Customer ID`,
    InvoiceDate, Quantity, Price
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Count nulls and calculate % of total rows
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN 'Customer ID' IS NULL THEN 1 ELSE 0 END)
        AS missing_customer_id,
    ROUND(
        SUM(CASE WHEN 'Customer ID' IS NULL THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS missing_pct
FROM online_retail_ii;

-- Separate negative (returns) from zero (bad data)
SELECT
    SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END)
        AS negative_qty_rows,
    SUM(CASE WHEN Quantity = 0 THEN 1 ELSE 0 END)
        AS zero_qty_rows
FROM online_retail_ii;

-- Flag prices that are zero or negative
SELECT
    COUNT(*) AS invalid_price_rows,
    MIN(Price) AS min_price,
    MAX(Price) AS max_price
FROM online_retail_ii
WHERE Price <= 0;

-- Combine all exclusions into one clean dataset
CREATE TABLE online_retail_clean AS
SELECT *
FROM online_retail_ii
WHERE
   `Customer ID` IS NOT NULL
    AND Quantity > 0
    AND Price > 0
    AND Invoice NOT LIKE 'C%'; -- exclude cancellations
    
select * from online_retail_clean;
  -- Avg number of orders placed per customer
SELECT
    ROUND(AVG(order_count), 2) AS avg_purchase_frequency
FROM (
    SELECT
        `Customer ID`,
        COUNT(DISTINCT Invoice) AS order_count
    FROM online_retail_clean
    GROUP BY `Customer ID`
) AS freq;

-- Revenue, orders, and AOV for each top customer
SELECT
    `Customer ID`,
    COUNT(DISTINCT Invoice)       AS total_orders,
    ROUND(SUM(Quantity * Price), 2) AS total_revenue,
    ROUND(AVG(Quantity * Price), 2) AS avg_order_value
FROM online_retail_clean
GROUP BY `Customer ID`
ORDER BY total_revenue DESC
LIMIT 10;
-- Count unique customers (nulls already removed in clean table)
SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM online_retail_clean;

-- Each InvoiceNo = one unique order
SELECT
    COUNT(DISTINCT Invoice) AS total_orders
FROM online_retail_clean;

-- Revenue = price × qty per line item, summed up
SELECT
    ROUND(SUM(Quantity * Price), 2) AS total_revenue
FROM online_retail_clean;



-- Label each customer, then count by label
SELECT
    customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        `Customer ID`,
        CASE
            WHEN COUNT(DISTINCT Invoice) = 1 THEN 'One-Time'
            ELSE 'Returning'
        END AS customer_type
    FROM online_retail_clean
    GROUP BY `Customer ID`
) AS segments
GROUP BY customer_type;
-- First get revenue per order, then average those
SELECT
    ROUND(AVG(order_revenue), 2) AS avg_order_value
FROM (
    SELECT
        Invoice ,
        SUM(Quantity * Price) AS order_revenue
    FROM online_retail_clean
    GROUP BY Invoice
) AS order_totals;

-- Repeat = customer made more than 1 order
SELECT
    ROUND(
        COUNT(CASE WHEN order_count > 1 THEN 1 END)
        * 100.0 / COUNT(*), 2
    ) AS repeat_customer_rate_pct
FROM (
    SELECT
        `Customer ID`,
        COUNT(DISTINCT Invoice) AS order_count
    FROM online_retail_clean
    GROUP BY `Customer ID`
) AS customer_orders;

#daily  REVENUE TREND 
SELECT
    DAY(InvoiceDate) AS Day,
    ROUND(SUM(Quantity * Price),2) AS Revenue
FROM online_retail_clean
GROUP BY DAY(InvoiceDate)
ORDER BY Day;

#REVENUE BY COUNTRY 
SELECT
    Country,
    ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM online_retail_clean
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 10;
/*
==========================================================
TARGET BRAZIL E-COMMERCE ANALYSIS - COMPLETE BUSINESS INTELLIGENCE STUDY
Professional SQL Analysis Following YouTube Case Study Structure
==========================================================
Project: Target Brazil Operations Analysis (2016-2018)
Dataset: TARGET_SQL_DATASET
Analyst: [Your Name]  
Date: October 2025

Business Context:
As a data analyst at Target, this comprehensive analysis examines our Brazilian
e-commerce operations to extract valuable insights and provide actionable 
recommendations for business growth and operational efficiency.

Analysis covers 6 key areas:
1. Data exploration and validation
2. Order trends and seasonality patterns  
3. Geographic expansion opportunities
4. Economic impact and revenue analysis
5. Delivery performance optimization
6. Payment behavior insights
==========================================================
*/

-- ==========================================
-- PHASE 1: DATASET IMPORT & EXPLORATORY ANALYSIS  
-- Foundation: Understanding data structure and scope
-- ==========================================

/*
Starting with the fundamentals - we need to understand what we're working with
before diving into complex analysis. This phase establishes data quality,
scope boundaries, and gives us confidence in our subsequent findings.
*/

-- 1.1 Data type exploration of customers table
-- Understanding the structure helps with future joins and analysis planning
'''SELECT * FROM `TARGET_SQL_DATASET.Customers`
LIMIT 10; '''

SELECT * FROM `TARGET_SQL_DATASET.Geolocation`
LIMIT 5; 

-- 1.2 Establishing our analysis timeframe
-- Critical for understanding seasonal patterns and growth trajectories
SELECT 
    MIN(order_purchase_timestamp) AS START_TIME, 
    MAX(order_purchase_timestamp) AS END_TIME
FROM `TARGET_SQL_DATASET.orders`; 

-- 1.3 Geographic reach during our analysis period
-- Shows the breadth of our market presence across Brazilian cities and states
SELECT 
    COUNT(DISTINCT CUSTOMER_CITY) AS TOTAL_CITIES,
    COUNT(DISTINCT CUSTOMER_STATE) AS TOTAL_STATES,
    COUNT(DISTINCT C.CUSTOMER_ID) AS TOTAL_CUSTOMERS
FROM `TARGET_SQL_DATASET.Customers` C
JOIN `TARGET_SQL_DATASET.orders` O 
    ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- ==========================================
-- PHASE 2: IN-DEPTH EXPLORATION OF ORDER TRENDS
-- Understanding customer behavior and demand patterns
-- ==========================================

/*
Now we're getting into the behavioral patterns that drive business decisions.
When do customers buy? Are we growing or declining? These insights directly
inform inventory planning, marketing campaigns, and resource allocation.
*/

-- 2.1 Year-over-year growth trend analysis
-- Reveals if we're building momentum or losing ground over time
WITH yearly_orders AS (
  SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS ORDER_YEAR,
    COUNT(order_id) AS TOTAL_ORDERS
  FROM `TARGET_SQL_DATASET.orders`
  GROUP BY ORDER_YEAR
)
SELECT
  ORDER_YEAR,
  TOTAL_ORDERS,
  LAG(TOTAL_ORDERS) OVER (ORDER BY ORDER_YEAR) AS PREV_YEAR_ORDERS,
  ROUND(
    ((TOTAL_ORDERS - LAG(TOTAL_ORDERS) OVER (ORDER BY ORDER_YEAR)) * 100.0) /
    NULLIF(LAG(TOTAL_ORDERS) OVER (ORDER BY ORDER_YEAR), 0), 2
  ) AS YEAR_OVER_YEAR_GROWTH_PCT
FROM yearly_orders
ORDER BY ORDER_YEAR;

-- 2.2 Monthly seasonality patterns - FIXED for BigQuery
-- Which months consistently outperform? Essential for inventory and marketing planning
WITH monthly_orders AS (
    SELECT 
        EXTRACT(MONTH FROM ORDER_PURCHASE_TIMESTAMP) AS MONTH, 
        COUNT(ORDER_ID) AS ORDER_COUNT
    FROM `TARGET_SQL_DATASET.orders`
    GROUP BY MONTH
),
monthly_stats AS (
    SELECT 
        MONTH,
        ORDER_COUNT,
        AVG(ORDER_COUNT) OVER() AS MONTHLY_AVERAGE
    FROM monthly_orders
)
SELECT 
    MONTH,
    ORDER_COUNT,
    ROUND(MONTHLY_AVERAGE, 2) AS MONTHLY_AVERAGE,
    ROUND(
        (ORDER_COUNT - MONTHLY_AVERAGE) * 100.0 / MONTHLY_AVERAGE, 2
    ) AS VARIANCE_FROM_AVG_PCT
FROM monthly_stats
ORDER BY ORDER_COUNT DESC;

-- 2.3 Customer ordering patterns by time of day
-- Understanding when Brazilians prefer to shop online
-- Dawn (0-6h) | Morning (7-12h) | Afternoon (13-18h) | Night (19-23h)
WITH hourly_orders AS (
    SELECT 
        EXTRACT(HOUR FROM ORDER_PURCHASE_TIMESTAMP) AS ORDER_HOUR,
        COUNT(ORDER_ID) AS ORDER_COUNT
    FROM `TARGET_SQL_DATASET.orders`
    GROUP BY ORDER_HOUR
)
SELECT 
    CASE 
        WHEN ORDER_HOUR BETWEEN 0 AND 6 THEN 'Dawn (0-6h)'
        WHEN ORDER_HOUR BETWEEN 7 AND 12 THEN 'Morning (7-12h)'  
        WHEN ORDER_HOUR BETWEEN 13 AND 18 THEN 'Afternoon (13-18h)'
        ELSE 'Night (19-23h)'
    END AS TIME_PERIOD,
    SUM(ORDER_COUNT) AS TOTAL_ORDERS,
    ROUND(SUM(ORDER_COUNT) * 100.0 / (SELECT SUM(ORDER_COUNT) FROM hourly_orders), 2) AS PERCENTAGE_OF_ORDERS
FROM hourly_orders
GROUP BY TIME_PERIOD
ORDER BY TOTAL_ORDERS DESC;

-- ==========================================
-- PHASE 3: EVOLUTION OF E-COMMERCE ORDERS IN BRAZIL
-- Geographic performance and regional opportunities
-- ==========================================

/*
Brazil's vast geography means different states perform very differently.
This section reveals where we're winning, where we're losing, and most
importantly - where the untapped opportunities lie waiting.
*/

-- 3.1 Month-on-month orders by state (Top 10 states only for readability)
-- Shows how our key markets are evolving over time
WITH top_states AS (
    SELECT 
        C.CUSTOMER_STATE
    FROM `TARGET_SQL_DATASET.Customers` C
    GROUP BY C.CUSTOMER_STATE
    ORDER BY COUNT(DISTINCT C.CUSTOMER_ID) DESC
    LIMIT 10
)
SELECT 
    C.CUSTOMER_STATE,
    EXTRACT(YEAR FROM O.ORDER_PURCHASE_TIMESTAMP) AS ORDER_YEAR,
    EXTRACT(MONTH FROM O.ORDER_PURCHASE_TIMESTAMP) AS ORDER_MONTH, 
    COUNT(O.ORDER_ID) AS MONTHLY_ORDERS
FROM `TARGET_SQL_DATASET.orders` O
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE C.CUSTOMER_STATE IN (SELECT CUSTOMER_STATE FROM top_states)
GROUP BY C.CUSTOMER_STATE, ORDER_YEAR, ORDER_MONTH
ORDER BY C.CUSTOMER_STATE, ORDER_YEAR, ORDER_MONTH;

-- 3.2 Customer distribution across all Brazilian states
-- Reveals market penetration and identifies expansion opportunities
SELECT 
    CUSTOMER_STATE,
    COUNT(DISTINCT CUSTOMER_ID) AS CUSTOMER_COUNT,
    ROUND(COUNT(DISTINCT CUSTOMER_ID) * 100.0 / (
        SELECT COUNT(DISTINCT CUSTOMER_ID) 
        FROM `TARGET_SQL_DATASET.Customers`
    ), 2) AS PERCENTAGE_OF_CUSTOMERS,
    RANK() OVER (ORDER BY COUNT(DISTINCT CUSTOMER_ID) DESC) AS STATE_RANK
FROM `TARGET_SQL_DATASET.Customers`
GROUP BY CUSTOMER_STATE
ORDER BY CUSTOMER_COUNT DESC;

-- ==========================================
-- PHASE 4: ECONOMIC IMPACT & MONEY MOVEMENT ANALYSIS
-- Following the financial trail to measure business success
-- ==========================================

/*
Revenue metrics tell the real story of business performance. Growth in order
volume means nothing if average order values are declining. This section
quantifies our financial trajectory and identifies our most valuable markets.
*/

-- 4.1 Year-over-year cost increase (2017 vs 2018, Jan-Aug comparison)
-- Measuring financial growth in comparable periods
WITH YEARLY_TOTALS AS (
    SELECT 
        EXTRACT(YEAR FROM O.ORDER_PURCHASE_TIMESTAMP) AS YEAR, 
        SUM(P.PAYMENT_VALUE) AS TOTAL_PAYMENT
    FROM `TARGET_SQL_DATASET.payments` AS P 
    JOIN `TARGET_SQL_DATASET.orders` AS O 
        ON P.ORDER_ID = O.ORDER_ID 
    WHERE EXTRACT(YEAR FROM O.ORDER_PURCHASE_TIMESTAMP) IN (2017, 2018)
        AND EXTRACT(MONTH FROM O.ORDER_PURCHASE_TIMESTAMP) BETWEEN 1 AND 8
    GROUP BY EXTRACT(YEAR FROM O.ORDER_PURCHASE_TIMESTAMP)
),
YEARLY_COMPARISON AS (
    SELECT 
        YEAR, 
        TOTAL_PAYMENT, 
        LAG(TOTAL_PAYMENT) OVER(ORDER BY YEAR) AS PREV_YEAR_PAYMENT
    FROM YEARLY_TOTALS
)
SELECT 
    YEAR,
    ROUND(TOTAL_PAYMENT, 2) AS TOTAL_PAYMENT,
    ROUND(PREV_YEAR_PAYMENT, 2) AS PREV_YEAR_PAYMENT,
    ROUND(((TOTAL_PAYMENT - PREV_YEAR_PAYMENT) / PREV_YEAR_PAYMENT) * 100, 2) AS PCT_INCREASE
FROM YEARLY_COMPARISON
WHERE PREV_YEAR_PAYMENT IS NOT NULL;

-- 4.2 Total and Average order price by state
-- Identifies high-value markets and pricing power by region
SELECT 
    C.CUSTOMER_STATE,
    COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
    ROUND(SUM(OI.PRICE), 2) AS TOTAL_ORDER_VALUE, 
    ROUND(AVG(OI.PRICE), 2) AS AVERAGE_ORDER_PRICE
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.order_items` OI 
    ON O.ORDER_ID = OI.ORDER_ID 
JOIN `TARGET_SQL_DATASET.Customers` C  
    ON O.CUSTOMER_ID = C.CUSTOMER_ID 
GROUP BY C.CUSTOMER_STATE
ORDER BY TOTAL_ORDER_VALUE DESC; 

-- 4.3 Total and Average freight value by state
-- Reveals logistics costs and identifies optimization opportunities
SELECT 
    C.CUSTOMER_STATE,
    COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
    ROUND(SUM(OI.FREIGHT_VALUE), 2) AS TOTAL_FREIGHT_COST, 
    ROUND(AVG(OI.FREIGHT_VALUE), 2) AS AVERAGE_FREIGHT_COST
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.order_items` OI 
    ON O.ORDER_ID = OI.ORDER_ID 
JOIN `TARGET_SQL_DATASET.Customers` C  
    ON O.CUSTOMER_ID = C.CUSTOMER_ID 
GROUP BY C.CUSTOMER_STATE
ORDER BY TOTAL_FREIGHT_COST DESC;

-- ==========================================
-- PHASE 5: DELIVERY PERFORMANCE & LOGISTICS ANALYSIS
-- Measuring customer satisfaction through delivery metrics
-- ==========================================

/*
In e-commerce, delivery performance directly impacts customer satisfaction,
repeat purchases, and brand loyalty. Late deliveries hurt more than just
that one transaction - they damage long-term customer relationships.
*/

-- 5.1 Delivery time calculation and estimated vs actual comparison
-- Core metrics for logistics performance assessment
SELECT 
    ORDER_ID, 
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS DAYS_TO_DELIVERY, 
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS DIFF_ESTIMATED_DELIVERY
FROM `TARGET_SQL_DATASET.orders`
WHERE order_delivered_customer_date IS NOT NULL 
    AND order_estimated_delivery_date IS NOT NULL;

-- 5.2 Top 5 states with HIGHEST average freight value
-- These markets may need logistics optimization or pricing adjustments
SELECT 
    C.CUSTOMER_STATE,  
    ROUND(AVG(OI.FREIGHT_VALUE), 2) AS AVG_FREIGHT_VALUE
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.order_items` OI
    ON O.ORDER_ID = OI.ORDER_ID 
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_STATE 
ORDER BY AVG_FREIGHT_VALUE DESC 
LIMIT 5; 

-- 5.3 Top 5 states with LOWEST average freight value
-- These represent our most efficient logistics markets
SELECT 
    C.CUSTOMER_STATE,  
    ROUND(AVG(OI.FREIGHT_VALUE), 2) AS AVG_FREIGHT_VALUE
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.order_items` OI
    ON O.ORDER_ID = OI.ORDER_ID 
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_STATE 
ORDER BY AVG_FREIGHT_VALUE ASC 
LIMIT 5; 

-- 5.4 Top 5 states with HIGHEST average delivery time
-- Priority areas for logistics improvement initiatives
SELECT 
    C.CUSTOMER_STATE,  
    ROUND(AVG(DATE_DIFF(DATE(O.order_delivered_customer_date), DATE(O.order_purchase_timestamp), DAY)), 2) AS AVG_DELIVERY_TIME_DAYS
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.order_delivered_customer_date IS NOT NULL
GROUP BY C.CUSTOMER_STATE 
ORDER BY AVG_DELIVERY_TIME_DAYS DESC 
LIMIT 5; 

-- 5.5 Top 5 states with LOWEST average delivery time
-- Our logistics success stories - models for other regions
SELECT 
    C.CUSTOMER_STATE,  
    ROUND(AVG(DATE_DIFF(DATE(O.order_delivered_customer_date), DATE(O.order_purchase_timestamp), DAY)), 2) AS AVG_DELIVERY_TIME_DAYS
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.order_delivered_customer_date IS NOT NULL
GROUP BY C.CUSTOMER_STATE 
ORDER BY AVG_DELIVERY_TIME_DAYS ASC 
LIMIT 5; 

-- 5.6 Top 5 states with fastest delivery compared to estimates
-- Where we're exceeding customer expectations consistently
SELECT 
    C.CUSTOMER_STATE,
    ROUND(AVG(DATE_DIFF(DATE(O.order_delivered_customer_date), DATE(O.order_estimated_delivery_date), DAY)), 2) AS AVG_DELIVERY_VS_ESTIMATE,
    COUNT(O.ORDER_ID) AS TOTAL_ORDERS
FROM `TARGET_SQL_DATASET.orders` O 
JOIN `TARGET_SQL_DATASET.Customers` C 
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE O.order_delivered_customer_date IS NOT NULL 
    AND O.order_estimated_delivery_date IS NOT NULL
GROUP BY C.CUSTOMER_STATE 
HAVING COUNT(O.ORDER_ID) >= 100  -- Filter for statistical significance
ORDER BY AVG_DELIVERY_VS_ESTIMATE ASC 
LIMIT 5;

-- ==========================================
-- PHASE 6: PAYMENT BEHAVIOR & FINANCIAL PREFERENCES
-- Understanding how customers prefer to pay
-- ==========================================

/*
Payment methods reveal customer financial behavior, trust levels, and price
sensitivity. Changes in payment patterns can signal economic shifts or
competitive pressures that require strategic responses.
*/

-- 6.1 Month-on-month orders by payment type
-- Tracking evolution of payment preferences over time
WITH monthly_payment_orders AS (
  SELECT
    P.PAYMENT_TYPE,
    EXTRACT(YEAR FROM O.order_purchase_timestamp) AS ORDER_YEAR,
    EXTRACT(MONTH FROM O.order_purchase_timestamp) AS ORDER_MONTH,
    COUNT(DISTINCT O.ORDER_ID) AS ORDER_COUNT
  FROM `TARGET_SQL_DATASET.orders` O
  INNER JOIN `TARGET_SQL_DATASET.payments` P
    ON O.ORDER_ID = P.ORDER_ID
  GROUP BY P.PAYMENT_TYPE, ORDER_YEAR, ORDER_MONTH
),
monthly_totals AS (
  SELECT
    ORDER_YEAR,
    ORDER_MONTH,
    SUM(ORDER_COUNT) AS MONTHLY_TOTAL_ORDERS
  FROM monthly_payment_orders
  GROUP BY ORDER_YEAR, ORDER_MONTH
)
SELECT
  mpo.PAYMENT_TYPE,
  mpo.ORDER_YEAR,
  mpo.ORDER_MONTH,
  mpo.ORDER_COUNT,
  ROUND(mpo.ORDER_COUNT * 100.0 / mt.MONTHLY_TOTAL_ORDERS, 2) AS PERCENTAGE_OF_MONTHLY_ORDERS
FROM monthly_payment_orders mpo
JOIN monthly_totals mt
  ON mpo.ORDER_YEAR = mt.ORDER_YEAR AND mpo.ORDER_MONTH = mt.ORDER_MONTH
ORDER BY mpo.ORDER_YEAR, mpo.ORDER_MONTH, mpo.ORDER_COUNT DESC;

-- 6.2 Order distribution by payment installments - FIXED for BigQuery
-- Understanding customer credit behavior and price sensitivity
WITH installment_stats AS (
    SELECT 
        payment_installments, 
        COUNT(DISTINCT ORDER_ID) AS NUM_ORDERS,
        ROUND(AVG(payment_value), 2) AS AVG_PAYMENT_VALUE
    FROM `TARGET_SQL_DATASET.payments` 
    GROUP BY payment_installments
),
total_orders AS (
    SELECT SUM(NUM_ORDERS) AS TOTAL_ORDERS
    FROM installment_stats
)
SELECT 
    ins.payment_installments,
    ins.NUM_ORDERS,
    ROUND(ins.NUM_ORDERS * 100.0 / tot.TOTAL_ORDERS, 2) AS PERCENTAGE_OF_ORDERS,
    ins.AVG_PAYMENT_VALUE
FROM installment_stats ins
CROSS JOIN total_orders tot
ORDER BY ins.payment_installments;




SELECT * FROM customer_data;

-- Query 1
SELECT
    CASE
        WHEN BLS >= 0.70 AND PDI <= 0.30
            THEN 'Genuine Loyal'
        WHEN BLS >= 0.70 AND PDI > 0.30
            THEN 'Discount Loyal'
        WHEN BLS < 0.70 AND PDI > 0.50
            THEN 'Bargain Hunter'
        ELSE 'Occasional Customer'
    END AS customer_segment,

    COUNT(*) AS customers,
    ROUND(AVG(purchase_amount),2) AS avg_spend,
    ROUND(AVG(previous_purchases),2) AS avg_previous_purchases,
    ROUND(AVG(e_LTV),2) AS avg_ltv

FROM customer_data
GROUP BY customer_segment
ORDER BY avg_ltv DESC;

--Query 2
SELECT
    customer_value_tier,

    ROUND(AVG(BLS),3) AS avg_bls,
    ROUND(AVG(ELS),3) AS avg_els,
    ROUND(AVG(RQI),3) AS avg_rqi,
    ROUND(AVG(previous_purchases),2) AS avg_prev_purchases,
    ROUND(AVG(review_rating),2) AS avg_rating

FROM customer_data
GROUP BY customer_value_tier
ORDER BY avg_bls DESC;

-- Query 3
SELECT
    category,

    ROUND(AVG(previous_purchases),2) AS avg_prev_purchases,
    ROUND(AVG(BLS),2) AS avg_bls,
    ROUND(AVG(e_LTV),2) AS avg_ltv,
    COUNT(*) AS customers

FROM customer_data
GROUP BY category
ORDER BY avg_prev_purchases DESC;

-- Query 4
SELECT
    category,

    ROUND(AVG(previous_purchases),2) AS avg_prev_purchases,
    COUNT(*) AS customers

FROM customer_data
GROUP BY category
ORDER BY avg_prev_purchases ASC;

-- Query 5
SELECT
    season,

    ROUND(AVG(previous_purchases),2) AS avg_prev_purchases,
    ROUND(AVG(BLS),2) AS avg_bls,
    ROUND(AVG(e_LTV),2) AS avg_ltv

FROM customer_data
GROUP BY season
ORDER BY avg_prev_purchases DESC;

-- Query 6
SELECT
    location,

    COUNT(*) AS customers,

    ROUND(AVG(purchase_amount),2) AS avg_spend,
    ROUND(AVG(PDI),2) AS avg_pdi,
    ROUND(AVG(BLS),2) AS avg_bls,
    ROUND(AVG(e_LTV),2) AS avg_ltv

FROM customer_data
GROUP BY location
HAVING COUNT(*) >= 20
ORDER BY avg_ltv DESC;

-- Query 7
SELECT
    gender,

    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        ELSE '45+'
    END AS age_group,

    COUNT(*) AS customers,
    ROUND(AVG(e_LTV),2) AS avg_ltv

FROM customer_data
GROUP BY gender, age_group
ORDER BY avg_ltv DESC;

-- Query 8
SELECT
    gender,
    category,
    payment_method,
    subscription_status,

    COUNT(*) AS customers,

    ROUND(AVG(e_LTV),2) AS avg_ltv,
    ROUND(AVG(BLS),2) AS avg_bls,
    ROUND(AVG(review_rating),2) AS avg_rating

FROM customer_data
WHERE customer_value_tier = 'Platinum'

GROUP BY
    gender,
    category,
    payment_method,
    subscription_status

ORDER BY avg_ltv DESC
LIMIT 10;

--Query 9
SELECT
    customer_value_tier,

    ROUND(AVG(PDI),2) AS avg_pdi,
    ROUND(AVG(BLS),2) AS avg_bls,
    ROUND(AVG(e_LTV),2) AS avg_ltv

FROM customer_data
GROUP BY customer_value_tier
ORDER BY avg_ltv DESC;
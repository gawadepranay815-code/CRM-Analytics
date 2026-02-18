create database crm_db;
use crm_db;

-- KPI 1 EXPECTED AMOUNT
SELECT 
    ROUND(SUM(expected_amount) / 1000000, 2) AS expected_amount_million
FROM opportunity;

-- KPI 2 ACTIVE OPPORTUNITY
SELECT 
    COUNT(*) AS active_opportunities
FROM opportunity
WHERE stage NOT IN ('Closed Won', 'Closed Lost');

-- KPI 3 CONVERSION RATE (%)
SELECT
    ROUND(
        SUM(CASE 
            WHEN stage = 'Closed Won' THEN 1 
            ELSE 0 
        END) / COUNT(opportunity_id) * 100,
        2
    ) AS conversion_rate
FROM opportunity;

-- KPI 4 WIN RATE (%)
SELECT
    ROUND(
        (SUM(CASE WHEN stage = 'Closed Won' THEN 1 ELSE 0 END) /
        (SUM(CASE WHEN stage = 'Closed Won' THEN 1 ELSE 0 END) +
         SUM(CASE WHEN stage = 'Closed Lost' THEN 1 ELSE 0 END))) * 100,
        2
    ) AS win_rate_percent
FROM opportunity;

-- KPI 5 LOST RATE (%)
SELECT 
    ROUND(
        (SUM(CASE WHEN stage = 'Closed Lost' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS loss_rate_percent
FROM opportunity;

-- 1)CLOSED WON VS TOTAL OPPORTUNITIES
SELECT
    YEAR(close_date) AS year,
    COUNT(*) AS total_opportunities,
    SUM(CASE WHEN stage = 'closed Won' THEN 1 ELSE 0 END) AS won_opportunities
FROM opportunity
GROUP BY YEAR(close_date)
ORDER BY year;

-- 2) ACTIVE VS TOTAL OPPORTUNITIES
SELECT
    YEAR(close_date) AS year,
    COUNT(*) AS total_opportunities,
    SUM(
        CASE 
            WHEN stage NOT IN ('closed Won', 'closed Lost') THEN 1 
            ELSE 0 
        END
    ) AS active_opportunities
FROM opportunity
GROUP BY YEAR(close_date)
ORDER BY year;

-- 3) EXPECTED AMOUNT BY OPPORTUNITY TYPE
SELECT
    IFNULL(NULLIF(opportunity_type, ''), 'Others') AS opportunity_type,
    ROUND(SUM(expected_amount) / 1000000, 2) AS expected_amount_mn
FROM opportunity
GROUP BY IFNULL(NULLIF(opportunity_type, ''), 'Others')
ORDER BY expected_amount_mn DESC;

-- 4)OPPORTUNITY BY INDUSTRY
SELECT
    IFNULL(NULLIF(industry, ''), 'Others') AS industry,
    COUNT(*) AS opportunity_count
FROM opportunity
GROUP BY IFNULL(NULLIF(industry, ''), 'Others')
ORDER BY opportunity_count DESC;

-- 5)CLOSED WON VS TOTAL CLOSED
SELECT
    YEAR(close_date) AS year,
    COUNT(*) AS total_closed_opportunities,
    SUM(CASE WHEN stage = 'closed Won' THEN 1 ELSE 0 END) AS closed_won_opportunities
FROM opportunity
WHERE stage IN ('closed Won', 'closed Lost')
GROUP BY YEAR(close_date)
ORDER BY year;
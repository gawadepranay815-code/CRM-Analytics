-- KPI 1) TOTAL LEADS
SELECT COUNT(*) AS total_leads
FROM leads;

-- KPI 2) CONVERTED LEADS
SELECT COUNT(*) AS converted_leads
FROM leads
WHERE Converted = TRUE;

-- KPI 3) CONVERSION RATE (%)
SELECT 
    (SUM(CASE WHEN Converted = TRUE THEN 1 ELSE 0 END) 
     / COUNT(*)) * 100 AS conversion_rate_pct
FROM leads;

-- KPI 4) CONVERTED ACCOUNTS
SELECT SUM(`# Converted Accounts`) AS converted_accounts
FROM leads;

-- KPI 5) CONVERTED OPPORTUNITIES
SELECT SUM(`# Converted Opportunities`) AS converted_opportunities
FROM leads;

-- 1) LEAD BY SOURCE
SELECT 
    `Lead Source`,
    COUNT(*) AS total_leads
FROM leads
GROUP BY `Lead Source`
ORDER BY total_leads DESC;

-- 2) LEAD BY INDUSTRY
SELECT 
    Industry,
    COUNT(*) AS total_leads
FROM leads
GROUP BY Industry
ORDER BY total_leads DESC;

-- 3) LEAD BY STAGE 
SELECT 
    Status AS stage,
    COUNT(*) AS total_leads
FROM leads
GROUP BY Status
ORDER BY total_leads DESC;
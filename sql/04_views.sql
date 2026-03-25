USE insuredata_project;

CREATE VIEW premium_summary AS
SELECT 
    policy_category,
    COUNT(*) AS total_policies,
    SUM(premium_decimal) AS total_premium
FROM master_policies
GROUP BY policy_category;

CREATE VIEW monthly_premium AS
SELECT 
    DATE_FORMAT(start_date, '%Y-%m') AS month,
    SUM(premium_decimal) AS total_premium
FROM master_policies
GROUP BY month;

-- Test views
SELECT * FROM premium_summary;
SELECT * FROM monthly_premium;

USE insuredata_project;

DROP PROCEDURE IF EXISTS Run_Insurance_ETL;

DELIMITER //

CREATE PROCEDURE Run_Insurance_ETL()
BEGIN

    DELETE FROM master_policies;
    TRUNCATE TABLE data_error_logs;

    -- STEP 1: Insert CLEAN data
    INSERT IGNORE INTO master_policies (   
        customer_name,
        policy_category,
        premium_decimal,
        start_date
    )
    SELECT 
        TRIM(UPPER(cust_name)),

        CASE 
            WHEN UPPER(policy_type) LIKE '%MOTOR%' THEN 'MOTOR'
            WHEN UPPER(policy_type) LIKE '%LIFE%' THEN 'LIFE'
            WHEN UPPER(policy_type) LIKE '%HEALTH%' THEN 'HEALTH'
            ELSE 'OTHER'
        END,

        CAST(premium_amt AS DECIMAL(10,2)),

        STR_TO_DATE(policy_start_date, '%Y-%m-%d')

    FROM staging_insurance_data

    WHERE 
        cust_name IS NOT NULL
        AND policy_type IS NOT NULL
        AND premium_amt IS NOT NULL
        AND premium_amt REGEXP '^[0-9]+(\\.[0-9]+)?$'
        AND LENGTH(premium_amt) <= 7
        AND CAST(premium_amt AS DECIMAL(10,2)) > 0
        AND policy_start_date IS NOT NULL
        AND policy_start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        AND STR_TO_DATE(policy_start_date, '%Y-%m-%d') <= CURDATE();

    -- STEP 2: Log INVALID data
    INSERT INTO data_error_logs (source_id, issue_description)
    SELECT 
        raw_id,

        CASE 
            WHEN cust_name IS NULL THEN 'Missing Customer Name'
            WHEN policy_type IS NULL THEN 'Missing Policy Type'
            WHEN premium_amt IS NULL THEN 'Missing Premium'
            WHEN premium_amt = '' THEN 'Empty Premium'
            WHEN premium_amt NOT REGEXP '^[0-9]+(\\.[0-9]+)?$' THEN 'Invalid Premium Format'
            WHEN LENGTH(premium_amt) > 7 THEN 'Premium Too Large'
            WHEN CAST(premium_amt AS DECIMAL(10,2)) <= 0 THEN 'Negative or Zero Premium'
            WHEN policy_start_date IS NULL THEN 'Missing Date'
            WHEN policy_start_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN 'Invalid Date Format'
            WHEN STR_TO_DATE(policy_start_date, '%Y-%m-%d') > CURDATE() THEN 'Future Date'

            ELSE 'Unknown Issue'
        END

    FROM staging_insurance_data

    WHERE 
        cust_name IS NULL
        OR policy_type IS NULL
        OR premium_amt IS NULL
        OR premium_amt = ''
        OR premium_amt NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
        OR LENGTH(premium_amt) > 7
        OR CAST(premium_amt AS DECIMAL(10,2)) <= 0
        OR policy_start_date IS NULL
        OR policy_start_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        
        OR STR_TO_DATE(policy_start_date, '%Y-%m-%d') > CURDATE();

END //

DELIMITER ;

CALL Run_Insurance_ETL();

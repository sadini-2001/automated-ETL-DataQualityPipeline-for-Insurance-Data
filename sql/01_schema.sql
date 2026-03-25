CREATE DATABASE IF NOT EXISTS insuredata_project;
USE insuredata_project;

-- Staging Table
CREATE TABLE staging_insurance_data (
    raw_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(100),
    policy_type VARCHAR(50),
    premium_amt VARCHAR(50),
    policy_start_date VARCHAR(50)
);

-- Master Table
CREATE TABLE master_policies (
    policy_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    policy_category VARCHAR(50),
    premium_decimal DECIMAL(10,2),
    start_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Error Log Table
CREATE TABLE data_error_logs (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    source_id INT,
    issue_description VARCHAR(255),
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

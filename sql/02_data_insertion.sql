USE insuredata_project;

-- Bulk generated clean data
INSERT INTO staging_insurance_data (cust_name, policy_type, premium_amt, policy_start_date)
SELECT 
    CONCAT('Customer_', FLOOR(RAND()*10000)),
    ELT(FLOOR(1 + RAND()*3), 'motor', 'life', 'health'),
    FLOOR(1000 + RAND()*9000),
    DATE_FORMAT(DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*365) DAY), '%Y-%m-%d')
FROM 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION 
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION 
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t2;

-- Real-world messy data
INSERT INTO staging_insurance_data (cust_name, policy_type, premium_amt, policy_start_date) VALUES
('Kamal Perera', 'life plan', NULL, '2023-02-01'),
('Ravi', 'life', '4000', NULL),
(NULL, 'motor', '3000', '2023-02-01'),
('John Doe', 'life insurance', 'abc', '2023-04-01'),
('Anne', 'motor', '5k', '2023-05-01'),
('Dilshan', 'life', '', '2023-08-01'),
('Amara Fernando', 'health', '-3000', '2023-03-10'),
('Suresh', 'motor', '0', '2023-06-01'),
('Nimal Silva', 'motor', '4500', '01-03-2023'),
('Saman', 'motor', '7000', '2023/07/01'),
('Kavindi', 'life', '5500', 'March 5 2023'),
('Chathura', 'motor', '9000', 'invalid-date'),
('   kasun   ', 'motor policy', '6000', '2023-05-15'),
('SADINI', 'MOTOR INSURANCE', '5000', '2023-01-01'),
('Madhavi', 'unknown type', '3500', '2023-06-20'),
('Thilini', 'random plan', '4500', '2023-07-01'),
('@@@User###', 'motor', '3000', '2023-01-01'),
('ThisNameIsWayTooLongForNormalUseCaseTestingPurposes', 'life', '5000', '2023-02-01'),
('Sadini', 'motor insurance', '5000', '2023-01-01'),
('sadini ', 'Motor Insurance', '5000', '2023-01-01'),
('Kasun Perera', 'Motor', '7500', '2023-02-10'),
('Kasun Perera', 'Motor', '7500', '2023-02-10'),
('Test User', NULL, '5000', '2023-01-01'),
('Ghost', 'motor', '999999999999', '2023-03-01'),
('Future User', 'motor', '5000', '2100-01-01'),
('Old User', 'life', '4000', '1900-01-01'),
('duplicate', 'motor', '4000', '2023-08-01'),
('duplicate', 'motor', '4000', '2023-08-01'),
('ExtremeZero', 'life', '0', '2023-01-01'),
('ExtremeNegative', 'health', '-999999', '2023-01-01');

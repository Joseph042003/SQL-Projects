-- Data Exploration 
SELECT * FROM customer_data_stg;
DESCRIBE customer_data_stg;
-- Customer Gender and % of Total
SELECT gender, COUNT(gender) as Total_Count, 
COUNT(gender) * 100.0 /(SELECT COUNT(*) FROM customer_data_stg) AS Percentage_Total
FROM customer_data_stg
GROUP BY gender;

-- Contract Type & % of Total
SELECT contract, COUNT(contract) as Total_count, 
(COUNT(contract) / (SELECT COUNT(*) FROM customer_data_stg)) * 100 as Percentage_Total
FROM customer_data_stg
GROUP BY contract;

-- Customer Status & Total Sales
SELECT Customer_Status, COUNT(customer_status) AS Total_Count, SUM(Total_Revenue) as Total_Revenue,
SUM(Total_Revenue) / (SELECT SUM(Total_Revenue) FROM customer_data_stg) * 100 as Percentage_Total
FROM customer_data_stg 
GROUP BY Customer_Status;

-- Customers Segmentation by State
SELECT State, COUNT(State) as Total_count, 
(COUNT(State) / (SELECT COUNT(*) FROM customer_data_stg)) * 100 as Percentage_Total
FROM customer_data_stg
GROUP BY State
ORDER BY Percentage_Total desc;

-- Data Cleaning & Transformation 

-- Checking distinct values in a column
SELECT distinct Internet_Type
FROM customer_data_stg;

-- Set blank values to NULL for later transformation
UPDATE customer_data_stg
SET 
    Value_Deal = NULLIF(Value_Deal, ''),
    Unlimited_Data = NULLIF(Unlimited_Data, ''),
    Total_Revenue = NULLIF(Total_Revenue, ''),
    Total_Refunds = NULLIF(Total_Refunds, ''),
    Total_Long_Distance_Charges = NULLIF(Total_Long_Distance_Charges, ''),
    Total_Extra_Data_Charges = NULLIF(Total_Extra_Data_Charges, ''),
    Total_Charges = NULLIF(Total_Charges, ''),
    Tenure_in_Months = NULLIF(Tenure_in_Months, ''),
    Streaming_TV = NULLIF(Streaming_TV, ''),
    Streaming_Music = NULLIF(Streaming_Music, ''),
    Streaming_Movies = NULLIF(Streaming_Movies, ''),
    State = NULLIF(State, ''),
    Premium_Support = NULLIF(Premium_Support, ''),
    Phone_Service = NULLIF(Phone_Service, ''),
    Payment_Method = NULLIF(Payment_Method, ''),
    Paperless_Billing = NULLIF(Paperless_Billing, ''),
    Online_Security = NULLIF(Online_Security, ''),
    Online_Backup = NULLIF(Online_Backup, ''),
    Number_of_Referrals = NULLIF(Number_of_Referrals, ''),
    Multiple_Lines = NULLIF(Multiple_Lines, ''),
    Monthly_Charge = NULLIF(Monthly_Charge, ''),
    Married = NULLIF(Married, ''),
    Internet_Type = NULLIF(Internet_Type, ''),
    Internet_Service = NULLIF(Internet_Service, ''),
    Gender = NULLIF(Gender, ''),
    Device_Protection_Plan = NULLIF(Device_Protection_Plan, ''),
    Customer_Status = NULLIF(Customer_Status, ''),
    Customer_ID = NULLIF(Customer_ID, ''),
    Contract = NULLIF(Contract, ''),
    Churn_Reason = NULLIF(Churn_Reason, ''),
    Churn_Category = NULLIF(Churn_Category, ''),
    Age = NULLIF(Age, '');

-- Checking NULL Values in All Columns
SELECT 
	SUM(CASE WHEN Customer_ID IS  NULL THEN 1 ELSE 0 END) AS Customer_ID_NULL_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_NULL_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_NULL_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_NULL_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_NULL_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_NULL_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_NULL_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_NULL_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_NULL_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_NULL_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_NULL_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_NULL_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_NULL_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_NULL_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_NULL_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_NULL_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_NULL_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_NULL_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_NULL_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_NULL_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_NULL_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_NULL_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_NULL_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_NULL_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_NULL_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_NULL_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_NULL_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_NULL_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_NULL_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_NULL_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_NULL_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_NULL_Count    
FROM customer_data_stg;

-- Create a second table for production process
CREATE TABLE customer_data_prd (
    Customer_ID VARCHAR(50) NOT NULL PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    Married TEXT,
    State TEXT,
    Number_of_Referrals INT,
    Tenure_in_Months INT,
    Value_Deal TEXT,
    Phone_Service TEXT,
    Multiple_Lines TEXT,
    Internet_Service VARCHAR(50),
    Internet_Type VARCHAR(50),
    Online_Security TEXT,
    Online_Backup TEXT,
    Device_Protection_Plan TEXT,
    Premium_Support TEXT,
    Streaming_TV TEXT,
    Streaming_Movies TEXT,
    Streaming_Music TEXT,
    Unlimited_Data TEXT,
    Contract VARCHAR(50),
    Paperless_Billing TEXT,
    Payment_Method VARCHAR(50),
    Monthly_Charge DOUBLE,
    Total_Charges DOUBLE,
    Total_Refunds DOUBLE,
    Total_Extra_Data_Charges INT,
    Total_Long_Distance_Charges DOUBLE,
    Total_Revenue DOUBLE,
    Customer_Status VARCHAR(50),
    Churn_Category VARCHAR(50),
    Churn_Reason VARCHAR(255)
);

-- Insert all data with modification to the second table
INSERT INTO customer_data_prd
	SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    IFNULL(Number_of_Referrals, 0) AS Number_of_Referrals,
    Tenure_in_Months,
    IFNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    IFNULL(Multiple_Lines, 'No') As Multiple_Lines,
    Internet_Service,
    IFNULL(Internet_Type, 'None') AS Internet_Type,
    IFNULL(Online_Security, 'No') AS Online_Security,
    IFNULL(Online_Backup, 'No') AS Online_Backup,
    IFNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    IFNULL(Premium_Support, 'No') AS Premium_Support,
    IFNULL(Streaming_TV, 'No') AS Streaming_TV,
    IFNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    IFNULL(Streaming_Music, 'No') AS Streaming_Music,
    IFNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    IFNULL(Churn_Category, 'Others') AS Churn_Category,
    IFNULL(Churn_Reason , 'Others') AS Churn_Reason
	FROM customer_data_stg;

-- Create Views 
CREATE VIEW vw_churndata AS
	SELECT * FROM customer_data_prd 
    WHERE Customer_Status IN ('Churned' , 'Stayed');
    
CREATE VIEW vw_joindata AS
	SELECT * FROM customer_data_prd 
    WHERE Customer_Status IN ('Joined');


    


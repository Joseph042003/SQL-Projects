/*
Project: Patient Satisfaction Survey Data Cleaning in PostgreSQL 
Skilled Used: CTEs, JOIN, TO_DATE FUNCTION TO STANDARDISE DATE, CAST, AGGREGRATE FUNCTIONS

*/
-- Checking the data after importing into Postgres
--select *
--from "postgres"."hospital_Data".hcahps_data

-- Creating a new table after joining two tables 
--Create table "postgres"."hospital_Data".Final_Tableau_File as 


--Creating common table expression 
WITH hospital_beds_prep AS 
(
SELECT lpad(CAST(provider_ccn AS text),6,'0') AS provider_ccn, -- convert to text and left padding number 0 until reaching 6 characters.
 	   hospital_name,
	   to_date(fiscal_year_begin_date,'MM/DD/YYYY') AS fiscal_year_begin_date, -- change the format of date from text to date 
	   									   -- and modify the date to MM/DD/YYYY format								  
	   to_date(fiscal_year_end_date,'MM/DD/YYYY') AS fiscal_year_end_date,
	   number_of_beds,
	   -- assigning number to the hospitals that are reported more than once by the provider_cnn value, 
	   -- the newest reporting date will be assigned as 1 and so on.
	   ROW_NUMBER() OVER (PARTITION BY provider_ccn ORDER BY  to_date(fiscal_year_end_date,'MM/DD/YYYY') DESC) AS nth_row
FROM "postgres"."hospital_Data".hospital_beds
)

SELECT lpad(CAST(facility_id AS text),6,'0') AS provider_ccn, 
	   to_date(start_date,'MM/DD/YYYY') AS start_date_converted, 							  
	   to_date(end_date,'MM/DD/YYYY') AS end_date_converted,
	   hcahps.*,
	   beds.number_of_beds, 
	   beds.fiscal_year_begin_date AS beds_start_report_period, 
	   beds.fiscal_year_end_date AS beds_end_report_period
FROM "postgres"."hospital_Data".hcahps_data AS hcahps
LEFT JOIN hospital_beds_prep AS beds
ON lpad(CAST(facility_id as text),6,'0') = beds.provider_ccn
AND beds.nth_row = 1

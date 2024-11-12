-- Checking the data after importing into Postgres
--select *
--from "postgres"."hospital_Data".hcahps_data

-- Creating a new table after joining two tables 
--Create table "postgres"."hospital_Data".Final_Tableau_File as 


--Creating common table expression 
with hospital_beds_prep as 
(
select lpad(cast(provider_ccn as text),6,'0') as provider_ccn, -- convert to text and left padding number 0 until reaching 6 characters.
 	   hospital_name,
	   to_date(fiscal_year_begin_date,'MM/DD/YYYY') as fiscal_year_begin_date, -- change the format of date from text to date 
	   																		   -- and modify the date to MM/DD/YYYY format								  
	   to_date(fiscal_year_end_date,'MM/DD/YYYY') as fiscal_year_end_date,
	   number_of_beds,
	   -- assigning number to the hospitals that are reported more than once by the provider_cnn value, 
	   -- the newest reporting date will be assigned as 1 and so on.
	   row_number() over (partition by provider_ccn order by to_date(fiscal_year_end_date,'MM/DD/YYYY') desc) as nth_row
from "postgres"."hospital_Data".hospital_beds
)

select lpad(cast(facility_id as text),6,'0') as provider_ccn, 
	   to_date(start_date,'MM/DD/YYYY') as start_date_converted, 							  
	   to_date(end_date,'MM/DD/YYYY') as end_date_converted,
	   hcahps.*,
	   beds.number_of_beds, 
	   beds.fiscal_year_begin_date as beds_start_report_period, 
	   beds.fiscal_year_end_date as beds_end_report_period
from "postgres"."hospital_Data".hcahps_data as hcahps
left join hospital_beds_prep as beds
on lpad(cast(facility_id as text),6,'0') = beds.provider_ccn
and beds.nth_row = 1

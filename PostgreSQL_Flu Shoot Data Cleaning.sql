/* 
Project: Flu Shoot Data Cleaning in PostgreSQL
Skills Used: CTEs, Aggregate Functions, Date Extration, Joining Tables
*/
with flu_shot_2022 as (
	
select patient, min(date) as earliest_flu_shot_2022 
from public.immunizations
where code = '5302'
and date between '2022-01-01 00:00' and '2022-12-31 23:59'
group by patient
	
),
active_patient as 
(
	select distinct patient 
	from public.encounters as e
	join public.patients as pat 
	on e.patient = pat.id
	where start between '2020-01-01 00:00' and '2022-12-31 23:59'
	and pat.deathdate is null 
	and extract (month from age( '2022-12-31', pat.birthdate)) >= 6
)

select pat.birthdate
, extract(YEAR FROM age('2022-12-31 00:00', birthdate)) as age
, pat.race
, pat.county
, pat.id
, pat.first
, pat.last
, flu.patient
, flu.earliest_flu_shot_2022
, case when flu.patient is null then 0 else 1 
end as flu_shot_2022
from public.patients as pat
left join flu_shot_2022 as flu
on pat.id = flu.patient

where 1=1 
and pat.id in (select patient from active_patient)






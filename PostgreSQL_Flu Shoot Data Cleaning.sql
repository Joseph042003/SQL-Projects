/* 
select description, count(*) as count_of_cond
from public.conditions
where description != 'Body Mass Index 30.0-30.9, adult'
group by description
having count(*) > 5000
order by count(*) desc

select * 
from public.patients 
where city = 'Boston'

select * 
from public.conditions
where code in ('585.1' , '585.2' , '585.3' , '585.4'  )
order by code 

select city, count(*) as count_of_patient
from public.patients
where city != 'Boston'
group by city 
having count(*) >= 100
order by city desc
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






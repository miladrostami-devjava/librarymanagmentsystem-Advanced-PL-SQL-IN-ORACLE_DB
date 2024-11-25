





-- create view for countries table
create or replace view view_countries_tables as
       select
           c.country_id ,
           c.country_name,
           c.region_id,
           count(l.location_id) as total_locations,
           distinct(l.city) as total_cities,
           length(c.country_name) as country_name_length,
           rank() over (order by count(l.location_id) desc) as rank_location,
           categorize_location_count_for_country(count(l.location_id)) as population_category

       from countries c
       left join regions r on r.region_id = c.region_id
       right join locations l on l.country_id = c.country_id
       group by c.country_id, c.country_name, c.region_id
         having count(l.location_id) > 10
with check  option;
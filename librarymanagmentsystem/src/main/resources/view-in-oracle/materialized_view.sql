create materialized view view_countries_materialized
       build immediate refresh on demand  as
       select
           c.country_id ,
           c.country_name,
           c.region_id,
           COUNT(l.location_id) AS total_locations
       FROM
           countries c
               LEFT JOIN regions r ON c.region_id = r.region_id
               LEFT JOIN locations l ON c.country_id = l.country_id
       GROUP BY
           c.country_id, c.country_name, r.region_name
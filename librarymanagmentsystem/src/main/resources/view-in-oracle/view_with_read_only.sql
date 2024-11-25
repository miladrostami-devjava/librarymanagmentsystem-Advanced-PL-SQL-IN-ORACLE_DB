CREATE OR REPLACE VIEW vw_countries_info AS
SELECT
    c.country_id,
    c.country_name,
    r.region_name,
    COUNT(l.location_id) AS total_locations
FROM
    countries c
        LEFT JOIN regions r ON c.region_id = r.region_id
        LEFT JOIN locations l ON c.country_id = l.country_id
GROUP BY
    c.country_id, c.country_name, r.region_name
    WITH READ ONLY;

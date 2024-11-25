-- create function for categorize location count for country
create or replace function   categorize_location_count_for_country(
       locations_count in number) return varchar2 is
begin
       if locations_count > 20 then
          return 'high population country';
          elsif locations_count between 10 and 20 then
                return 'medium population country';
                elsif locations_count < 10 then
                return 'low population country';
else
                      return 'not populated country';
end if;

end categorize_location_count_for_country;
/
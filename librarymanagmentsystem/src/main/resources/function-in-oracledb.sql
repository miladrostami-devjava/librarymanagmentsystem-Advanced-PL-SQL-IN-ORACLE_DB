
-- function in pl/sql oracle db


create or replace function calculate_count_cusotmerss
return number is
declare
total_count number(10) := 0;
begin

select count(*) into total_count from customerss;
dbms_output.put_line('the count of customerss :' || total_count);
return total_count;


end calculate_count_cusotmerss;
/




--  anonymous block

declare
out_number number(2);
begin
  out_number := calculate_count_cusotmerss;
  dbms_output.put_line('the total number :' || out_number);
end;
/



/*
Example:
calculate max number between a and b number  ,with function method?
*/


declare

a number;
b number;
c number;

function find_max( x in number ,y in number)
  return number is
  declare
z number;

begin

  if x > y then
    z := x;
else
      z := y;
end if;
return z;
end find_max;

begin
  a := 22;
  b := 33;
  c := find_max(a,b);
    dbms_output.put_line('maximum number in find_max(22,33) is :' || c);
end;
/




-- create factorial function number

-- n! = n*(n-1)!
-- = n*(n-1)(n-2)!
-- = n*(n-1)(n-2)(n-3)!
-- = n*(n-1)(n-2)(n-3)(n-4)!

declare
num number;
factorial number;
function factori(x number) return number
   is
   a number

begin


   if x = 0 then
    a := 1;

else
      a := x*factori(x-1);
end if;
return a;


begin

    num := 3;
    factorial := factori(num);
    dbms_output.put_line(' factorial := factori(3) is :' || c);



end;
/






-------------------- example in pl/sql --------------------------------

-- To calculate the distance between two geographic points






create or replace function calculate_distance
(
longitude_origin number,
longitude_destination number,
latitude_origin number,
latitude_destination number
)
return number
is
delta_longitude  number;
delta_latitude  number;
a number;
c number;
deg_to_radian number := 3.14159265359 /180;
r constant number = 6374;
distance_points number :=0;

begin
  delta_longitude := longitude_destination - longitude_origin;
  delta_latitude := latitude_destination - latitude_origin;

  latitude_origin := latitude_origin*deg_to_radian;
  latitude_destination := latitude_destination*deg_to_radian;

  a := sin(delta_latitude/2) * sin (delta_latitude/2) + sin(delta_longitude/2)*sin(delta_longitude/2)*cos(latitude_destination)*cos(latitude_origin);
  c := 2 * atan2(sqrt(a),sqrt(a-1));
  distance_points := a * b;

return  distance_points;
end calculate_distance;/


declare
dis number;
begin

dis := calculate_distance(53.355,54.3568,85.25,29.25665);
dbms_output.put_line('distance is : ' || dis);
end;
/







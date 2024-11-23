
-- create varray in oracle db
create or replace type varray_armin as varray(5) of varchar(20);
/

create or replace type varray_armin_1 as varray(10) of varchar(100);
/
declare

names varray_armin;
begin
names := varray_armin('miladrostami','alijabari','arminrostami','atefeazad');
    DBMS_OUTPUT.PUT_LINE(names(2));
end;


declare
last_name varray_armin_1;
    total_count INTEGER;
begin
    last_name:= varray_armin_1('rostami','zare','mirzaie','hasani','porreza','moradi','porhossinei');
    total_count := last_name.count;
for i in 1 .. total_count loop
            dbms_output.put_line('last_name is : ' || last_name(i));
end loop;
end;



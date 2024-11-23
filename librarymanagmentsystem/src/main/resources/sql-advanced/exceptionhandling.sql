select * from customers;
select * from customerss;


-----------------------------------------system defind exception type-----------------------------------------------------------
-- system defind exception type


create or replace procedure result_out(number1 number, number2 number,resultout out number)
is
begin
      resultout := number1 + number2;

end result_out;


  create or replace procedure div(var_1 varchar2,date_1 date ,out_1 out varchar2) as
begin

  out_1 := var_1 || '   '  ||   to_char(date_1,'dd-mm-yyyy') || ' this is important' || 'code ora232';

end div;




declare m_id customerss.id%type := 8;
m_name customerss.name%type;
m_age customerss.age%type;
m_addr customerss.address%type;
sum_result number;
result_out_1 varchar2(100);

begin
select name, age, address
into m_name, m_age, m_addr
from customerss c
where c.id = m_id;
dbms_output.put_line('the name' || m_name);
  dbms_output.put_line('the age' || m_age);
  dbms_output.put_line('the address' || m_addr);

  -- system defind exception type
exception

  when ACCESS_INTO_NULL then
    dbms_output.put_line('you have not access to this part of program');
when CASE_NOT_FOUND then
    dbms_output.put_line('you not found case!!');
when VALUE_ERROR then
    dbms_output.put_line('value error in program milad!!');
when PROGRAM_ERROR then
    dbms_output.put_line('has the error in program milad!!');
when NOT_LOGGED_ON then
    dbms_output.put_line('has the NOT_LOGGED_ON in program milad!!');
when no_data_found then
   result_out(4,3,sum_result);
   div('rostami',to_date('06-05-1992','dd-mm-yyyy'),result_out_1);

    dbms_output.put_line('has the not_found_data in program milad!! , sum result is:' ||
     sum_result || ' and the result_out_1 is : ' || result_out_1);

end;


-------------------------------------user defind exception type---------------------------------------------------------------

--user defind exception type





declare m_id customerss.id%type :=&cm_id;
m_name customerss.name%type;
m_age customerss.age%type;
m_addr customerss.address%type;
exception_invalid_id exception;

begin

if m_id < 0 then
  raise exception_invalid_id;
else


select name, age, address
into m_name, m_age, m_addr
from customerss c
where c.id = m_id;
dbms_output.put_line('the name' || m_name);
  dbms_output.put_line('the age' || m_age);
  dbms_output.put_line('the address' || m_addr);
end if;

exception

  when ACCESS_INTO_NULL then
    dbms_output.put_line('you have not access to this part of program');
when CASE_NOT_FOUND then
    dbms_output.put_line('you not found case!!');
when VALUE_ERROR then
    dbms_output.put_line('value error in program milad!!');
when PROGRAM_ERROR then
    dbms_output.put_line('has the error in program milad!!');
when NOT_LOGGED_ON then
    dbms_output.put_line('has the NOT_LOGGED_ON in program milad!!');
when exception_invalid_id then
          dbms_output.put_line('please enter valid id for me');
when no_data_found then

    dbms_output.put_line('has the not_found_data in program milad!!');
when others then
      dbms_output.put_line('others is error!!!!');

end;


----------------------------------------------------------------------------------------------------



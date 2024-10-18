

/*Other methods to manage and assign dynamic values ​​to parameters and variables at runtime*/


/*1. Input parameters to functions and procedures*/

create or replace procedure procedure_show_id(id_number in  number) as

begin

  dbms_output.put_line('The ID is: ' || id_number);


end procedure_show_id;


begin
  procedure_show_id(500);
end;




/*2. Using Bind Variables in SQL*Plus*/


 variable  milad_var number;
begin
 :milad_var := 23;
end;
/
select * from customerss where id = :milad_var;



/*3. Using the EXECUTE IMMEDIATE command for dynamic SQL*/

declare
query_1 varchar2(800);
code_1 number := 3;
l_name customerss.name%type;
begin
  query_1 := 'select name from customerss where id = :id';
execute immediate query_1  into l_name using code_1;
dbms_output.put_line('the name is ' || l_name);
end;
/


declare
query_2 varchar2(1500);
code_2 number := 2;
l_name customerss.name%type;
begin
  query_2 := 'update customerss set name = ''java milad''   where id = :id';
execute immediate query_2   using code_2;

query_2 := 'select name from customerss where id = :id';
execute immediate query_2 into l_name using code_2;
dbms_output.put_line('the name is :' || l_name);
end;
/



/*4. Dynamic PL/SQL blocks*/

declare

declare_plsql_block varchar2(1200);

begin
  declare_plsql_block := '
  begin
  dbms_output.put_line(''Hello form dynamic pl/sql in  oracle db'');
    dbms_output.put_line(''Hello form dynamic java in  oracle db'');
  end;
  ';
execute immediate declare_plsql_block;

dbms_output.put_line('the result is :' || declare_plsql_block);
end;
/




/*5. Working with Global Application Context variables*/


exec dbms_session.set_context('MY_CTX', 'USER_ID', '200');
select sys_context('MY_CTX', 'USER_ID') from dual;















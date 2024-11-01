



-- cursor in oracledb plsql language



create table customerss (
                            id number primary key,
                            name varchar2(50),
                            age number,
                            address varchar2(50),
                            salary number
);

insert into customerss (id,name,age,address,salary) values (1,'reza',23,'tehran 23',22);
insert into customerss (id,name,age,address,salary) values (2,'milad',24,'tehran 23',22);
insert into customerss (id,name,age,address,salary) values (3,'danesh',33,'tehran 23',5);
insert into customerss (id,name,age,address,salary) values (4,'mostafa',45,'tehran 23',3);
insert into customerss (id,name,age,address,salary) values (5,'arash',12,'tehran 23',2);
insert into customerss (id,name,age,address,salary) values (6,'mohamadreza',54,'tehran 23',11);
insert into customerss (id,name,age,address,salary) values (7,'yones',23,'tehran 23',22);
insert into customerss (id,name,age,address,salary) values (8,'amir1',12,'tehran 23',65);
insert into customerss (id,name,age,address,salary) values (9,'amir2',12,'tehran 23',66);
insert into customerss (id,name,age,address,salary) values (10,'jahangiri',55,'tehran 23',22);


select * from customerss;

-- 1. implicit cursor

declare

customer_numbers number(2);

begin
update customerss set salary = salary + 344;
if sql%notfound then
    dbms_output.put_line('no customers selected');
  elsif sql%found then
    customer_numbers := sql%rowcount;
    dbms_output.put_line(customer_numbers || ' = customers selected');

else
    dbms_output.put_line('here is a problem in system!!!');

end if;
end;
/

declare customerss_name varchar(50);

begin
update customerss set name = 'kamran2' where id = 9;
update customerss set name = 'reza2' where id = 2;

if sql%notfound then
    dbms_output.put_line('this id entered is not !!!');
  elsif sql%found then
    customerss_name := sql%rowcount;
    dbms_output.put_line('field of name updated!!!' || ' ' ||
                         'updated name is :' || customerss_name);
else
    dbms_output.put_line('undefind!!!');
end if;
end;
/

declare customerss_age number;

begin
update customerss set age = 75 where id = 9;
update customerss set age = 32 where id = 90;

if sql%notfound then
    dbms_output.put_line('this id entered is not !!!');
  elsif sql%found then
    customerss_age := sql%rowcount;
    dbms_output.put_line('field of age updated!!!' || ' ' ||
                         'updated age is :' || customerss_age);
else
    dbms_output.put_line('undefind!!!');
end if;
end;
/

select * from customerss;

-- 2. explicit cursor

declare

cursor_id      customerss.id%type;
  cursor_age     customerss.age%type;
  cursor_address customerss.address%type;

cursor customerss_cursor is
select id, age, address from customerss;

begin

open customerss_cursor;

loop
fetch customerss_cursor
      into cursor_id, cursor_age, cursor_address;
    exit when customerss_cursor%notfound;
    dbms_output.put_line('the id is ' || cursor_id || ',' || 'the age is ' ||
                         cursor_age || ' , ' || 'the address is ' ||
                         cursor_address);
end loop;
close customerss_cursor;

end;
/







------------------------------------------





-- example for cursor in oracle db



declare
r_height heights%rowtype;

cursor c_hieght( low_height number,high_height number) is
select * from products
where list_height between low_height and high_height;

begin

dbms_output.put_line('the min of height men :');
open c_hieght(100,150);
loop
fetch c_hieght into r_height%rowtype;
exit when c_hieght%notfound;
dbms_output.put_line(r_height.amount_of_height || ':' || r_height.list_height);
end loop;
close c_product;


dbms_output.put_line('the max of height men :');

open c_height(170,200);
loop
fetch c_height into r_height%rowtype;
  exit when c_height%notfound;
  dbms_output.put_line(r_height.amount_of_height || ':' || r_height.list_height);
end loop;
close c_height;



dbms_output.put_line('the min of height woman :');
open c_hieght(120,160);
loop
fetch c_hieght into r_height%rowtype;
exit when c_hieght%notfound;
dbms_output.put_line(r_height.amount_of_height || ':' || r_height.list_height);
end loop;
close c_product;


dbms_output.put_line('the max of height woman :');

open c_height(160,180);
loop
fetch c_height into r_height%rowtype;
  exit when c_height%notfound;
  dbms_output.put_line(r_height.amount_of_height || ':' || r_height.list_height);
end loop;
close c_height;















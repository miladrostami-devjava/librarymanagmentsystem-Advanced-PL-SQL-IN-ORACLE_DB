/*
create package cust_sal as
procedure find_sal(c_id customers.customer_id%type);
end cust_sal;
/
--package created;
create or replace package body cust_sal as
procedure find_sal(c_id customers.customer_id%type) as
  c_adds customers.address%type ;
  begin
    select address into c_adds
    from customers
    where customer_id := c_id;
    dbms_output.put_line('address is ' || c_adds);
    end find_sal;
    end cust_sal;
    /
    -- package body is created
     */


-- create table customerss
create  table customerss (
                             id number,
                             name varchar2(100),
                             age number,
                             address varchar2(200),
                             salary number
);

-- insert into customerss
insert into customerss (id,name,age,address,salary) values (1,'milad',32,'tehran 22',300.23);
insert into customerss (id,name,age,address,salary) values (2,'reza',32,'bandr 22',458.23);
insert into customerss (id,name,age,address,salary) values (3,'amir',32,'yazd 22',854.23);
insert into customerss (id,name,age,address,salary) values (4,'saeeed',32,'astarra 22',988.23);
insert into customerss (id,name,age,address,salary) values (5,'parsa',32,'gom 22',125.23);
insert into customerss (id,name,age,address,salary) values (6,'mina',32,'tehran 22',7895.23);
insert into customerss (id,name,age,address,salary) values (7,'zahra',32,'tabriz 22',400.23);


select * from customerss;


-- update customerss
update customerss set age = 43 where id = 2;
update customerss set age = 22 where id = 3;
update customerss set age = 11 where id = 4;
update customerss set age = 55 where id = 5;
update customerss set age = 36 where id = 6;

-- create package for customerss table

create or replace package p_package as
    -- add new costomerss
    procedure add_customerss(
        c_id customerss.id%type,
        c_name customerss.name%type,
        c_age customerss.age%type,
        c_address customerss.address%type,
        c_salary customerss.salary%type
    );
    -- removes a customerss

    procedure remove_customer(c_id customerss.id%type);

    -- list all customers
    procedure listAllCustomer;
end c_package;
-- package created

-- create package body
create or replace package body c_package as
    add_customerss(
    c_id customerss.id%type,
    c_name customerss.name%type,
    c_age customerss.age%type,
    c_address customerss.address%type,
    c_salary customerss.salary%type
        ) is
begin
insert into customerss (id,name,age,address,salary) values (c_id,c_name,c_age,c_address,c_salary);
end add_customerss;


procedure remove_customer(c_id customerss.id%type) is

begin
delete from customerss
where id = c_id;
end remove_customer;


procedure listAllCustomer is

begin
cursor c_customerss is
select name from customerss ;
type c_list is table of customerss.name%type;
    name_list c_list:= c_list();
    counter integer :=0;
for n in c_customerss loop
            counter := counter + 1;
            name_list.extend;
            name_list(counter) := n.name;
            dbms_output.put_line('Customer (' || counter || ')' || name_list(counter));

end loop;

end listAllCustomer;
end c_package;

-- create packge body.



declare
code customerss.id%type:=8;

begin
    c_package.add_customerss(7,'riana',63,'ahvaz',5455);
    c_package.add_customerss(8,'aliborzoo',55,'mashhad',3000);
    c_package.listAllCustomer;
    c_package.remove_customer(code);
    c_package.listAllCustomer;

end;
/






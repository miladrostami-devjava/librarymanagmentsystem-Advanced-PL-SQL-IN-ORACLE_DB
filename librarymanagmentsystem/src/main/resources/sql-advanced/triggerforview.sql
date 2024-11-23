-- trigger for view in oracle db with instead of trigger
create table departments_douran
(
    department_douran_id       number primary key,
    department_douran_name     varchar2(50),
    department_douran_city     varchar2(50),
    department_douran_date     date,
    department_douran_zip_code varchar2(22)
);

create table employees_douran
(
    employee_douran_id           number primary key,
    employee_douran_name         varchar2(50),
    employee_douran_nationalcode varchar2(55),
    employee_douran_birth_day    date,
    department_douran_id         number,
    employee_douran_hire_date    date,
    employee_douran_unit         varchar2(43),
    foreign key (department_douran_id) references departments_douran (department_douran_id)
);


insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (1, 'java developer', 'tehran', to_date('22-10-2023', 'DD-MM-YYYY'), 'd_2505');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (2, 'INFRA ERP', 'tehran', to_date('13-10-2023', 'DD-MM-YYYY'), 'd_2506');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (3, 'Dev ops unit', 'tehran', to_date('22-08-2023', 'DD-MM-YYYY'), 'd_2506');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (4, 'Jira unit', 'tehran', to_date('25-08-2023', 'DD-MM-YYYY'), 'd_2507');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (5, 'management unit', 'berlin', to_date('22-10-2023', 'DD-MM-YYYY'), 'd_2508');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (6, 'database oracle unit', 'tehran', to_date('22-10-2023', 'DD-MM-YYYY'), 'd_2509');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (7, 'front_end dev', 'tehran', to_date('22-06-2023', 'DD-MM-YYYY'), 'd_2510');
insert into departments_douran(department_douran_id, department_douran_name, department_douran_city,
                               department_douran_date, department_douran_zip_code)
VALUES (8, 'logestic unit', 'tehran', to_date('22-02-2023', 'DD-MM-YYYY'), 'd_2511');

SELECT *
from departments_douran;

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (1, 'milad', '228122324', to_date('04-05-1992', 'mm-dd-yyyy'),
        1, to_date('07-06-2024', 'mm-dd-yyyy'), 'java developer erp');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (2, 'mohamadreza', '0785452545', to_date('04-05-1986', 'mm-dd-yyyy'),
        2, to_date('07-05-2024', 'mm-dd-yyyy'), ' erp unit');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (3, 'reza', '458785224', to_date('04-05-1995', 'mm-dd-yyyy'),
        3, to_date('07-06-2021', 'mm-dd-yyyy'), 'java developer erp');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (4, 'ali', '0256898556', to_date('06-05-1982', 'mm-dd-yyyy'),
        4, to_date('07-06-2000', 'mm-dd-yyyy'), 'java developer erp');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (5, 'hamed', '7855656', to_date('04-09-1965', 'mm-dd-yyyy'),
        5, to_date('07-06-2024', 'mm-dd-yyyy'), 'jira unit');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (6, 'kamran', '98658955', to_date('04-05-1977', 'mm-dd-yyyy'),
        6, to_date('07-06-2010', 'mm-dd-yyyy'), 'dev ops');

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (7, 'jock', '9658254', to_date('04-05-1968', 'mm-dd-yyyy'),
        7, to_date('07-04-2015', 'mm-dd-yyyy'), 'frontend dev');
insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (8, 'farhad', '32548', to_date('04-05-1964', 'mm-dd-yyyy'),
        8, to_date('07-06-2024', 'mm-dd-yyyy'), 'management unit');


SELECT *
from employees_douran;

create or replace view employees_view_departments as
select e.employee_douran_id,
       e.employee_douran_name,
       e.employee_douran_unit,
       e.employee_douran_birth_day,
       d.department_douran_name,
       d.department_douran_city,
       d.department_douran_zip_code
from employees_douran e
         join departments_douran d on e.department_douran_id = d.department_douran_id;

select *
from employees_view_departments;

-- For save the log
create table trigger_douran_logs
(
    trigger_douran_logs_id      number primary key,
    trigger_douran_logs_message varchar2(90),
    trigger_douran_logs_date    date,
    trigger_douran_logs_author  varchar2(45)
);

create sequence trigger_douran_logs_seq
    start with 1
    increment by 1
    nocache;

create or replace trigger trigger_for_view_douran
    instead of delete
on employees_view_departments
    for each row
begin
delete from employees_douran where employee_douran_id = :OLD.employee_douran_id;
end;
/

delete
from employees_douran
where employee_douran_id = 8;
SELECT *
from employees_douran;
select *
from employees_view_departments;


select trigger_name
     , trigger_type
     , triggering_event
     , table_name
     , trigger_body
from USER_TRIGGERS
where TRIGGER_NAME = 'trigger_for_view_douran';

create or replace trigger trigger_del_view_douran_logs
    instead of delete
on employees_view_departments
    for each row
begin
insert into trigger_douran_logs(trigger_douran_logs_id, trigger_douran_logs_message, trigger_douran_logs_date,
                                trigger_douran_logs_author)
VALUES (trigger_douran_logs_seq.nextval,
        'A deletion occurred for employee :' || :OLD.employee_douran_name || '  ' ||
        'in department douran in tehran city is :' || :OLD.department_douran_name,
        SYSDATE, 'System');

delete from employees_douran where employee_douran_id = :OLD.employee_douran_id;
end;
/



select trigger_name
     , trigger_type
     , triggering_event
     , table_name
     , trigger_body
from USER_TRIGGERS
where TRIGGER_NAME = 'trigger_del_view_douran_logs';

delete
from employees_douran
where employee_douran_id = 7;


select trigger_name
     , trigger_type
     , triggering_event
     , table_name
     , trigger_body
from USER_TRIGGERS
where TRIGGER_NAME = 'trigger_del_view_douran_logs';

select *
from trigger_douran_logs;
select * from employees_view_departments;

select * from trigger_douran_logs;


create or replace trigger trig_insert_view_douran
    instead of insert
    on employees_view_departments
    for each row
begin
insert into trigger_douran_logs(trigger_douran_logs_id, trigger_douran_logs_message, trigger_douran_logs_date,
                                trigger_douran_logs_author)
VALUES (trigger_douran_logs_seq.nextval,
        'A insert occurred for employee :' || :OLD.employee_douran_name || '  ' ||
        'in department douran in tehran city is :' || :OLD.department_douran_name,
        SYSDATE, 'System');
end;
/

insert into employees_douran(employee_douran_id, employee_douran_name, employee_douran_nationalcode,
                             employee_douran_birth_day, department_douran_id, employee_douran_hire_date,
                             employee_douran_unit)
VALUES (8, 'farhad', '32548', to_date('04-05-1964', 'mm-dd-yyyy'),
        8, to_date('07-06-2024', 'mm-dd-yyyy'), 'management unit');

select trigger_name
     , trigger_type
     , triggering_event
     , table_name
     , trigger_body
from USER_TRIGGERS
where TRIGGER_NAME = 'trig_insert_view_douran';

select *
from trigger_douran_logs;
select * from employees_view_departments;







create or replace trigger trig_update_view_douran
    instead of update
                          on employees_view_departments
                          for each row
begin
insert into trigger_douran_logs(trigger_douran_logs_id, trigger_douran_logs_message, trigger_douran_logs_date,
                                trigger_douran_logs_author)
VALUES (trigger_douran_logs_seq.nextval,
        'A deletion occurred for employee :' || :OLD.employee_douran_name || '  ' ||
        'in department douran in tehran city is :' || :OLD.department_douran_name,
        SYSDATE, 'System');
end;
/

update employees_douran e set  e.employee_douran_name = 'porahmad'
where e.employee_douran_id = 1;

select * from employees_douran;

select * from trigger_douran_logs;

select * from employees_view_departments;



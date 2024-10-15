
CREATE TABLE employees1
(
    employee_id   NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100),
    hire_date     DATE
);

CREATE TABLE audit_log
(
    log_id      NUMBER PRIMARY KEY,
    log_message VARCHAR2(255),
    log_date    DATE
);

create sequence audit_log_seq
    start with 1
    increment by 1
    nocache ;




create or replace trigger trigger_for_employees_rostami
    after insert on employees
    for each row
begin
insert into audit_log(log_id, log_message, log_date)
values (audit_log_seq.nextval,'a new employee was added :' || :NEW.employee_name ,sysdate);
end;
/



create or replace trigger trigger_for_employees1_rostami
    after insert on employees1
    for each row
begin
insert into audit_log(log_id, log_message, log_date)
values (audit_log_seq.nextval,'a new employee was added :' || :NEW.employee_name ,sysdate);
end;
/





SELECT trigger_name, status
FROM user_triggers
WHERE trigger_name = 'TRIGGER_FOR_EMPLOYEES_ROSTAMI';


SELECT trigger_name, status
FROM user_triggers
WHERE trigger_name = 'TRIGGER_FOR_EMPLOYEES1_ROSTAMI';




insert into employees1(employee_id, employee_name, hire_date) VALUES (1,'milad',sysdate);

INSERT INTO employees1(employee_id, employee_name, hire_date)
VALUES (2, 'Armin', SYSDATE);


INSERT INTO employees1(employee_id, employee_name, hire_date)
VALUES (4, 'Sara', to_date('14-03-5555','DD-MM-YYYY'));




SELECT * FROM audit_log;





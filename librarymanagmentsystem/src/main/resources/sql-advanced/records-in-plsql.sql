


-- Records in PL/SQL IN ORACLE DB


--1. Table Based with use the %rowtype

select * from customerss;


declare
customer_para customerss%rowtype;

begin

select id,name,age,address ,salary into customer_para from customerss where id = 4;
dbms_output.put_line('the id :' || customer_para.id);
dbms_output.put_line('the name :' || customer_para.name);

dbms_output.put_line('the age :' || customer_para.age);

dbms_output.put_line('the address :' || customer_para.address);
dbms_output.put_line('the salary :' || customer_para.address);



end;
/






-- 2. cursor based :

declare
cursor customer_cursor is
select id,name , age from customerss;

type customer_rec_type is record (

id customerss.id%type,
name customerss.name%type,
age customerss.age%type
);

customer_rec customer_rec_type;
begin
open customer_cursor;
loop
fetch customer_cursor into customer_rec ;

exit when customer_cursor%notfound;
dbms_output.put_line('the id :' || customer_rec.id);
dbms_output.put_line('the salary :' || customer_rec.name);
dbms_output.put_line('the salary :' || customer_rec.age);

end loop;
close customer_cursor;

end;
/


-- 3.User defind method


declare

type person is record (

name varchar2(44),
age number,
id number,
location varchar2(34),
married char(1)
);

person1 person;
person2 person;

begin
 dbms_output.put_line('the id for person1 :' || person1.id);

 dbms_output.put_line('the married status for person2 :' || person2.married);


end;
/



-- example :


DECLARE type books is record
(title varchar(50),
author varchar(50),
subject varchar(100),
book_id number);
book1 books;
book2 books;
PROCEDURE printbook (book books) IS
BEGIN
dbms_output.put_line ('Book title : ' || book.title);
dbms_output.put_line('Book author : ' || book.author);
dbms_output.put_line( 'Book subject : ' || book.subject);
dbms_output.put_line( 'Book book_id : ' || book.book_id);

END;
BEGIN
-- Book 1 specification
book1.title := 'C Programming';
book1.author := 'Nuha Ali ';
book1.subject := 'C Programming Tutorial';
book1.book_id := 6495407;
-- Book 2 specification
book2.title := 'Telecom Billing';
book2.author := 'Zara Ali';
book2.subject := 'Telecom Billing Tutorial';
book2.book_id := 6495700;
-- Use procedure to print book info
printbook(book1); printbook(book2);
END;
/















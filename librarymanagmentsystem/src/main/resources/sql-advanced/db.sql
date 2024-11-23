-- step1:
--create tablespace library_tbs
create tablespace library_tbs
    datafile 'C:\Users\Parse\Desktop\MiladTask\JavaCoreTask\LibraryManagementSystem-OracleDB-project-Advanced\librarymanagmentsystem\src\main\resources\db_oracle_library_1\library_management_system_oracle_1.dbf'
    size 3m
    autoextend on next 2m maxsize unlimited
    segment space management manual
    extent management local;
-- additional datafiles can be added separately
alter tablespace library_tbs
    add datafile 'C:\Users\Parse\Desktop\MiladTask\JavaCoreTask\LibraryManagementSystem-OracleDB-project-Advanced\librarymanagmentsystem\src\main\resources\db_oracle_library-2\library_management_system_oracle_2.dbf'
    size 3m
    autoextend on next 2m maxsize unlimited;
-- additional datafiles can be added separately
alter tablespace library_tbs
    add datafile 'C:\Users\Parse\Desktop\MiladTask\JavaCoreTask\LibraryManagementSystem-OracleDB-project-Advanced\librarymanagmentsystem\src\main\resources\db_oracle_library_3\library_management_system_oracle_3.dbf'
    size 3m
    autoextend on next 2m maxsize unlimited;



-- step2:
--create user library_user_armin
create user library_user_armin
    identified by Milad13711992
    default tablespace library_tbs
    quota unlimited on library_tbs;

-- step3:
-- to give access to user : library_user_armin
grant connect, resource to library_user_armin;
grant create user to library_user_armin;
grant create session to library_user_armin;
grant create cube to library_user_armin;
grant create view to library_user_armin;
grant create job to library_user_armin;
grant create role to library_user_armin;
grant create any cluster to library_user_armin;
grant create any context to library_user_armin;
grant create any cube build process to library_user_armin;
grant create any dimension to library_user_armin;
grant create any directory to library_user_armin;
grant create any edition to library_user_armin;
grant create any index to library_user_armin;
grant create any indextype to library_user_armin;
grant create any cube build process to library_user_armin;
grant create any library to library_user_armin;
grant create any operator to library_user_armin;
grant create any sql profile to library_user_armin;
grant create procedure to library_user_armin;
grant create table to library_user_armin;
grant drop user to library_user_armin;
grant delete any table to library_user_armin;


-- create func :
create function func_check_authentication(
    username in varchar2(30),
    password in varchar2(34),
    oldPassword in varchar2(30)
)
    return boolean
        is
           has_upper              boolean      := false;
has_lower              boolean      := false;
    has_digit              boolean      := false;
    has_special            boolean      := false;
    special_chars CONSTANT varchar2(20) := '!@#$%^&*()_+<>|?~,.()[]{}';

begin

    -- review upper case
for i in 1..length(password)
        loop
            if substr(password, i, 1) between 'A' and 'Z' then
                has_upper := true;
            elsif substr(password, i, 1) between 'a' and 'z' then
                has_lower := true;
            elsif substr(password, i, 1) between '0' and '9' then
                has_digit := true;
            elsif instr(password, substr(password, i, 1)) > 0 then
                has_special := true;
end if;
end loop;

    --review password condition
    if has_upper and has_lower and has_digit and has_special then
        return true; -- the password is valid
else
        raise_application_error(20001,
                                'application should be upper case and lower case and digit and special ,this password is valid!!!');
end if;

--  Return false as a fallback if no conditions are met (this line will never be reached)
return false;

end func_check_authentication;
/



-- step4:
--create Profile for user library_user_armin
create profile profile_library_user_armin limit
    password_life_time 35
    password_grace_time 22
    failed_login_attempts 12
    password_lock_time 16
    sessions_per_user 3
    password_reuse_time 187
    password_reuse_max 20
    --password_verify_function func_check_authentication
    composite_limit 1000
    private_sga unlimited
    cpu_per_session 20
    connect_time 5
    idle_time 6
    logical_reads_per_session 10000
    logical_reads_per_call 4000;
alter user library_user_armin profile profile_library_user_armin;


-- step5:
--create tables in oracle db
create table Library_Users
(
    Library_Users_Id              NUMBER PRIMARY KEY,
    Library_Users_Username        VARCHAR2(100),
    Library_Users_Email           VARCHAR2(100),
    Library_Users_Membership_date DATE
);

CREATE TABLE Library_Genres
(
    Library_Genres_Id   NUMBER PRIMARY KEY,
    Library_Genres_Name VARCHAR2(50)
);

CREATE TABLE Library_Authors
(
    Library_Authors_Id        NUMBER PRIMARY KEY,
    Library_Authors_Name      VARCHAR2(100),
    Library_Authors_Birthdate DATE
);

CREATE TABLE Library_Books
(
    Library_Books_Id             NUMBER PRIMARY KEY,
    Library_Books_Title          VARCHAR2(150),
    Library_Books_Author_Id      NUMBER,
    Library_Books_Published_Year NUMBER(4),
    Library_Books_Genre_Id       NUMBER,
    Library_Authors_Id           int not null,
    Library_Genres_Id            int not null,
    FOREIGN KEY (Library_Authors_Id) REFERENCES Library_Authors (Library_Authors_Id),
    FOREIGN KEY (Library_Genres_Id) REFERENCES Library_Genres (Library_Genres_Id)
);

CREATE TABLE Library_Borrowing_Transactions
(
    Library_B_Transactions_Id NUMBER PRIMARY KEY,
    Library_Users_Id          NUMBER,
    Library_Books_Id          NUMBER,
    Library_B_Trans_B_Date    DATE,
    Library_B_Trans_R_Date    DATE,
    FOREIGN KEY (Library_Users_Id) REFERENCES Library_Users (Library_Users_Id),
    FOREIGN KEY (Library_Books_Id) REFERENCES Library_Books (Library_Books_Id)
);



-- step6:
-- insert into tables

--INSERT INTO Library_Users
INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (1, 'milad123', 'milad@example.com', TO_DATE('2022-01-15', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (2, 'armin456', 'armin@example.com', TO_DATE('2022-02-10', 'YYYY-MM-DD'));
INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (3, 'johnsmith', 'johnsmith@example.com', TO_DATE('2022-03-01', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (4, 'sarahjones', 'sarahjones@example.com', TO_DATE('2022-03-15', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (5, 'mikebrown', 'mikebrown@example.com', TO_DATE('2022-04-01', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (6, 'emilyclark', 'emilyclark@example.com', TO_DATE('2022-04-15', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (7, 'alexjohnson', 'alexjohnson@example.com', TO_DATE('2022-05-01', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (8, 'laurawhite', 'laurawhite@example.com', TO_DATE('2022-05-15', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (9, 'robertgreen', 'robertgreen@example.com', TO_DATE('2022-06-01', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (10, 'karenlee', 'karenlee@example.com', TO_DATE('2022-06-15', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (11, 'davidkim', 'davidkim@example.com', TO_DATE('2022-07-01', 'YYYY-MM-DD'));

INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (12, 'nataliesmith', 'nataliesmith@example.com', TO_DATE('2022-07-15', 'YYYY-MM-DD'));


--INSERT INTO Library_Genres
INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (1, 'Fiction');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (2, 'Non-Fiction');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (3, 'Science Fiction');
INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (4, 'Fantasy');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (5, 'Mystery');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (6, 'Historical Fiction');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (7, 'Biography');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (8, 'Self-Help');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (9, 'Thriller');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (10, 'Romance');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (11, 'Children');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (12, 'Cookbooks');

INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (13, 'Poetry');


--INSERT INTO Library_Authors

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (1, 'George Orwell', TO_DATE('1903-06-25', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (2, 'Isaac Asimov', TO_DATE('1920-01-02', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (3, 'Agatha Christie', TO_DATE('1890-09-15', 'YYYY-MM-DD'));
INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (4, 'J.K. Rowling', TO_DATE('1965-07-31', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (5, 'Agatha Christie', TO_DATE('1890-09-15', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (6, 'Mark Twain', TO_DATE('1835-11-30', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (7, 'Jane Austen', TO_DATE('1775-12-16', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (8, 'F. Scott Fitzgerald', TO_DATE('1896-09-24', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (9, 'Harper Lee', TO_DATE('1926-04-28', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (10, 'Stephen King', TO_DATE('1947-09-21', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (11, 'C.S. Lewis', TO_DATE('1898-11-29', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (12, 'George R.R. Martin', TO_DATE('1948-09-20', 'YYYY-MM-DD'));

INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (13, 'Toni Morrison', TO_DATE('1931-02-18', 'YYYY-MM-DD'));


--INSERT INTO Library_Books
INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (1, '1984', 1, 1949, 3, 1, 1);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (2, 'Foundation', 2, 1951, 3, 2, 3);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (3, 'Murder on the Orient Express', 3, 1934, 1, 3, 1);
INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (4, 'Harry Potter and the Sorcerer''s Stone', 4, 1997, 6, 4, 6);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (5, 'The Shining', 5, 1977, 10, 5, 10);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (6, 'The Lord of the Rings', 6, 1954, 6, 6, 6);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (7, 'Pride and Prejudice', 7, 1813, 5, 7, 5);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (8, 'Adventures of Huckleberry Finn', 8, 1884, 13, 8, 13);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (9, 'The Old Man and the Sea', 9, 1952, 9, 9, 9);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (10, 'A Tale of Two Cities', 10, 1859, 9, 10, 9);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (11, 'War and Peace', 11, 1869, 9, 11, 9);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (12, 'The Great Gatsby', 12, 1925, 9, 12, 9);

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (13, 'To Kill a Mockingbird', 13, 1960, 9, 13, 9);


-- INSERT INTO Library_Borrowing_Transactions
INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (1, 1, 1, TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2022-03-15', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (2, 2, 2, TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2022-04-15', 'YYYY-MM-DD'));
INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (3, 3, 4, TO_DATE('2023-01-05', 'YYYY-MM-DD'), TO_DATE('2023-01-20', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (4, 4, 5, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2023-02-25', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (5, 5, 6, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2023-03-30', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (6, 6, 7, TO_DATE('2023-04-20', 'YYYY-MM-DD'), TO_DATE('2023-05-05', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (7, 7, 8, TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-10', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (8, 8, 9, TO_DATE('2023-06-30', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (9, 9, 10, TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-07-30', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (10, 10, 11, TO_DATE('2023-08-10', 'YYYY-MM-DD'), TO_DATE('2023-08-25', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (11, 11, 12, TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'));

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (12, 12, 13, TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'));

select *
from Library_Borrowing_Transactions;
select *
from Library_Borrowing_Transactions;


--step7:
-- create sequences for tables
create sequence seq_library_users start with 1 increment by 1 nocache nocycle;
create sequence seq_library_books start with 1 increment by 1 nocache nocycle;
create sequence seq_library_borrowing_trans start with 1 increment by 1 nocache nocycle;
create sequence seq_library_genres start with 1 increment by 1 nocache nocycle;
create sequence seq_library_authors start with 1 increment by 1 nocache nocycle;

--step8:
-- use from sequences for tables

select seq_library_users.currval from dual;
alter sequence seq_library_users increment by 1;
declare
max_id number;
    curr_val number;
begin
select max(Library_Users_Id) into max_id from Library_Users;
select seq_library_users.nextval into curr_val from dual;

if curr_val < max_id then
        execute immediate 'alter sequence seq_library_users increment by ' || (max_id - curr_val + 1);
select seq_library_users.nextval into curr_val from dual;
execute immediate 'alter sequence seq_library_users increment by ' || (1);
end if;
end;
/


INSERT INTO Library_Users (Library_Users_Id, Library_Users_Username, Library_Users_Email, Library_Users_Membership_date)
VALUES (seq_library_users.nextval, 'milad123', 'milad@example.com', TO_DATE('2022-01-15', 'YYYY-MM-DD'));


alter sequence seq_library_genres increment by 1;

declare
max_id number;
    curr_val number;
begin
select max(Library_Genres_Id) into max_id from Library_Genres;
select seq_library_genres.nextval into curr_val from dual;

if curr_val < max_id then
        execute immediate 'alter sequence seq_library_genres increment by ' || (max_id - curr_val + 1);
select seq_library_users.nextval into curr_val from dual;
execute immediate 'alter sequence seq_library_genres increment by ' || (1);
end if;
end;
/
INSERT INTO Library_Genres (Library_Genres_Id, Library_Genres_Name)
VALUES (seq_library_genres.nextval, 'Poetry');


INSERT INTO Library_Authors (Library_Authors_Id, Library_Authors_Name, Library_Authors_Birthdate)
VALUES (seq_library_authors.nextval, 'George Orwell', TO_DATE('1903-06-25', 'YYYY-MM-DD'));

INSERT INTO Library_Books (Library_Books_Id, Library_Books_Title, Library_Books_Author_Id, Library_Books_Published_Year,
                           Library_Books_Genre_Id, Library_Authors_Id, Library_Genres_Id)
VALUES (seq_library_books.nextval, '1984', 1, 1949, 3, 1, 1);

INSERT INTO Library_Borrowing_Transactions (Library_B_Transactions_Id, Library_Users_Id, Library_Books_Id,
                                            Library_B_Trans_B_Date, Library_B_Trans_R_Date)
VALUES (seq_library_borrowing_trans.nextval, 12, 13, TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'));

-- step9:
--create packages in project library_management system:
-- use is instead of as
create or replace procedure add_user(
    p_username varchar2,
    p_email varchar2
) is
    new_user_id number;
begin
savepoint before_insert;
begin
        new_user_id := SEQ_LIBRARY_USERS.nextval;
insert into LIBRARY_USERS (LIBRARY_USERS_ID, LIBRARY_USERS_USERNAME, LIBRARY_USERS_EMAIL,
                           LIBRARY_USERS_MEMBERSHIP_DATE)
VALUES (new_user_id,p_username,p_email,sysdate);
exception
    when APEX_UI_DEFAULT_UPDATE THEN
        rollback to before_insert;
        raise_application_error(-2000,'Duplicate user id ');
when SDO_PREFERRED_OPS_USER then
        raise_application_error(2000,'this is problem');
when WWV_FLOW_HELP then
        raise_application_error(3000,'problem is very ...');
end;
commit ;
end;

    -- use as instead of is

create or replace procedure add_user2(
    p_username varchar2,
    p_email varchar2
) as
    new_user_id number;
begin
savepoint before_insert;
begin
        new_user_id := SEQ_LIBRARY_USERS.nextval;
insert into LIBRARY_USERS (LIBRARY_USERS_ID, LIBRARY_USERS_USERNAME, LIBRARY_USERS_EMAIL,
                           LIBRARY_USERS_MEMBERSHIP_DATE)
VALUES (new_user_id,p_username,p_email,sysdate);
exception
        when APEX_UI_DEFAULT_UPDATE THEN
            rollback to before_insert;
            raise_application_error(-2000,'Duplicate user id ');
when SDO_PREFERRED_OPS_USER then
            raise_application_error(2000,'this is problem');
when WWV_FLOW_HELP then
            raise_application_error(3000,'problem is very ...');
end;
commit ;
end;

    -- define procedure for delete user by id
    create or replace procedure delete_user_by_id(
        p_user_id number
        ) is
begin
delete from LIBRARY_USERS where p_user_id:= LIBRARY_USERS_ID;
commit ;

exception
    when no_data_found then
        raise_application_error(30000,'not found data for this id!!!!');
end;

        -- define function for count borrowed book by user
        create or replace function borrowed_user_book(
            p_user_id number
        ) return number is
        borrowed_count number;
begin
select count(*)
into borrowed_count
from LIBRARY_BORROWING_TRANSACTIONS bt
where LIBRARY_USERS_ID := bt.LIBRARY_B_TRANSACTIONS_ID ;
return borrowed_count;
exception
            when ST_ANNOTATION_TEXT then
                return (0);
end borrowed_user_book;

-- define procedure for delete user by id
create or replace procedure delete_user_by_id(
    p_user_id number
) is
begin
delete from LIBRARY_USERS where p_user_id := LIBRARY_USERS_ID;
commit;

exception
    when no_data_found then
        raise_application_error(30000, 'not found data for this id!!!!');
end;

-- define function for count borrowed book by user
create or replace function borrowed_user_book(
    p_user_id number
) return number is
    borrowed_count number;
begin
select count(*)
into borrowed_count
from LIBRARY_BORROWING_TRANSACTIONS bt
where LIBRARY_USERS_ID := bt.LIBRARY_B_TRANSACTIONS_ID;
return borrowed_count;
exception
    when ST_ANNOTATION_TEXT then
        return (0);
end borrowed_user_book;


-- object 2 : bookManagement

-- add new book
create or replace procedure add_book(
    p_title in varchar2,
    p_auther_id in number,
    p_published_year in number,
    p_genre_id in number
) is
    new_book_id number;
begin
    new_book_id := SEQ_LIBRARY_BOOKS.nextval;
insert into LIBRARY_BOOKS (LIBRARY_BOOKS_ID, LIBRARY_BOOKS_TITLE, LIBRARY_BOOKS_AUTHOR_ID,
                           LIBRARY_BOOKS_PUBLISHED_YEAR, LIBRARY_BOOKS_GENRE_ID, LIBRARY_AUTHORS_ID,
                           LIBRARY_GENRES_ID)
VALUES (new_book_id, p_title, p_auther_id, p_published_year, p_genre_id);
commit;
end;

-- update book
create or replace procedure update_book(
    p_book_id IN NUMBER,
    p_title IN VARCHAR2,
    p_published_year IN NUMBER
) is
begin
update
    LIBRARY_BOOKS
set LIBRARY_BOOKS_TITLE          = p_title,
    LIBRARY_BOOKS_PUBLISHED_YEAR = p_published_year
where LIBRARY_BOOKS_ID = p_book_id;
if sql%rowcount = 0 then
        raise_application_error(234, 'book not found!!!');
end if;
commit;
end;

-- object 3 : TransactionManagement

-- register borrow book transaction
CREATE OR REPLACE PROCEDURE borrow_book(
    p_user_id IN NUMBER,
    p_book_id IN NUMBER
) IS
    new_transaction_id NUMBER;
begin
    new_transaction_id := SEQ_LIBRARY_BORROWING_TRANS.nextval;
insert into LIBRARY_BORROWING_TRANSACTIONS(LIBRARY_B_TRANSACTIONS_ID, LIBRARY_USERS_ID, LIBRARY_BOOKS_ID,
                                           LIBRARY_B_TRANS_B_DATE, LIBRARY_B_TRANS_R_DATE)
VALUES (new_transaction_id, p_user_id, p_book_id, sysdate);
commit;
end;

-- updating return book
CREATE OR REPLACE PROCEDURE return_book(
    p_transaction_id IN NUMBER
) IS
BEGIN
update LIBRARY_BORROWING_TRANSACTIONS
set LIBRARY_B_TRANS_R_DATE = sysdate
where LIBRARY_B_TRANSACTIONS_ID = p_transaction_id;
if sql%rowcount = 0 then
        raise_application_error(3443, 'Transaction not found');
end if;
commit;
end;

-- review checking the borrowed books
create or replace function check_borrow_book(
    p_user_id number
) return varchar2 is
    v_book_id       number;
    borrowed_status varchar2(1000) := '';
begin
for rec in (select LIBRARY_B_TRANSACTIONS_ID
                from LIBRARY_BORROWING_TRANSACTIONS
                where LIBRARY_USERS_ID = p_user_id
                  and return_book(LIBRARY_BOOKS_ID) is null )
        loop
            borrowed_status :=
                    borrowed_status || 'Book ID :' || rec.LIBRARY_B_TRANSACTIONS_ID || 'is not returned yet!' ||
                    chr(10);
end loop;
    if borrowed_status is null then
        return 'All books returned.';
else
        return borrowed_status;
end if;

end;

-- trigger for before insert users in library
create or replace trigger trg_insert_library_users
before insert on LIBRARY_USERS
for each row

begin
    if :NEW.library_users_id is null then
select SEQ_LIBRARY_USERS.nextval
into :NEW.library_users_id
from dual;
end if;
end;


create or replace trigger trg_alarm_register
after insert on LIBRARY_USERS
for each row
begin
    if :NEW.library_users_id > 323  then
raise_application_error(444,'the insert not ok');
else
        raise_application_error(234,'the insert is ok');
end if;
end;


create or replace trigger trg_before_update_users
before update on LIBRARY_USERS
                  for each row
begin
    if :OLD.LIBRARY_USERS_EMAIL <> :NEW.LIBRARY_USERS_EMAIL then
        DBMS_OUTPUT.PUT_LINE('Email changed from :' || OLD.LIBRARY_USERS_EMAIL || 'to :' || NEW.LIBRARY_USERS_EMAIL);
end if;
end;

CREATE OR REPLACE TRIGGER trg_before_delete_user
    BEFORE DELETE ON Library_Users
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Deleting user :'|| :OLD.LIBRARY_USERS_USERNAME);
end;







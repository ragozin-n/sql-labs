CREATE TABLE R1(fullname char(20), office_num integer, account_num integer primary key, remains integer, credit integer);
CREATE TABLE R2(office_num integer primary key, district char(20));

insert into R1 values ("Иван Иванов", 66, 20, 0, 10000);
insert into R1 values ("Петр Петров", 77, 30, 0, 10000);
insert into R1 values ("Иван Иванов", 77, 40, 0, 10000);
insert into R1 values ("Петр Петров", 66, 50, 0, 10000);
insert into R2 values (66, "ВИЗ");
insert into R2 values (77, "ЖБИ");

SELECT fullname FROM R1 GROUP BY fullname HAVING COUNT(DISTINCT office_num ) = (SELECT COUNT(DISTINCT office_num) FROM R2);
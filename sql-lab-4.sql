-- Тема 1: Работа с базой данных в SQL SERVER
-- Задание 1:
CREATE SCHEMA EDUCATION AUTHORIZATION lab4_user; 

CREATE TABLE EDUCATION.STUDENTS (SNUM INTEGER PRIMARY KEY, SFAM varchar(20), SIMA varchar(10), SOTCH varchar(15), STIP SMALLINT);
CREATE TABLE EDUCATION.PREDMET (PNUM SMALLINT PRIMARY KEY, PNAME char(20), TNUM INTEGER REFERENCES EDUCATION.TEACHERS(TNUM), HOURS SMALLINT, COURS SMALLINT CHECK (COURS < 6 AND COURS > 1));
CREATE TABLE EDUCATION.TEACHERS (TNUM INTEGER PRIMARY KEY, TFAM char(20), TIMA char(10), TOTCH char(15), TDATE DATE);
CREATE TABLE EDUCATION.USP (UNUM INTEGER PRIMARY KEY, OCENKA SMALLINT, UDATE TIMESTAMP, SNUM INTEGER REFERENCES EDUCATION.STUDENTS(SNUM), PNUM SMALLINT REFERENCES EDUCATION.PREDMET(PNUM));
-- '2004-01-01 00:00:00' -- Timestamp example

-- Задание 2 (интерактивный ввод): делается визуально
-- Задание 3 (пользовательский тип данных): CREATE TYPE studentType AS ENUM ('бюджетник', 'контрактник'); Документация: (https://www.postgresql.org/docs/9.2/static/sql-createtype.html)
-- ----------------------------------------------

-- Вторая тема: Резервирование баз данных и журналов транзакциий в SQL SERVER
-- Задание 4: 
-- pg_dump name > path_to_dump
-- Задание 5:
-- psql lab4_db_dump < sql_dump.sql
-- DROP DATABASE lab4_db_dump;
-- ----------------------------------------------

-- Третья тема: Использование диаграмм для графического представления структуры базы данных
-- Задание 6 (создать таблицу USP): Выполнено (pgmodeler)
-- Задание 7 (визуализация): Сделано
-- ----------------------------------------------

-- Четвертая тема: Представления в SQL Server
-- Задание 8:
-- Опечатка в задании (TRAM вместо TFAM)
CREATE VIEW TeacherFIO AS SELECT TFAM, TIMA, TOTCH FROM EDUCATION.TEACHER;
CREATE VIEW PredmetInfo AS SELECT PNAME, HOURS FROM EDUCATION.PREDMET;
CREATE VIEW USPInfo AS SELECT OCENKA, UDATE FROM EDUCATION.USP;
CREATE VIEW StudentInfo AS SELECT SFAM, SIMA, SOTCH FROM EDUCATION.STUDENTS;
-- ----------------------------------------------

-- Пятая тема: Индексы в SQL Server
-- Задание 9: Выполнено (Ключ не является индексом, а реализуется через индекс. Помимо этого у ключа масса иных свойств (например - поле, входящее в первичный ключ, не может быть NULL).)
-- ----------------------------------------------

-- Шестая тема: Ключи в SQL Server
-- Задание 10 (первичные и внешние ключи): Выполнено 
-- ----------------------------------------------

-- Седьмая тема: ЦЕЛОСТНОСТЬ ДАННЫХ SQL SERVER. Использование ограничений в SQL-совместимых базах данных
-- Задание 11: операторы ограничения целостности CHECK, NOT NULL, UNIQUE Документация: (http://postgresql.ru.net/manual/ddl-constraints.html)
-- ----------------------------------------------
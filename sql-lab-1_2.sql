SELECT 'Вариант #8';
Create table R1 (area char(25) not NULL,
					roomCount smallint, 
					square smallint,
					floor smallint);

INSERT INTO R1 VALUES ('Центр',1,15,3);
INSERT INTO R1 VALUES ('Центр',2,27,1);
INSERT INTO R1 VALUES ('Центр',3,40,5);
INSERT INTO R1 VALUES ('Уралмаш',1,15,1);
INSERT INTO R1 VALUES ('Уралмаш',2,27,5);
INSERT INTO R1 VALUES ('Эльмаш',1,15,1);
INSERT INTO R1 VALUES ('Эльмаш',3,45,1);
INSERT INTO R1 VALUES ('Юго-западный',2,29,5);
INSERT INTO R1 VALUES ('Юго-западный',3,40,5);

Create table R2 (area char(25) not NULL,
					roomCount smallint, 
					square smallint,
					floor smallint);

INSERT INTO R2 VALUES ('Центр',1,15,3);
INSERT INTO R2 VALUES ('Центр',2,27,1);
INSERT INTO R2 VALUES ('Центр',3,40,5);
INSERT INTO R2 VALUES ('Уралмаш',3,40,2);
INSERT INTO R2 VALUES ('Химмаш',2,30,3);
INSERT INTO R2 VALUES ('Эльмаш',3,45,1);
INSERT INTO R2 VALUES ('Юго-западный',2,29,5);
INSERT INTO R2 VALUES ('Юго-западный',3,40,5);

SELECT 'Объединение:';
SELECT * FROM R1 UNION ALL SELECT * FROM R2;
SELECT '';

SELECT 'Пересечение:';
SELECT * FROM R1,R2 WHERE R1.area=R2.area AND R1.roomCount=R2.roomCount AND R1.square=R2.square AND R1.floor=R2.floor;
SELECT '';

SELECT 'Разность_R1-R2:';
SELECT * FROM R1 WHERE NOT EXISTS (SELECT * FROM R2 WHERE R1.area=R2.area AND R1.roomCount=R2.roomCount AND R1.square=R2.square AND R1.floor=R2.floor);
SELECT '';

SELECT 'Разность_R2-R1:';
SELECT * FROM R2 WHERE NOT EXISTS (SELECT * FROM R1 WHERE R1.area=R2.area AND R1.roomCount=R2.roomCount AND R1.square=R2.square AND R1.floor=R2.floor);
SELECT '';

SELECT 'Расширенное декартово произведение:';
SELECT * FROM R1, R2;
SELECT '';

CREATE TABLE R12 (data date NOT NULL,
					tel char(11), 
					town char(25),
					callTime smallint,
					cost smallint);

CREATE TABLE R22 (name char(25) NOT NULL,
					tel smallint);

INSERT INTO R12 VALUES ('2016-01-01','89009001111','Екатеринбург',24,50);
INSERT INTO R12 VALUES ('2016-01-01','89009001112','Москва',24,50);
INSERT INTO R12 VALUES ('2016-01-01','89009001111','Екатеринбург',24,50);
INSERT INTO R12 VALUES ('2016-01-01','89009001111','Екатеринбург',24,50);
INSERT INTO R12 VALUES ('2016-01-01','89009001177','Калининград',24,50);
INSERT INTO R12 VALUES ('2016-01-01','89009001188','Калининград',24,50);

INSERT INTO R22 VALUES ('Иван','89009001112');
INSERT INTO R22 VALUES ('Петр','89009001111');
INSERT INTO R22 VALUES ('Виктор','89009001113');
INSERT INTO R22 VALUES ('Евгений','89009001114');

SELECT 'Составить программу, которая, используя 
операции реляционной алгебры, 
определяет фамилии клиентов, производивших 
телефонные звонки в город с заданным названием.
';
SELECT DISTINCT R22.name FROM R22 WHERE R22.tel IN (SELECT R12.tel FROM R12 WHERE R12.town='Екатеринбург');
SELECT '';

SELECT 'INNER JOIN:';
SELECT * FROM R12 INNER JOIN R22 ON R12.tel=R22.tel;
SELECT '';

SELECT 'FULL JOIN:';
SELECT * FROM R12 FULL JOIN R22 ON R12.tel=R22.tel;
SELECT '';

SELECT 'LEFT JOIN:';
SELECT * FROM R12 LEFT JOIN R22 ON R12.tel=R22.tel;
SELECT '';

SELECT 'RIGHT JOIN:';
SELECT * FROM R12 RIGHT JOIN R22 ON R12.tel=R22.tel;
SELECT '';

--'6 вариант 2 лабораторной';

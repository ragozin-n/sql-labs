create table clients (name char(20) not NULL, address char(20) not NULL, id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL);

create table accounts_history (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, _from INTEGER, _where INTEGER not NULL, _type char(20) not NULL, _date DATE not NULL, _method char(20) not NULL, _amount INTEGER not NULL);

create table account (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, isAlive boolean NOT NULL, balance INTEGER, open_date DATE NOT NULL, last_modify DATE);

create table bank (client_id INTEGER not NULL, account_id INTEGER not NULL);

/*Триггеры*/
CREATE TRIGGER last_modify_trigger AFTER UPDATE ON account
BEGIN
update account SET last_modify = CURRENT_DATE WHERE account.id = NEW.id;
END;

CREATE TRIGGER last_modify_history_trigger AFTER UPDATE ON accounts_history
BEGIN
update account SET last_modify = CURRENT_TIME WHERE account.id = NEW.id;
END;

CREATE TRIGGER update_balance AFTER INSERT ON accounts_history
BEGIN
update account SET balance = balance + NEW._amount WHERE account.id = NEW._where;
update account SET balance = balance - NEW._amount WHERE account.id = NEW._from;
END;
/*-----------------------------------*/


insert into clients values ("Иван Петрович", "ул. Пушкина, д. 27", NULL);
insert into clients values ("Георгий Николаевич", "ул. Ломоносова, д. 35", NULL);
insert into clients values ("Степан Викторович", "ул. Ленина, д. 33", NULL);


insert into account values (NULL, 1, 300, CURRENT_DATE,NULL);
insert into account values (NULL, 1, 500, DATE(strftime('%s', '2016-10-01 00:00:00') + abs(random() % (strftime('%s', '2016-10-30 23:59:59') - strftime('%s', '2016-10-01 00:00:00'))),'unixepoch'), NULL);
insert into account values (NULL, 1, 10010, DATE(strftime('%s', '2016-10-01 00:00:00') + abs(random() % (strftime('%s', '2016-10-30 23:59:59') - strftime('%s', '2016-10-01 00:00:00'))),'unixepoch'), NULL);
insert into account values (NULL, 1, 5000000, DATE(strftime('%s', '2002-10-01 00:00:00') + abs(random() % (strftime('%s', '2002-10-30 23:59:59') - strftime('%s', '2002-10-01 00:00:00'))),'unixepoch'), NULL);

insert into bank values (1,1);
insert into bank values (1,2);
insert into bank values (3,2);
insert into bank values (2,3);
insert into bank values (3,4);


insert into accounts_history values (null, null, 1, "Пополнение", "2004-02-01", "Онлайн-банк", 10000);
insert into accounts_history values (null, null, 1, "Пополнение", "2004-01-04", "Онлайн-банк", 10000);
insert into accounts_history values (null, null, 2, "Пополнение", "2004-01-01", "Онлайн-банк", 10000);
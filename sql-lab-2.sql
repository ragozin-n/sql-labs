CREATE TABLE providers (n_post char(6) not NULL,
					name char(20), 
					rating smallint,
					town char(20));

INSERT INTO providers VALUES ('S1', 'Смит', 20, 'Лондон');
INSERT INTO providers VALUES ('S2', 'Джонс', 10, 'Париж');
INSERT INTO providers VALUES ('S3', 'Блейк', 30, 'Париж');
INSERT INTO providers VALUES ('S4', 'Кларк', 20, 'Лондон');
INSERT INTO providers VALUES ('S5', 'Адамс', 30, 'Афины');

CREATE TABLE components (n_det char(6) not NULL,
					name char(20),
					color char(20),
					weight smallint,
					town char(20));

INSERT INTO components VALUES ('P1', 'Гайка', 'Красный', 12, 'Лондон');
INSERT INTO components VALUES ('P2', 'Болт', 'Зеленый', 17, 'Париж');
INSERT INTO components VALUES ('P3', 'Винт', 'Голубой', 17, 'Рим');
INSERT INTO components VALUES ('P4', 'Винт', 'Красный', 14, 'Лондон');
INSERT INTO components VALUES ('P5', 'Кулачок', 'Голубой', 12, 'Париж');
INSERT INTO components VALUES ('P6', 'Блюм', 'Красный', 19, 'Лондон');

CREATE TABLE products (n_product char(6) not NULL,
					name char(20),
					town char(20));

INSERT INTO products VALUES ('J1', 'Жесткий диск', 'Париж');
INSERT INTO products VALUES ('J2', 'Перфоратор', 'Рим');
INSERT INTO products VALUES ('J3', 'Считыватель', 'Афины');
INSERT INTO products VALUES ('J4', 'Принтер', 'Афины');
INSERT INTO products VALUES ('J5', 'Флоппи-диск', 'Лондон');
INSERT INTO products VALUES ('J6', 'Терминал', 'Осло');
INSERT INTO products VALUES ('J7', 'Лента', 'Лондон');

CREATE TABLE deliveries (n_post char(6),
					n_det char(20),
					n_product char(20),
					amount smallint);

INSERT INTO deliveries VALUES ('S1', 'P1', 'J1', 200);
INSERT INTO deliveries VALUES ('S1', 'P1', 'J4', 700);
INSERT INTO deliveries VALUES ('S2', 'P3', 'J1', 400);
INSERT INTO deliveries VALUES ('S2', 'P3', 'J2', 200);
INSERT INTO deliveries VALUES ('S2', 'P3', 'J3', 200);
INSERT INTO deliveries VALUES ('S2', 'P3', 'J4', 500);
INSERT INTO deliveries VALUES ('S2', 'P3', 'J5', 600); 
INSERT INTO deliveries VALUES ('S2', 'P3', 'J6', 400); 
INSERT INTO deliveries VALUES ('S2', 'P3', 'J7', 800); 
INSERT INTO deliveries VALUES ('S2', 'P5', 'J2', 100); 
INSERT INTO deliveries VALUES ('S3', 'P3', 'J1', 200); 
INSERT INTO deliveries VALUES ('S3', 'P4', 'J2', 500); 
INSERT INTO deliveries VALUES ('S4', 'P6', 'J3', 300); 
INSERT INTO deliveries VALUES ('S4', 'P6', 'J7', 300); 
INSERT INTO deliveries VALUES ('S5', 'P2', 'J2', 200); 
INSERT INTO deliveries VALUES ('S5', 'P2', 'J4', 100); 
INSERT INTO deliveries VALUES ('S5', 'P5', 'J5', 500); 
INSERT INTO deliveries VALUES ('S5', 'P5', 'J7', 100); 
INSERT INTO deliveries VALUES ('S5', 'P6', 'J2', 200); 
INSERT INTO deliveries VALUES ('S5', 'P1', 'J4', 100); 
INSERT INTO deliveries VALUES ('S5', 'P3', 'J4', 200); 
INSERT INTO deliveries VALUES ('S5', 'P4', 'J4', 800);
INSERT INTO deliveries VALUES ('S5', 'P5', 'J4', 400);
INSERT INTO deliveries VALUES ('S5', 'P6', 'J4', 500);

SELECT 'Вариант 6.';
SELECT 'Выдать номера и названия изделий, для которых город 
является первым в алфавитном списке таких городов:';
SELECT products.name, products.n_product FROM products WHERE town == (SELECT MIN(town) FROM products);
SELECT '';

SELECT 'Получить цвета деталей, поставляемых поставщиком S1:';
SELECT color FROM components WHERE n_det IN (SELECT n_det FROM deliveries WHERE n_post == 'S1');
SELECT '';

SELECT 'Выдать номера и фамилии поставщиков, поставляющих деталь 
Р1 для какого- либо изделия в количестве, большем среднего объема 
поставок детали Р1 для этого изделия:';
SELECT providers.n_post, providers.name
  FROM providers WHERE providers.n_post =
    (SELECT providers.n_post
      FROM providers, deliveries
        WHERE n_det == 'P1' AND amount >
          (SELECT AVG(amount) FROM deliveries, components, products WHERE components.n_det == 'P1' AND products.n_product == deliveries.n_product));
SELECT '';

SELECT 'Получить полный список деталей для всех изделий:';
SELECT DISTINCT products.name, components.name FROM components, deliveries, products WHERE deliveries.n_det =components.n_det AND deliveries.n_product = products.n_product ORDER BY products.name;
SELECT '';

SELECT 'Изменить цвет красных деталей с весом менее 15 фунтов на желтый.';
UPDATE components SET color = 'Yellow' WHERE (color == 'Красный' AND weight < 15);
SELECT '';

SELECT 'Построить таблицу с номерами изделий и городов, где они изготавливаются,
такие, что второй буквой названия города является О';
CREATE TABLE new_components  (town char(25),
		     n_new_component char(25));

INSERT INTO new_components (n_new_component, town) VALUES ((SELECT n_det FROM components), (SELECT town FROM components WHERE town LIKE '_о*'));
SELECT '';

-- Вариант 3 контрольной Банк




SELECT 'Вариант 8';
Create table post (n_post char(5) not NULL,
                        name char(20), 
                        reiting smallint,
                        town char(15));
INSERT INTO post VALUES(
  "S1","Смит", 20, "Лондон");
INSERT INTO post VALUES(
  "S2","Джонс", 10, "Париж");
INSERT INTO post VALUES(
  "S3","Блейк", 30, "Париж");
INSERT INTO post VALUES(
  "S4","Кларк", 20, "Лондон");
INSERT INTO post VALUES(
  "S5","Адамс", 30, "Атенс");
  
Create table det (n_det char(6) ,
name char(20),
cvet char(7),
ves smallint,
town char(15));

INSERT INTO det VALUES(
  "P1","Гайка", "Красный", 12, "Лондон");
INSERT INTO det VALUES(
  "P2","Болт", "Зеленый", 17, "Париж");
INSERT INTO det VALUES(
  "P3","Винт", "Голубой", 17, "Рим");
INSERT INTO det VALUES(
  "P4","Винт", "Красный", 14, "Лондон");
INSERT INTO det VALUES(
  "P5","Кулачок", "Голубой", 12, "Париж");
INSERT INTO det VALUES(
  "P6","Блюм", "Красный", 19, "Лондон");

Create table postdet (n_post char(5) ,
n_det char(6),
date_post date,
kol smallint);

INSERT INTO postdet VALUES(
  "S1","P1", '2005-02-01', 300);
INSERT INTO postdet VALUES(
  "S1","P2", '2005-04-05', 200);
INSERT INTO postdet VALUES(
  "S1","P3", '2005-05-12', 400);
INSERT INTO postdet VALUES(
  "S1","P4", '2005-06-15', 200);
INSERT INTO postdet VALUES(
  "S1","P5", '2005-07-22', 100);
INSERT INTO postdet VALUES(
  "S1","P6", '2005-08-13', 100);
INSERT INTO postdet VALUES(
  "S2","P1", '2005-03-03', 300);
INSERT INTO postdet VALUES(
  "S2","P2", '2005-06-12', 400);
INSERT INTO postdet VALUES(
  "S3","P2", '2005-04-04', 200);
INSERT INTO postdet VALUES(
  "S4","P2", '2005-03-23', 200);
INSERT INTO postdet VALUES(
  "S4","P4", '2005-06-17', 300);
INSERT INTO postdet VALUES(
  "S4","P5", '2005-08-22', 400);

SELECT '26:';
SELECT post.n_post, post.name, postdet.kol FROM post INNER JOIN postdet ON (post.name=postdet.n_post);

SELECT '27:';
SELECT post.n_post, post.name, postdet.kol FROM post LEFT OUTER JOIN postdet ON (post.n_post=postdet.n_post);

SELECT '28:';
CREATE VIEW z1 AS SELECT postdet.n_post, postdet.n_det, det.name, det.cvet, det.ves FROM postdet, det WHERE postdet.n_det=det.n_det AND cvet IN ('Красный','Зеленый');

SELECT '29:';
SELECT x.n_post, x.name, x.reiting FROM post x WHERE x.reiting > ALL (SELECT y.reiting FROM post y WHERE y.town='Лондон');

SELECT '30:';
SELECT x.n_post, x.name, x.reiting FROM post x WHERE x.reiting > ANY (SELECT y.reiting FROM post y WHERE y.town='Париж');

SELECT '31:';
SELECT name FROM post WHERE n_post IN (SELECT n_post FROM postdet WHERE n_det='P2');

SELECT '32:';
SELECT name FROM post WHERE n_post IN ('S1','S2','S3','S4');

SELECT '33:';
SELECT name FROM post WHERE n_post IN (SELECT n_post FROM postdet WHERE n_det IN (SELECT n_det FROM det WHERE cvet='Красный'));

SELECT '34:';
SELECT DISTINCT n_post FROM postdet spx WHERE spx.n_det IN (SELECT spy.n_det FROM postdet spy WHERE spy.n_post='S2');

SELECT '35:';
SELECT n_post FROM post WHERE town=(SELECT town FROM post WHERE n_post='S1');

SELECT '36:';
SELECT name FROM post WHERE 'P2' IN (SELECT n_det FROM postdet WHERE n_post=post.n_post);

SELECT '37:';
SELECT DISTINCT spx.n_det FROM postdet spx WHERE spx.n_det IN (SELECT spy.n_det FROM postdet spy WHERE spy.n_post<>spx.n_post);

SELECT '38:';
SELECT name FROM post WHERE EXISTS (SELECT * FROM postdet WHERE n_post=post.n_post AND n_det='P2');

SELECT '39:';
SELECT name FROM post WHERE NOT EXISTS (SELECT * FROM det WHERE NOT EXISTS (SELECT * FROM postdet WHERE n_post=post.n_post AND n_det=det.n_det));

SELECT '40:';
SELECT n_post FROM post WHERE reiting < (SELECT MAX(reiting) FROM post);

SELECT '41:';
SELECT n_post, reiting, town FROM post sx WHERE reiting >= (SELECT AVG(reiting) FROM post sy WHERE sy.town=sx.town);

SELECT '42:';
SELECT n_det FROM det WHERE ves>16 UNION SELECT n_det FROM postdet WHERE n_post='S2';

SELECT '43:';
--DELETE FROM post WHERE n_post='S1';

SELECT '44:';
--DELETE FROM post WHERE town='Лондон';

SELECT '45:';
--DELETE FROM postdet WHERE 'Лондон'=(SELECT town FROM post WHERE post.n_post=postdet.n_post);

SELECT '46:';
--DELETE FROM post;

SELECT '47:';
INSERT INTO postdet VALUES ('S2','P4','2005-11-30',1000);

SELECT '48:';
INSERT INTO post(n_post, name, town) VALUES ('S6','Боб','Нью-Йорк');

SELECT '49:';
CREATE TABLE temp(n_det char(6), o_post smallint);
INSERT INTO temp(n_det,o_post) SELECT n_det, SUM(kol) FROM postdet GROUP BY n_det;
SELECT * FROM temp;

SELECT '50:';
CREATE TABLE outside_t (n_post char(5), name char(20), reiting smallint, town char(15), n_det char(6));
INSERT INTO outside_t SELECT post.*, postdet.n_det FROM post, postdet WHERE post.n_post=postdet.n_post;
INSERT INTO outside_t SELECT post.*, 'NN' FROM post WHERE NOT EXISTS (SELECT * FROM postdet WHERE postdet.n_post=post.n_post);
SELECT * FROM outside_t;



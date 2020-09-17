--QUESTÃO 2
--a)
CREATE ROLE programadores;
GRANT INSERT, SELECT, UPDATE, DELETE ON ALL TABLES IN SCHEMA northwind
TO programadores;

--b)
CREATE ROLE gerente;


--QUESTÃO 3
--a)
CREATE ROLE vanessa WITH LOGIN PASSWORD '12345';
CREATE USER vanessa WITH PASSWORD '12345';


--QUESTÃO 4
--a)
GRANT programadores TO vanessa;
GRANT USAGE ON SCHEMA northwind TO programadores;

--c)
SELECT * FROM northwind.categories;
INSERT INTO northwind.categories(
categoryid, categoryname, description)
VALUES (200, 'teste', 'testando privilegios');
UPDATE northwind.categories SET categoryname = 'teste 200' WHERE
categoryid = 200;
DELETE FROM northwind.categories WHERE categoryid = 200;
CREATE TABLE northwind.teste (a int primary key);
DROP TABLE northwind.teste;


--QUESTÃO 5
REVOKE DELETE ON TABLE northwind.categories FROM programadores;
DROP ROLE programadores;
REVOKE ALL PRIVILEGES ON schema northwind FROM programadores;
REVOKE ALL PRIVILEGES ON ALL TABLES IN schema northwind FROM
programadores;


--QUESTÃO 6
SELECT * FROM northwind.orders
SELECT * FROM northwind.order_details where orderid = 11038
--a)
CREATE VIEW relatorio AS (SELECT o.orderid, o.customerid,
o.employeeid, count(od.orderid) as total_produtos, sum(od.unitprice)
as total_pedido
FROM northwind.orders o, northwind.order_details od
WHERE o.orderid = od.orderid
GROUP BY (o.orderid));
SELECT * FROM relatorio;

--b)
GRANT SELECT ON relatorio TO gerente;

--c)
CREATE USER gestor WITH PASSWORD '123456';
GRANT gerente TO gestor;
GRANT USAGE ON SCHEMA northwind TO gerente;
SELECT * FROM northwind.orders;
SELECT * FROM northwind.order_details;
SELECT * FROM relatorio;
----------
--Comandos para verificar as roles e seus privilégios no banco
SELECT * FROM pg_roles where rolname = 'programadores';
select * from information_schema.role_table_grants where
grantee='programadores';
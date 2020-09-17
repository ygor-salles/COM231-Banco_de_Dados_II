----------
--Comandos para verificar as roles e seus privilégios no banco

SELECT * FROM pg_roles where rolname = 'programadores';
select * from information_schema.role_table_grants where grantee='programadores';

--------------------------------------------------------
--PRÁTICA 2

--QUESTÃO 1
--a)
CREATE ROLE dba_northwind;
GRANT ALL PRIVILEGES ON DATABASE "Northwind" TO dba_northwind;
GRANT ALL ON ALL TABLES IN SCHEMA northwind TO dba_northwind;
GRANT USAGE ON SCHEMA northwind TO dba_northwind;

--b)
CREATE USER dba WITH PASSWORD '12345';
GRANT dba_northwind TO dba;

--c)
select * from northwind.categories;
ALTER TABLE northwind.categories ADD COLUMN teste int;

--d)
ALTER TABLE northwind.categories OWNER TO dba_northwind;  
ALTER TABLE northwind.teste ADD COLUMN teste int;
SELECT * FROM northwind.teste;

e)
REVOKE DELETE ON TABLE northwind.categories FROM programadores;

f)
select * from information_schema.role_table_grants where grantee='programadores';
select tablename, tableowner From pg_tables 

--QUESTÃO 2
--a)
CREATE USER user1 WITH PASSWORD '12345';
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE northwind.categories, northwind.customers, northwind.products TO user1 WITH GRANT OPTION;
GRANT USAGE ON SCHEMA northwind TO user1;

--b)
CREATE USER user2 WITH PASSWORD '12345';
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE northwind.categories, northwind.orders, northwind.order_details TO user2 WITH GRANT OPTION;
GRANT USAGE ON SCHEMA northwind TO user2;

--c)
CREATE USER user3 WITH PASSWORD '12345';
GRANT SELECT ON ALL TABLES IN SCHEMA northwind TO user3;
GRANT USAGE ON SCHEMA northwind TO user3;
select * from information_schema.role_table_grants where grantee='user3' ORDER BY grantor;

--d)
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE northwind.categories, northwind.customers, northwind.products TO user3 WITH GRANT OPTION;

--e)
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE northwind.categories, northwind.orders, northwind.order_details TO user3 WITH GRANT OPTION;

--g)
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA northwind FROM user3;
REVOKE ALL PRIVILEGES ON schema northwind FROM user3; 
DROP ROLE user3;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA northwind FROM user1 CASCADE;
REVOKE ALL PRIVILEGES ON schema northwind FROM user1 CASCADE; 
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA northwind FROM user2 CASCADE;
REVOKE ALL PRIVILEGES ON schema northwind FROM user2 CASCADE; 
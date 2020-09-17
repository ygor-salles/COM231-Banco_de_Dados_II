SELECT * FROM northwind.categories;

select * from relatorio;

INSERT INTO northwind.categories(
	categoryid, categoryname, description)
	VALUES (200, 'teste', 'testando privilegios');
	
UPDATE northwind.categories SET categoryname = 'teste 200' WHERE categoryid = 200;

DELETE FROM northwind.categories WHERE categoryid = 200;

CREATE TABLE northwind.teste (a int primary key);

DROP TABLE northwind.categories;

DELETE FROM northwind.categories WHERE categoryid = 1;

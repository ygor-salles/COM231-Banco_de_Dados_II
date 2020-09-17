/* 3a */
SELECT  od.productid as Id_Produto, pro.productname as nome_produto, COUNT(pro.productid) as qtd_produtos
FROM northwind.orders o JOIN northwind.order_details od on o.orderid = od.orderid 
JOIN northwind.products pro on od.productid = pro.productid 
WHERE o.customerid like 'CHOPS'
GROUP BY (od.productid, pro.productname, pro.productid)
ORDER BY COUNT(pro.productid) DESC

/* 3b */
CREATE OR REPLACE FUNCTION produtos_consumidor(customerid varchar(5))
RETURNS SETOF RECORD AS $$
																  
SELECT  od.productid as Id_Produto, pro.productname as nome_produto, od.quantity as qtd_produtos
FROM northwind.orders o JOIN northwind.order_details od on o.orderid = od.orderid 
JOIN northwind.products pro on od.productid = pro.productid 
WHERE o.customerid like $1
ORDER BY od.quantity DESC
																  
$$ LANGUAGE SQL;																  
																   
SELECT * FROM produtos_consumidor('CHOPS')	
																  
/* 3c */

CREATE OR REPLACE VIEW qtd_produtos_categorias AS
SELECT c.categoryid as id_categoria, c.categoryname as nome_categoria, COUNT(p.categoryid) 
FROM northwind.products p JOIN northwind.categories c ON c.categoryid = p.categoryid
GROUP BY (c.categoryid, c.categoryname, p.categoryid)
ORDER BY c.categoryid																  
					
SELECT *
FROM qtd_produtos_categorias						
																  
/* 3d-1 */
																  
ALTER TABLE northwind.categories ADD quantity smallint not null default(0)

/* 3d-2 */

CREATE OR REPLACE FUNCTION atualiza_qtd_produtos()
RETURNS void AS $$
DECLARE categoria northwind.categories%rowtype;																  
BEGIN
	FOR categoria IN SELECT * FROM northwind.categories
	LOOP															  
		UPDATE northwind.categories																  
		SET quantity = (SELECT COUNT(p.categoryid)
							FROM northwind.products p JOIN northwind.categories c ON c.categoryid = p.categoryid
						    WHERE categoria.categoryid=c.categoryid
							GROUP BY (p.categoryid)
							ORDER BY p.categoryid)
		WHERE categoryid = categoria.categoryid;														  
	END LOOP;	
RETURN;											   
END;														  
$$ LANGUAGE plpgsql	

SELECT * FROM atualiza_qtd_produtos()
																  
SELECT * FROM northwind.categories		
																  
/* 3-d */

CREATE OR REPLACE FUNCTION tr_atualiza_qtd_produtos()
RETURNS TRIGGER AS $$
BEGIN
	IF (tg_op = 'INSERT') THEN														  
		UPDATE northwind.categories
		SET quantity = quantity+1
		WHERE categoryid = new.northwind.products.categoryid;
	ELSEIF (tg_op = 'DELETE') THEN															  
		UPDATE northwind.categories
		SET quantity = quantyty-1
		WHERE categoryid = old.northwind.products.categoryid;
	ELSEIF	((tg_op = 'UPDATE') and (new.northwind.products.categoryid != old.northwind.products.categoryid)) THEN										  
		UPDATE northwind.categories
		SET quantity = quantity+1
		WHERE categoryid = new.northwind.products.categoryid;
		UPDATE northwind.categories
		SET quantity = quantyty-1
		WHERE categoryid = old.northwind.products.categoryid;							 
	END IF;
	RETURN null;
END;
$$ LANGUAGE plpgsql;
									 
CREATE TRIGGER trigger_altera_qtd
AFTER INSERT OR DELETE OR UPDATE ON northwind.products
FOR EACH ROW EXECUTE PROCEDURE tr_atualiza_qtd_produtos()						 
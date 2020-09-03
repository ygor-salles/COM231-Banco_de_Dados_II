
--Questão 1
--a.
/* Comando opcional para definir o schema/caminho northwind 
set search_path to northwind;
Nesse caso não precisaria especificar o northwind antes da tabela, exemplo:  
FROM northwind.orders    ficaria:	FROM orders
*/
CREATE OR REPLACE FUNCTION geraRelatorio(pedido integer)
RETURNS TABLE (identificador_pedido int, consumidor varchar, cidade_consumidor varchar, data_pedido date, valortotalpedido numeric) AS $$
BEGIN
	ALTER TABLE northwind.orders
	ALTER COLUMN orderdate
	SET DATA TYPE date;
	RETURN QUERY SELECT o.orderid, c.companyname, c.city, o.orderdate, sum(od.unitprice * od.quantity - od.discount)
	FROM northwind.orders o, northwind.customers c, northwind.order_details od 
	WHERE o.customerid = c.customerid AND o.orderid = pedido AND od.orderid = pedido
	GROUP BY (o.orderid, c.customerid);
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM geraRelatorio(10248)



--b
GRANT EXECUTE ON FUNCTION geraRelatorio(pedido integer) TO gerente;

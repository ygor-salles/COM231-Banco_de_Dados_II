from decimal import *
from config import Config
from psycopg2.extensions import AsIs
from datetime import datetime
import psycopg2

class ProdutoM():
    def __init__(self, productid, productname, supplierid, categoryid, quantityperunit, unitprice, 
        unitsinstock, unitsonorder, reorderlevel , discontinued):
        self.id = productid
        self.nome = productname
        self.fornecedor = supplierid
        self.categoria = categoryid
        self.quantidadeEmbalagem = quantityperunit
        self.precoUnitario = unitprice
        self.estoque = unitsinstock
        self.vendas = unitsonorder
        self.nivel = reorderlevel
        self.descontinuado = discontinued
    
    def criaProduto(listaValores):
        produto = ProdutoM(int(listaValores[0]), str(listaValores[1]), int(listaValores[2]), int(listaValores[3]), str(listaValores[4]), 
            Decimal(listaValores[5]), int(listaValores[6]), int(listaValores[7]), int(listaValores[8]), str(listaValores[9]))
        return produto
    
    def cadastrarProduto(produto):
        string_sql = 'INSERT INTO northwind.products (productid, productname, supplierid, categoryid, quantityperunit, unitprice, ' \
                     'unitsinstock, unitsonorder, reorderlevel, discontinued) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        novo_registro = (produto.id, produto.nome, produto.fornecedor, produto.categoria, produto.quantidadeEmbalagem, produto.precoUnitario, produto.estoque, produto.vendas, produto.nivel, produto.descontinuado)
        status = Config.alteraBD(Config, string_sql, novo_registro)
        return status
    
    def deletaProduto(id):
        string_sql = 'DELETE FROM northwind.products WHERE productid = %s;'
        status = Config.alteraBD(Config, string_sql, [id])
        return status
    
    def consultaProduto(id):
        string_sql = 'SELECT * FROM northwind.products WHERE productid = %s;'
        registros = Config.consultaBD(Config, string_sql, [id])
        if len(registros[1]) != 0:
            prod = ProdutoM.criaProduto(registros[1][0])
            return prod
        else:
            return None
    
    def atualizaProduto(l):
        string_sql = """UPDATE northwind.products SET %s = %s WHERE productid = %s"""
        parametros = ((AsIs(l[1])), int(l[2]), int(l[0]))
        status = Config.alteraBD(Config, string_sql, parametros)
        return status
    
class PedidoM():
    def consultaRelatorio(id):
        if id == -1:
            string_sql = """SELECT * FROM northwind.relatorio"""
            registros = Config.consultaBD(Config, string_sql, [[]])
        else:
            string_sql = """SELECT * FROM northwind.relatorio WHERE numpedido = %s"""
            registros = Config.consultaBD(Config, string_sql, [id])
        if len(registros[1])==0:
            registros = None
        return registros
    
    def cadastraVenda(dadosPedido, listaProdutos):
        string_SQL_pedido = """INSERT INTO northwind.orders(orderid, customerid, employeeid, orderdate, requireddate, shippeddate, freight, \
        shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry, shipperid) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        string_SQL_produto = """INSERT INTO northwind.order_details(orderid, productid, unitprice, quantity, discount) VALUES (%s, %s, %s, %s, %s);"""
        status = Config.cadastraVendaBD(Config, string_SQL_pedido, string_SQL_produto, dadosPedido, listaProdutos)
        return status
    
    def alteraVenda(dadosPedido):
        string_sql = """UPDATE northwind.order_details SET quantity = %s WHERE orderid = %s AND productid = %s"""
        parametros = (dadosPedido[2], dadosPedido[0], dadosPedido[1])
        status = Config.alteraBD(Config, string_sql, parametros)
        return status

#Isso foi feito em outro arquivo no exemplo da professora
class OrderDetails():
    def __init__(self, orderid, productid, unitprice, quantity, discount):
        self.orderid = orderid
        self.productid = productid
        self.unitprice = unitprice
        self.quantity = quantity
        self.discount = discount
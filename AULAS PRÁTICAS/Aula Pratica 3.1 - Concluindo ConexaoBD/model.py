from decimal import *
from config import Config
from psycopg2.extensions import AsIs
from datetime import datetime

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
                     'unitsinstock, unitsonorder, reorderlevel, discontinued) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'
        novo_registro = (produto.id, produto.nome, produto.fornecedor, produto.categoria, produto.quantidadeEmbalagem, produto.precoUnitario, produto.estoque, produto.vendas, produto.nivel, produto.descontinuado)
        status = Config.alteraBD(string_sql, novo_registro)
        return status
    
    def deletaProduto(id):
        string_sql = 'DELETE FROM northwind.products WHERE productid = %s;'
        status = Config.alteraBD(string_sql, [id])
        return status
    
    def consultaProduto(id):
        string_sql = 'SELECT * FROM northwind.products WHERE productid = %s;'
        registros = Config.consultaBD(string_sql, [id])
        if len(registros[1] != 0):
            prod = ProdutoM.criaProduto(registros[1][0])
            return prod
        else:
            return None
    
    def atualizaProduto(l):
        string_sql = """UPDATE northwind.products SET %s = %s WHERE productid = %s"""
        parametros = ((AsIs(l[1])), int(l[2]), int(l[0]))
        status = Config.alteraBD(string_sql, parametros)
        return status
    
    
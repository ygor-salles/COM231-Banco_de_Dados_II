from config import config
from datetime import datetime
from decimal import *
from psycopg2.extensions import AsIs
import psycopg2


class ProdutoM():
    def __init__(self, productid, productname, supplierid, categoryid, quantityperunit, unitprice, unitsinstock, unitsonorder, reorderlevel, discontinued):
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
        return ProdutoM(int(listaValores[0]), str(listaValores[1]), int(listaValores[2]), int(listaValores[3]),
             str(listaValores[4]), Decimal(listaValores[5]),
             int(listaValores[6]), int(listaValores[7]), int(listaValores[8]), str(listaValores[9]))


    def cadastraProduto(produto):
        string_sql = 'INSERT INTO northwind.products (productid, productname, supplierid, categoryid, quantityperunit, unitprice, ' \
                     'unitsinstock, unitsonorder, reorderlevel, discontinued) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        novo_registro = (produto.id, produto.nome, produto.fornecedor, produto.categoria, produto.quantidadeEmbalagem, produto.precoUnitario, produto.estoque, produto.vendas, produto.nivel, produto.descontinuado)
        status = config.alteraBD(config, string_sql, novo_registro)
        return status
        

    def deletaproduto(id):
        string_sql = 'DELETE FROM northwind.products WHERE productid = %s;'
        status = config.alteraBD(config, string_sql, [id])
        return status


    def consultaproduto(id):
        string_sql = 'SELECT * FROM northwind.products WHERE productid = %s;'
        registros = config.consultaBD(config, string_sql, [id])
        coluna = registros[0]
        dados = registros[1]
        #for i in dados:
         #   print(f'{coluna[0]}:{i[0]}')
          #  print(f'{coluna[1]}:{i[1]}')
           # print(f'{coluna[2]}:{i[2]}')
            #print(f'{coluna[3]}:{i[3]}')
        print(len(registros[1]))
        if(registros != psycopg2.Error and len(registros[1]) != 0):
            prod = ProdutoM.criaProduto(registros[1][0])
            return prod
        else:
            return None


    def atualizavaloresupdate(l):
        string_sql = """UPDATE northwind.products SET %s = %s WHERE productid = %s"""
        parametros = ((AsIs(l[1])), int(l[2]), int(l[0]))
        status = config.alteraBD(config, string_sql, parametros)
        return status
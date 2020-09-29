from decimal import *
import psycopg2
from psycopg2.extensions import AsIs

class Order():
    def __init__(self, orderid, customerid, employeeid, requireddate, shippedate, freight, shipname,
    shipaddress, shipcity, shipregion, shippostalcode, shipcountry, shipperid):
        self.orderid = orderid
        self.customerid = customerid
        self.employeeid = employeeid
        self.requireddate = requireddate
        self.shippedate = shippedate
        self.freight = freight
        self.shipname = shipname
        self.shipaddress = shipaddress
        self.shipcity = shipcity
        self.shipregion = shipregion
        self.shippostalcode = shippostalcode
        self.shipcountry = shipcountry
        self.shipperid = shipperid

    def cadastraPedido(pedido):
        string_sql = 'INSERT INTO northwind.orders (orderid, customerid, employeeid, \
            requireddate, shippedate, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry, shipperid)\
            VALUES (%s %s %s %s %s %s %s %s %s %s %s %s %s)'
        record_to_insert = (pedido.orderid, pedido.customerid, pedido.employeeid, pedido.requireddate, pedido.shippedate, pedido.freight
            pedido.shipname, pedido.shipaddress, pedido.shipcity, pedido.shipregion, pedido.shippostalcode, pedido.shipcountry, pedido.shipperid)
        conn_string = "host='localhost' dbname='ConexaoBD_1' user='postgres' password='postgre'"
    
        #iniciar a inserção do registro
        conn = None
        try:
            #abrir a conexão
            conexao = psycopg2.connect(conn_string)

            #abrir a sessão - a transação começa aqui
            sessao = conexao.cursor()

            #Executar a inserção na memória RAM
            sessao.execute(string_sql, record_to_insert)
            
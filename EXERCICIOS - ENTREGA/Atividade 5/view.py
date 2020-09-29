from decimal import *
from modelo import Order
from datetime import datetime

class View():
    def __init__(self):
        return self.menu()

    def menu(self):
        print('********MENU*************')
        print('1 - Cadastrar pedido')
        print('2 - Deletar pedido')
        print('1 - Consultar pedido')
        print('1 - Alterar dados de um pedido')
        opcao = int(input('Digite a opção desejada: '))
        return opcao
    
    def coletaDadosPedido(self):
        orderid = input('Digite identificador do pedido: ')
        customerid = input('Digite identificador do cliente: ') 
        employeeid = input('Digite identificador do funcionario: ') 
        requireddate = input('Digite data requerida: ') 
        shippedate = input('Digite data shippe: ') 
        freight = input('Digite o valor de frete: ') 
        shipname = input('Digite o nome: ')
        shipaddress = input('Digite endereço: ') 
        shipcity = input('Digite a cidade: ') 
        shipregion = input('Digite região: ')
        shippostalcode = input('Digite cartão postal: ') 
        shipcountry = input('Digite o país') 
        shipperid = input('Digite identificador remetente')
        valores = [orderid, customerid, employeeid, requireddate, shippedate, freight, shipname,
            shipaddress, shipcity, shipregion, shippostalcode, shipcountry, shipperid]
        return valores

    def coletaDadosPedidoUpdate(self):
        atributos = {1: 'orderid', 2: 'customerid', 3: 'employeeid', 4: 'requireddate', 5: 'shippedate', 6: 'freight', 7: 'shipname',
            8: 'shipaddress', 9: 'shipcity', 10: 'shipregion', 11: 'shippostalcode', 12: 'shipcountry', 13: 'shipperid'}

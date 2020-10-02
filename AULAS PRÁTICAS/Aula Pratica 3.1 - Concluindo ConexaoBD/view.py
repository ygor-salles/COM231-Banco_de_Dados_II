from decimal import *
from model import OrderDetails
from datetime import datetime

class View():
    def inicio(self):
        return self.menu()
    
    def menu(self):
        print('**********MENU**********')
        print('1 - Cadastrar um produto')
        print('2 - Deletar um produto')
        print('3 - Consultar um produto')
        print('4 - Alterar dados de um produto')
        print('5 - Consultar o relatório de pedidos')
        print('6 - Cadastrar uma venda')
        print('7 - Alterar a quantidade de produtos vendidos')
        print('8 - Sair')
        opcao = int(input('Digite a opção desejada: '))
        return opcao
    
    def coletaDadosProduto(self):
        productid = input('Digite o identificador do produto: ') 
        productname = input('Digite o nome do produto: ')
        supplierid = input('Digite o identificador do fornecedor: ')
        categoryid = input('Digite o identificador da categoria: ')
        quantityperunit = input('Digite a quantidade de produtos por embalagem: ')
        unitprice = input('Digite o preço do produto: ')
        unitsinstock = input('Digite a quantidade de unidade no estoque: ')
        unitsonorder = input('Digite a quantidade de unidades disponiveis para venda: ')
        reorderlevel = input('Digite nivel do produto: ')
        discontinued = input('O produto esta descontinuado?: ')
        valores = [productid, productname, supplierid, categoryid, quantityperunit, unitprice, 
        unitsinstock, unitsonorder, reorderlevel , discontinued]
        return valores

    def coletaDadosProdutoUpdate(self, id):
        atributos = {1: 'productname', 2: 'supplierid', 3: 'categoryid', 4: 'quantityperunit', 5: 'unitprice', 
            6: 'unitsinstock', 7: 'unitsonorder', 8: 'reorderlevel', 9: 'discontinued'}
        print('Digite')
        print('1 para o nome do produto')
        print('2 para o identificador do fornecedor')
        print('3 para o identificador da categoria')
        print('4 para a quantidade de produto por embalagem')
        print('5 para o preço unitário')
        print('6 para a quantidade de produto no estoque')
        print('7 para a quantidade de produto disponível para a venda')
        print('8 para o nível do produto')
        print('9 para descontinuado')
        campo = int(input())
        valor = input('Digite o novo valor para o atributo: ')
        if campo==2 or campo==3 or campo==6 or campo==8:
            int(valor)
        elif campo==4:
            Decimal(valor)
        return (id, atributos[campo], valor)
    
    def recebeCodProduto(self):
        productid = int(input('Digite o identificador do produto: '))
        return productid
    
    def recebeCodPedido(self):
        pedidoId = int(input('Digite o identificador do produto: '))
        return pedidoId
    
    def imprimeProduto(self, prod):
        if prod is not None:
            print('ID: ',prod.id)
            print('Nome: ',prod.nome)
            print('Fornecedor: ',prod.fornecedor)
            print('Categoria: ',prod.categoria)
            print('Quantidade por embalagem: ',prod.quantidadeEmbalagem)
            print('Preço unitário: ',prod.precoUnitario)
            print('Estoque: ',prod.estoque)
            print('Disponíveis para venda: ',prod.vendas)
            print('Nível: ',prod.nivel)
            print('Descontinuado: ',prod.descontinuado)
        else:
            print('Consulta vazia')
    
    def imprimeRelatorio(self, registros):
        if registros is not None:
            colunas = registros[0]
            dados = registros[1]
            print('A consulta retornou ',len(dados),' registros')
            for i in dados:
                print(colunas[0],' : ',i[0])
                print(colunas[1],' : ',i[1])
                print(colunas[2],' : ',i[2])
                print(colunas[3],' : ',i[3])
                print(colunas[4],' : ',i[4])
        else:
            print('A consulta não retornou dados')                

    def coletaDadosPedido(self):
        orderid = input('Digite o identificador do pedido: ')
        customerid = input('Digite o identificador do cliente: ')
        employeeid = input('Digite o identificador do funcionario: ')
        orderdate = input('Digite a data do pedido (AAAA-MM-DD): ')
        requireddate = input('Digite a data de fechamento do pedido (AAAA-MM-DD): ')
        shippeddate = input('Digite a data de envio do pedido (AAAA-MM-DD): ')
        freight = input('Digite o valor do frete: ')
        shipname = input('Digite o local do envio: ')
        shipaddress = input('Digite o endereço: ')
        shipcity = input('Digite a cidade do envio: ')
        shipregion = input('Digite a região do envio: ')
        shippostalcode = input('Digite o CEP: ')
        shipcountry = input('Digite o país: ')
        shipperid = input('Digite o id do endereço de envio: ')
        year, month, day = map(int, orderdate.split('-'))
        requireddate = datetime(year, month, day)
        year, month, day = map(int, shippeddate.split('-'))
        shippeddate = datetime(year, month, day)
        pedido = [int(orderid), int(customerid), int(employeeid), orderdate, requireddate, shippeddate, Decimal(freight), 
            shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry, int(shipperid)]
        return pedido
    
    def coletaProdutosPedido(self, orderid):
        i=1
        listaProdutos = []
        while i != -1:
            print('Informe os produtos para o pedido ',orderid,' : ')
            productid = input('Digigte o identificador do pedido: ')
            unitprice = input('Digite o valor do produto: ')
            quantity = input('Digite a quantidade comprada: ')
            produtoPedido = OrderDetails(int(orderid), int(productid), Decimal(unitprice), int(quantity), Decimal(discount))
            listaProdutos.append(produtoPedido)
            i = int(input('Deseja continuar cadastrar produtos para esse pedido? (-1 para sair, 1 para continuar)'))
        return listaProdutos

    def coletaDadosPedidoUpdate(self):
        pedidoid = int(input('Digite o código do pedido: '))
        productid = int(input('Digite o código do pedido: '))
        quantidade = int(input('Digite o código do pedido: '))
        return [pedidoid, productid, quantidade]

    def imprimeStatus(self, status):
        if 'sucesso' in s   tatus:
            print('Comando executado no banco de dados com sucesso')
        else:
            print(status)
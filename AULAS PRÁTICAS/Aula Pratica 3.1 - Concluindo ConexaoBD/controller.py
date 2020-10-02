from view import View
from model import ProdutoM
from model import PedidoM

class Controle:
    def __init__(self):
        self.view = View()

    def inicio(self):
        opcao = self.view.inicio()
    
        while opcao != 8:
            if opcao == 1:
                l = self.view.coletaDadosProduto()
                prod = ProdutoM.criaProduto(l)
                status = ProdutoM.cadastrarProduto(prod)
                self.view.imprimeStatus(status)
            if opcao == 2:
                id = self.view.recebeCodProduto() 
                status = ProdutoM.deletaProduto(id)
                self.view.imprimeStatus(status)
            if opcao == 3:
                id = self.view.recebeCodProduto()
                prod = ProdutoM.consultaProduto(id)
                self.view.imprimeProduto(prod)
            if opcao == 4:
                id = self.view.recebeCodProduto()
                prod = ProdutoM.consultaProduto(id)
                self.view.imprimeProduto(prod)
                if prod is not None:
                    l = self.view.coletaDadosProdutoUpdate(id)
                    status = ProdutoM.atualizaProduto(l)
                    self.view.imprimeStatus(status)
            if opcao == 5:
                id = self.view.recebeCodPedido()
                l = PedidoM.consultaRelatorio(id)
                self.view.imprimeRelatorio(l)
            if opcao == 6:
                l = self.view.coletaDadosPedido()
                p = self.view.coletaProdutosPedido(l[0])
                status = PedidoM.cadastraVenda(l, p)
                self.view.imprimeStatus(status)
            if opcao == 7:
                l = self.view.coletaDadosPedidoUpdate()
                status = PedidoM.alteraVenda(l)
                self.view.imprimeStatus(status)
            opcao = self.view.menu()

if __name__ == "__main__":
    main = Controle()
    main.inicio()
                
from view import view
from modeloM import ProdutoM

class Controle:

    def inicio(self):
        opcao = view.inicio()
        
        while opcao != 8:
            if opcao == 1:
                l = view.coletadadosproduto()
                prod = ProdutoM.criaProduto(l)
                status = ProdutoM.cadastraProduto(prod)
                view.imprimeStatus(status)
                opcao = view.inicio()
            
            elif opcao == 2:
                productid = view.recebeCodproduto()
                status = ProdutoM.deletaproduto(productid)
                view.imprimeStatus(status)
                opcao = view.inicio()
            
            elif opcao == 3:
                productid = view.recebeCodproduto()
                prod = ProdutoM.consultaproduto(productid)
                view.imprimeProduto(prod)
                opcao = view.inicio()

            elif opcao == 4:
                l = view.coletaMod()
                status = ProdutoM.atualizavaloresupdate(l)
                view.imprimeStatus(status)
                opcao = view.inicio()



    


control = Controle()
control.inicio()

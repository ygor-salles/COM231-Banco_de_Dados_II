import psycopg2

class Config():
    def __init__(self, dadosConexao):
        self.dadosConexao = dadosConexao

    def setParametros(self):
        self.dadosConexao = "host='localhost' dbname='ConexaoBD_1 user='postgres' password=postgre'"
        return self
    
    def alteraBD(self, stringSQL, valores):
        #iniciar a sessão do registro
        conn = None
        try:
            #abrir a conexão
            conexao =  psycopg2.connect(Config.setParametros(self).dadosConexao)

            #abrir a sessão - a transação atual começa aqui
            sessao = conexao.cursor()

            #Executar a inserção na memória RAM
            sessao.execute(stringSQL, valores)

            #commitar a sessão - fechar transação
            conexao.commit()

            #Encerrar a sessão
            sessao.close()

        except psycopg2.Error:
            return psycopg2.Error
        
        finally:
            if conn is not None:
                conn.close()
            return 'Registro alterado com sucesso'
    
    def consultaBD(self, stringSQL, valores):
        # iniciar a inserção do registro
        conn = None
        try:
            # abrir a conexão
            conexao = psycopg2.connect(config.setParametros(self).dadosconexao)

            # abrir a sessão - a transação começa aqui
            sessao = conexao.cursor()

            # Executar a consulta
            sessao.execute(stringSQL, valores)

            #Armazenar os resultados
            registros = sessao.fetchall()
            colnames = [desc[0] for desc in sessao.description]

            # Comitar para fechar a transação
            conexao.commit()

            # Encerrar a sessão
            sessao.close()

        except psycopg2.Error:
            return psycopg2.Error
        else:
            if conn is not None:
                conn.close()
            return(colnames, registros)

    def cadastraVendaBD(self, stringSQLPedido, stringSQLProduto, dadosPedido, listaProdutos):
        conn = None
        try:
            #abrir a conexão
            conexao = psycopg2.connect(Config.setParametros(self).dadosConexao)
            
            #abrir a sessão - a transação começa aqui
            sessao = conexao.cursor()

            #Executar a inserção do pedido na memória RAM - TABELA ORDERS
            sessao.execute(stringSQLPedido, dadosPedido)

            #Executar a inserção do pedido na memória RAM - TABELA ORDERDETAILS
            for i in listaProdutos:
                sessao.execute(stringSQLProduto, (i.idPedido, i.idProduto, i.preco, i.quantidade, i.desconto))
            
            #Comitar todas as sessões - fechar transação
            conexao.commit()

            #Encerrar a Sessão
            sessao.close()
        
        except psycopg2.Error:
            return psycopg2.Error
        finally:
            if conn is not None:
                conn.close()
            return 'Venda cadastrada com sucesso'
    
    
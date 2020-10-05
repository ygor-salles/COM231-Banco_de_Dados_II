from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import *
from sqlalchemy.orm import sessionmaker
from sqlalchemy.inspection import inspect

def criamodelo():

    engine = create_engine("postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind", echo=False)

    # cria um objeto da classe declarative. Será o 'catálogo'
    base = automap_base()

    #o método prepare realiza o mapeamento do schema do banco e o coloca em base
    base.prepare(engine,schema="northwind", reflect=True)

    #print(base.classes.keys())

    print("CADASTRA PRODUTO")
    insereProduto(base)

    print("CONSULTA PRODUTO")
    id = int(input("Digite o código do produto que será consultado : "))
    consultaProduto(base, id)

    print("ATUALIZA PRODUTO")
    id = int(input("Digite o código do produto que será atualizado : "))
    alteraProduto(base, id)

    print("DELETA PRODUTO")
    id = int(input("Digite o código do produto que será deletado : "))
    deletaProduto(base, id)

def insereProduto(model):
    # instancio o objeto que representa o Model da tabela products
    produto = model.classes.products

    # instancia um objeto produto
    prod = produto(
        productid=1405,
        productname='cadeira',
        supplierid=4,
        categoryid=8,
        quantityperunit='1',
        unitprice=150,
        unitsinstock=30,
        unitsonorder=30,
        reorderlevel=1,
        discontinued='N'
    )

    #cria a conexão
    engine = create_engine("postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind", echo=False)

    #cria a sessão
    Session = sessionmaker(bind=engine)
    session = Session()

    #insere o produto no banco de dados
    session.add(prod)

    #comitar a transação
    session.commit()

def consultaProduto(model, id):
    # instancio o objeto que representa o Model da tabela products
    produto = model.classes.products

    # cria a conexão
    engine = create_engine("postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind", echo=False)

    # cria a sessão
    Session = sessionmaker(bind=engine)
    session = Session()

    #consulta um produto
    prod = session.query(produto).filter(produto.productid == id).first()

    #imprime nome do produto
    print(prod.productname)

    #commitar a transação
    session.commit()

def deletaProduto(model, id):
    # instancio o objeto que representa o Model da tabela products
    produto = model.classes.products

    # cria a conexão
    engine = create_engine("postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind", echo=False)

    # cria a sessão
    Session = sessionmaker(bind=engine)
    session = Session()

    #recupera o objeto que será deletado do banco
    prod = session.query(produto).filter(produto.productid == id).first()

    #deleta o produto
    session.delete(prod)

    # comitar a transação
    session.commit()

def alteraProduto(model, id):
    # instancio o objeto que representa o Model da tabela products
    produto = model.classes.products

    # cria a conexão
    engine = create_engine("postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind", echo=False)

    # cria a sessão
    Session = sessionmaker(bind=engine)
    session = Session()

    # recupera o objeto que será deletado do banco
    prod = session.query(produto).filter(produto.productid == id).first()

   #realiza a atualização do atributo
    prod.unitsinstock = prod.unitsinstock - 10

    # comitar a transação
    session.commit()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    criamodelo()

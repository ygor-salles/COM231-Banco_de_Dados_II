from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import *
from sqlalchemy.orm import sessionmaker
from sqlalchemy.inspection import inspect

def criaModelo():
    engine = create_engine('postgresql+psycopg2://postgres:postgre@localhost:5432/Northwind', echo=False)

    #cria objeto da classe declarative. Será o catálogo
    base = automap_base()

    #o método prepare realiza o mapeamento do schema do banco e coloca em base
    base.prepare(engine, schema='northwind', reflect=True)

    print(base.classes.keys())

criaModelo()
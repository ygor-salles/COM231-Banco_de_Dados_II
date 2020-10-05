# coding: utf-8
from sqlalchemy import Column, DateTime, ForeignKey, Integer, Numeric, SmallInteger, String, Text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata

#Ygor Salles Aniceto Carvalho - 2017014382
#Fábio Piovani Viviani - 2017006774


class Category(Base):
    __tablename__ = 'categories'
    __table_args__ = {'schema': 'northwind'}

    categoryid = Column(Integer, primary_key=True)
    categoryname = Column(String(50))
    description = Column(String(100))


class Customer(Base):
    __tablename__ = 'customers'
    __table_args__ = {'schema': 'northwind'}

    customerid = Column(String(5), primary_key=True)
    companyname = Column(String(50))
    contactname = Column(String(30))
    contacttitle = Column(String(30))
    address = Column(String(50))
    city = Column(String(20))
    region = Column(String(15))
    postalcode = Column(String(9))
    country = Column(String(15))
    phone = Column(String(17))
    fax = Column(String(17))


class Employee(Base):
    __tablename__ = 'employees'
    __table_args__ = {'schema': 'northwind'}

    employeeid = Column(Integer, primary_key=True)
    lastname = Column(String(10))
    firstname = Column(String(10))
    title = Column(String(25))
    titleofcourtesy = Column(String(5))
    birthdate = Column(DateTime)
    hiredate = Column(DateTime)
    address = Column(String(50))
    city = Column(String(20))
    region = Column(String(2))
    postalcode = Column(String(9))
    country = Column(String(15))
    homephone = Column(String(14))
    extension = Column(String(4))
    reportsto = Column(Integer)
    notes = Column(Text)


class Shipper(Base):
    __tablename__ = 'shippers'
    __table_args__ = {'schema': 'northwind'}

    shipperid = Column(Integer, primary_key=True)
    companyname = Column(String(20))
    phone = Column(String(14))


class Supplier(Base):
    __tablename__ = 'suppliers'
    __table_args__ = {'schema': 'northwind'}

    supplierid = Column(Integer, primary_key=True)
    companyname = Column(String(50))
    contactname = Column(String(30))
    contacttitle = Column(String(30))
    address = Column(String(50))
    city = Column(String(20))
    region = Column(String(15))
    postalcode = Column(String(8))
    country = Column(String(15))
    phone = Column(String(15))
    fax = Column(String(15))
    homepage = Column(String(100))


class Order(Base):
    __tablename__ = 'orders'
    __table_args__ = {'schema': 'northwind'}

    orderid = Column(Integer, primary_key=True)
    customerid = Column(ForeignKey('northwind.customers.customerid', ondelete='RESTRICT', onupdate='CASCADE'), ForeignKey('northwind.customers.customerid'), nullable=False)
    employeeid = Column(ForeignKey('northwind.employees.employeeid'), ForeignKey('northwind.employees.employeeid', ondelete='RESTRICT', onupdate='CASCADE'), nullable=False)
    orderdate = Column(DateTime)
    requireddate = Column(DateTime)
    shippeddate = Column(DateTime)
    freight = Column(Numeric(15, 4))
    shipname = Column(String(35))
    shipaddress = Column(String(50))
    shipcity = Column(String(15))
    shipregion = Column(String(15))
    shippostalcode = Column(String(9))
    shipcountry = Column(String(15))
    shipperid = Column(Integer)

    customer = relationship('Customer', primaryjoin='Order.customerid == Customer.customerid')
    customer1 = relationship('Customer', primaryjoin='Order.customerid == Customer.customerid')
    employee = relationship('Employee', primaryjoin='Order.employeeid == Employee.employeeid')
    employee1 = relationship('Employee', primaryjoin='Order.employeeid == Employee.employeeid')


class Product(Base):
    __tablename__ = 'products'
    __table_args__ = {'schema': 'northwind'}

    productid = Column(Integer, primary_key=True)
    productname = Column(String(35))
    supplierid = Column(ForeignKey('northwind.suppliers.supplierid'), nullable=False)
    categoryid = Column(ForeignKey('northwind.categories.categoryid'), nullable=False)
    quantityperunit = Column(String(20))
    unitprice = Column(Numeric(13, 4))
    unitsinstock = Column(SmallInteger)
    unitsonorder = Column(SmallInteger)
    reorderlevel = Column(SmallInteger)
    discontinued = Column(String(1))

    category = relationship('Category')
    supplier = relationship('Supplier')


class OrderDetail(Base):
    __tablename__ = 'order_details'
    __table_args__ = {'schema': 'northwind'}

    orderid = Column(ForeignKey('northwind.orders.orderid', ondelete='RESTRICT', onupdate='CASCADE'), ForeignKey('northwind.orders.orderid'), primary_key=True, nullable=False)
    productid = Column(ForeignKey('northwind.products.productid'), ForeignKey('northwind.products.productid', ondelete='RESTRICT', onupdate='CASCADE'), primary_key=True, nullable=False)
    unitprice = Column(Numeric(13, 4))
    quantity = Column(SmallInteger)
    discount = Column(Numeric(10, 4))

    order = relationship('Order', primaryjoin='OrderDetail.orderid == Order.orderid')
    order1 = relationship('Order', primaryjoin='OrderDetail.orderid == Order.orderid')
    product = relationship('Product', primaryjoin='OrderDetail.productid == Product.productid')
    product1 = relationship('Product', primaryjoin='OrderDetail.productid == Product.productid')

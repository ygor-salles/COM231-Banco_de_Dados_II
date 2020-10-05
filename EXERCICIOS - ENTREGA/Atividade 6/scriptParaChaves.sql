ALTER TABLE northwind.orders ADD FOREIGN KEY (customerid) REFERENCES northwind.customers;
ALTER TABLE northwind.orders ADD FOREIGN KEY (employeeid) REFERENCES northwind.employees;

ALTER TABLE northwind.order_details ADD FOREIGN KEY (orderid) REFERENCES northwind.orders;
ALTER TABLE northwind.order_details ADD FOREIGN KEY (productid) REFERENCES northwind.products;

ALTER TABLE northwind.products ADD FOREIGN KEY (categoryid) REFERENCES northwind.categories;
ALTER TABLE northwind.products ADD FOREIGN KEY (supplierid) REFERENCES northwind.suppliers;
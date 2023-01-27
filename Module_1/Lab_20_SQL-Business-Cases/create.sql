CREATE DATABASE lab_mysql;
USE lab_mysql;
Create table cars (
  ID int,
  VIN varchar(255),  
  manufacturer varchar (255),
  model varchar(255),
  year year,
  color varchar(255),
  primary key (ID)
);

drop table cars;

create Table customers (
  ID int,
  customer_id int,
  name varchar(255),
  phone varchar(255),
  email varchar(255),
  adress varchar(255),
  city varchar(255),
  state_province varchar(255),
  country varchar(255),
  postal int,
  primary key (ID)
  );
  
  drop table customers;
  
  Create Table Salesperson (
  id int,
  staff_id varchar(255),
  name varchar(255),
  store varchar(255),
  primary key (id)
  );
  
  drop table Salesperson;
  
 create Table Invoices (
  id int,
  invoice_number int,
  date date,
  Car int,
  customer int,
  Sales_person int,
  primary key (id),
  foreign key (customer) references customers (id),
  foreign key (car) references cars (id),
  foreign key (sales_person) references salesperson (id)
  );
  
  drop table Invoices;
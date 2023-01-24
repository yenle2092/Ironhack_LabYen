CREATE DATABASE lab_mysql;
USE lab_mysql;
Create table cars (
  VIN int,  
  product_id int,
  manufacturer varchar (255),
  year year,
  color varchar(255),
  primary key (VIN)
);

drop table car;

create Table customers (
  customer_id int,
  customer_name varchar(255),
  phone_number varchar(255),
  email varchar(255),
  adress varchar(255),
  city varchar(255),
  state_province varchar(255),
  country varchar(255),
  zip_code int,
  primary key (customer_id)
  );
  Create Table Salesperson (
  staff_id int,
  name_staff varchar(255),
  store varchar(255),
  primary key (staff_id)
  );
  
  alter table Salesperson
  add primary key (staff_id);
  
 create Table Invoices (
  invoice_number int,
  date date,
  VIN int, 
  customer_id int,
  staff_id int,
  primary key (invoice_number),
  foreign key (customer_id) references customers (customer_id),
  foreign key (VIN) references cars (VIN),
  foreign key (staff_id) references salesperson (staff_id)
  );
  
  drop table Invoices;
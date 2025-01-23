create database Tata;
show databases;
drop database Tata;
use Tata;
create table weather(city varchar(10),
state varchar(10), high int, low int);
show tables;
describe weather;
CREATE TABLE accounts (
    acc_no INT(5) PRIMARY KEY,
    balance DECIMAL(8.2)
);
drop table person;
CREATE TABLE person (
p_id int(4) PRIMARY KEY, 
pname varchar(40),
mobile_no int(10) unique, 
address varchar(100)
);


CREATE TABLE orders (
p_id int(3) PRIMARY KEY,
orderno int not null, 
FOREIGN KEY(p_id) references person(p_id)
);

describe person;
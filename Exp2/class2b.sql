CREATE DATABASE Tata;
SHOW DATABASES;
DROP DATABASE Tata;
USE Tata;

CREATE TABLE category_header (
    cat_code INT(5) PRIMARY KEY,
    cat_desc VARCHAR(20)
);
drop table category_header;
SHOW TABLES;

CREATE TABLE route_header (
    route_id INT(5) PRIMARY KEY,
    route_no INT(5),
    cat_code INT(5),
    origin VARCHAR(20),
    destination VARCHAR(20),
    fare INT(7),
    distance INT(3),
    capacity INT(3),
    FOREIGN KEY (cat_code) REFERENCES category_header(cat_code)
);

CREATE TABLE place_header (
    place_id INT(5) PRIMARY KEY,
    place_name VARCHAR(20) NOT NULL,
    place_address VARCHAR(50),
    bus_station VARCHAR(10)
);

CREATE TABLE fleet_header (
    fleet_id INT(5) PRIMARY KEY,
    day DATE,
    route_id INT(5),
    cat_code INT(5),
    FOREIGN KEY (route_id) REFERENCES route_header(route_id),
    FOREIGN KEY (cat_code) REFERENCES category_header(cat_code)
);

CREATE TABLE ticket_header (
    fleet_id INT(5),
    ticket_no INT(5) PRIMARY KEY,
    doi DATE NOT NULL,
    dot DATE NOT NULL,
    time_travel CHAR(8),
    board_place INT(20),
    origin VARCHAR(40),
    destination VARCHAR(40),
    adult INT(3),
    children INT(3),
    total_fare INT(7),
    route_id INT(5),
    FOREIGN KEY (fleet_id) REFERENCES fleet_header(fleet_id),
    FOREIGN KEY (route_id) REFERENCES route_header(route_id)
);

CREATE TABLE ticket_detail (
ticket_no int (5),
 name varchar (20), 
 sex char (1), 
 age int (3),
 fare int (5)
 );
 
 CREATE TABLE route_detail (
 route_id int (5), 
 place_id int(5),
 nonstop char (1)
);
show tables;

ALTER TABLE category_header MODIFY cat_desc VARCHAR(50);

CREATE TABLE Student_MPSTME (

student_number INT,
student_name VARCHAR(100),
student_address VARCHAR(255),
student_phone_number VARCHAR(15)

);

alter table Student_MPSTME add primary key (student_number);

create table Student_NMIMS as select student_number, student_name from Student_MPSTME;

rename table Student_MPSTME to Stu_MPSTME;

alter table Stu_MPSTME drop column student_phone_number;

drop table Stu_MPSTME;

alter table Stu_MPSTME add birth_date date;

drop table Stu_MPSTME;
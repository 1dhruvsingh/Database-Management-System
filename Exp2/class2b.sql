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
    route_id INT(10) PRIMARY KEY,
    route_no INT(10),
    cat_code INT(10),
    origin VARCHAR(20),
    destination VARCHAR(20),
    fare INT(10),
    distance INT(10),
    capacity INT(10),
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



insert into category_header(cat_code, cat_desc) values 
('05', 'premium'), 
('06', 'economy'), 
('07', 'express'), 
('08', 'basic');

-- Dhruv Singh 
INSERT INTO route_header (route_id, route_no, cat_code, origin, destination, fare, distance, capacity) 
VALUES 
    (201, 45, '05', 'Delhi', 'Mumbai', 150, 1500, 100),
    (202, 50, '06', 'Pune', 'Goa', 120, 500, 80),
    (203, 55, '07', 'Kochi', 'Mangalore', 100, 350, 60),
    (204, 60, '08', 'Chennai', 'Hyderabad', 110, 700, 90),
    (205, 65, '05', 'Bengaluru', 'Delhi', 180, 1500, 100),
    (206, 70, '06', 'Mumbai', 'Surat', 85, 200, 70),
    (207, 75, '07', 'Goa', 'Bengaluru', 150, 500, 80),
    (208, 80, '08', 'Kolkata', 'Patna', 90, 300, 75);

-- Dhruv Singh 
INSERT INTO place_header (place_id, place_name, place_address, bus_station)
VALUES
(07, 'Delhi', '14, main street', 'Connaught Place'),
(08, 'Mumbai', '45, sea view road', 'Andheri'),
(09, 'Pune', '21, market road', 'Shivaji Nagar'),
(10, 'Goa', '12, beach road', 'Panaji'),
(11, 'Kochi', '56, park avenue', 'Ernakulam'),
(12, 'Chennai', '89, station road', 'Egmore');

-- Dhruv Singh 
INSERT INTO fleet_header (fleet_id, day, route_id, cat_code)
VALUES
(11, '2025-02-06', 201, 05),
(12, '2025-02-06', 202, 06),
(13, '2025-02-06', 203, 07),
(14, '2025-02-06', 204, 08),
(15, '2025-02-06', 205, 05),
(16, '2025-02-06', 206, 06),
(17, '2025-02-06', 207, 07);

INSERT INTO ticket_header (fleet_id, ticket_no, doi, dot, time_travel, board_place, origin, destination, adult, children, total_fare, route_id)
VALUES
(11, 101, '2025-02-06', '2025-02-07', '08:00:00', 'Connaught Place', 'Delhi', 'Mumbai', 2, 1, 220, 201),
(12, 102, '2025-02-06', '2025-02-07', '09:30:00', 'Shivaji Nagar', 'Pune', 'Goa', 1, 2, 180, 202),
(13, 103, '2025-02-06', '2025-02-07', '15:00:00', 'Ernakulam', 'Kochi', 'Mangalore', 2, 0, 200, 203),
(14, 104, '2025-02-06', '2025-02-07', '22:00:00', 'Egmore', 'Chennai', 'Hyderabad', 3, 1, 350, 204);


-- Dhruv Singh 
INSERT INTO ticket_detail(ticket_no, name, sex, age, fare) 
VALUES
(101, 'Rajesh', 'M', 30, 20.00),
(101, 'Pooja', 'F', 28, 19.50),
(102, 'Amit', 'M', 35, 18.75),
(102, 'Suman', 'F', 24, 17.00),
(103, 'Vijay', 'M', 22, 16.50),
(103, 'Priya', 'F', 27, 18.00),
(104, 'Ravi', 'M', 45, 30.00);

--  Dhruv Singh 
INSERT INTO route_detail (route_id, place_id, nonstop)
VALUES
(201, 07, 'Y'),
(202, 08, 'N'),
(203, 11, 'Y'),
(204, 12, 'N'),
(205, 07, 'Y');

show tables;
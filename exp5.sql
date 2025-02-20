CREATE DATABASE Tata_dhruv;
SHOW DATABASES;
USE Tata_dhruv;

CREATE TABLE category_header (
    cat_code INT(5) PRIMARY KEY,
    cat_desc VARCHAR(20)
);

select * from category_header;
insert into category_header(cat_code, cat_desc) values ('01' , ' super delux'),('02' , 'delux'), ('03' , 'super fast'), ('04','normal');

/*dhruv*/  
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
/*dhruv*/
INSERT INTO route_header (route_id, route_no, cat_code, origin, destination, fare, distance, capacity) 
VALUES 
    (101, 33, '01', 'Madurai', 'Madras', 35, 250, 50),
    (102, 25, '02', 'Trichy', 'Madurai', 40, 159, 50),
    (103, 15, '03', 'Thanjavur', 'Madurai', 59, 140, 50),
    (104, 36, '04', 'Madras', 'Banglore', 79, 375, 50),
    (105, 40, '01', 'Banglore', 'Madras', 80, 375, 50),
    (106, 38, '02', 'Madras', 'Madurai', 39, 250, 50),
    (107, 39, '03', 'Hydrabad', 'Madras', 50, 430, 50),
    (108, 41, '04', 'Madras', 'Cochin', 47, 576, 50);
    SELECT route_id, fare, fare + 10 AS new_fare FROM route_header;
    select distinct destination from route_header;
    
    SELECT rh.*
FROM route_header rh
JOIN category_header ch ON rh.cat_code = ch.cat_code
WHERE ch.cat_desc = 'delux';
SELECT * FROM route_header ORDER BY distance DESC;
    
    



select * from route_header;


/*dhruv*/
CREATE TABLE place_header (
    place_id INT(5) PRIMARY KEY,
    place_name VARCHAR(20) NOT NULL,
    place_address VARCHAR(50),
    bus_station VARCHAR(10)
);
select place_name, place_address from place_header;
INSERT INTO place_header (place_id, place_name, place_address, bus_station)
VALUES
(01, 'Madras', '10, ptc road', 'Parrys'),
(02, 'Madurai', '21, canal bank road', 'Kknagar'),
(03, 'Trichy', '11, first cross road', 'Bheltown'),
(04, 'Banglore', '15, first main road', 'Cubbon'),
(05, 'Hydrabad', '115, lake view road', 'Charminar'),
(06, 'Thanjavur', '12, temple road', 'Railway');
select * from route_header;
SELECT rh.*, rd.place_id, rd.nonstop
FROM route_header rh
LEFT JOIN route_detail rd ON rh.route_id = rd.route_id;
/*dhruv*/  
SELECT route_id
FROM route_header
WHERE route_id IN (SELECT route_id FROM route_detail);


CREATE TABLE fleet_header (
    fleet_id INT(5) PRIMARY KEY,
    day DATE,
    route_id INT(5),
    cat_code INT(5),
    FOREIGN KEY (route_id) REFERENCES route_header(route_id),
    FOREIGN KEY (cat_code) REFERENCES category_header(cat_code)
);
INSERT INTO fleet_header (fleet_id, day, route_id, cat_code)
VALUES
(01, '1996-04-10', 101, 01),
(02, '1996-04-10', 101, 01),
(03, '1996-04-10', 101, 01),
(04, '1996-04-10', 102, 02),
(05, '1996-04-10', 102, 03),
(06, '1996-04-10', 103, 04);
select * from fleet_header;
/*dhruv*/
SELECT DISTINCT fh.*
FROM fleet_header fh
JOIN route_detail rd ON fh.route_id = rd.route_id
WHERE rd.nonstop = 'N';

CREATE TABLE ticket_header (
    fleet_id INT(5),
    ticket_no INT(5) PRIMARY KEY,
    doi DATE NOT NULL,
    dot DATE NOT NULL,
    time_travel CHAR(8),
    board_place varchar(20),
    origin VARCHAR(40),
    destination VARCHAR(40),
    adult INT(3),
    children INT(3),
    total_fare INT(7),
    route_id INT(5),
    FOREIGN KEY (fleet_id) REFERENCES fleet_header(fleet_id),
    FOREIGN KEY (route_id) REFERENCES route_header(route_id)
);
INSERT INTO ticket_header (fleet_id, ticket_no, doi, dot, time_travel, board_place, origin, destination, adult, children, total_fare, route_id)
VALUES
(01, 01, '1996-04-10', '1996-05-10', '15:00:00', 'Parrys', 'Madras', 'Madurai', 1, 1, 60, 101),
(02, 02, '1996-04-12', '1996-05-05', '09:00:00', 'Kknagar', 'Madurai', 'Madras', 2, 1, 60, 102),
(03, 03, '1996-04-21', '1996-05-15', '21:00:00', 'Cubbon park', 'Banglore', 'Madras', -4, 2, 400, 101);
select * from ticket_header;
/*dhruv*/
SELECT td.*, th.*
FROM ticket_detail td
JOIN ticket_header th ON td.ticket_no = th.ticket_no
WHERE td.name = 'Charu';

CREATE TABLE ticket_detail (
ticket_no int (5),
 name varchar (20), 
 sex char (1), 
 age int (3),
 fare int (5)
 );
 insert into ticket_detail(ticket_no, name, sex, age,fare) 
 VALUES
(01, 'Charu', 'F', 24, 14.00),
(01, 'Lathu', 'F', 10, 15.55),
(02, 'Anand', 'M', 28, 17.80),
(02, 'Guatham', 'M', 28, 16.00),
(02, 'Bala', 'M', 9, 17.65),
(05, 'Sandip', 'M', 30, 18.00);
update ticket_detail set fare = fare + 1 where name = 'Guatham';
update ticket_detail set age = 30 where name = 'Anand';

 select * from ticket_detail;
SELECT td.name
FROM ticket_detail td
JOIN ticket_header th ON td.ticket_no = th.ticket_no
JOIN route_header rh ON th.route_id = rh.route_id
WHERE rh.origin = 'Madurai' AND rh.destination = 'Madras';

 CREATE TABLE route_detail (
 route_id int (5), 
 place_id int(5),
 nonstop char (1)
);

INSERT INTO route_detail (route_id, place_id, nonstop)
VALUES
(105, 01, 'N'),
(102, 02, 'S'), 
(106, 01, 'S'),
(108, 05, 'N'),
(106, 02, 'N');
/*Dhruv*/
SELECT t1.*
FROM ticket_header t1
JOIN ticket_header t2 ON t1.origin = t2.destination;

SELECT ph.place_name
FROM route_detail rd
JOIN place_header ph ON rd.place_id = ph.place_id
WHERE rd.nonstop = 'S';

insert into route_detail (route_id, place_id, nonstop) values (105, 01, 'S');
delete from route_detail where route_id = 105 and place_id = 01 and nonstop = 'S';


describe route_detail;
select * from route_detail;
INSERT INTO category_header (cat_code, cat_desc) VALUES (05, 'fast');
describe category_header;
/**/
SELECT ch.cat_code, ch.cat_desc, rh.*
FROM category_header ch
LEFT JOIN route_header rh ON ch.cat_code = rh.cat_code;


select * from category_header;
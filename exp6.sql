create database sq;
use sq;
show databases;

/* table-1*/
create table category_header(cat_code int(5) primary key, cat_desc varchar(20));
show tables;
describe category_header;
insert into category_header(cat_code, cat_desc)
value (01,'superdulux'),(02,'delux'),(03,'superfast'),(04,'normal');
select *from category_header;


/* table-2*/

create table route_header(route_id int(5) primary key, route_no int(5),cat_code int(5),origin varchar(20), 
destination varchar(20), fare decimal(7,2),
distnace int(3),capacity int(3),foreign key(cat_code) references category_header(cat_code));
show tables;
describe route_header;
Insert into route_header(route_id, route_no ,cat_code,origin,destination, fare,distnace,
capacity)
values 
(101,33,01,'madhurai','madras',35,250,50),
(102,25,02,'trichy','madhurai',40,159,50),
(103,15,03,'thanjavur','madhurai',59,140,50),
(104,36,04,'madhurai','banglore',79,375,50),
(105,40,01,'banglore','madras',80,375,50),
(106,38,02,'madras','madhurai',39,250,50),
(107,39,03,'hydrabad','madras',50,430,50),
(108,41,04,'madras','cochin',47,576,50);
select*from route_header;

/* table-3*/
create table place_header(place_id int(5) primary key,place_name varchar(20) not null, 
place_address varchar(50), bus_station varchar(10));
alter table  place_header MODIFY COLUMN bus_station VARCHAR(20);
show tables;
describe place_header;
insert into place_header(place_id, place_name, place_address, bus_station)
values
(01, 'Madras', ' 10,PTC Road', 'Parrys'),
(02, 'Madurai', '21,Canal Bank Road','KK Nagar'),
(03, 'Trichy', '11,First Cross Road','Bhel Town'),
(04, 'Bangalore','15,First Main Road','Cubbon Park'),
(05, 'Hyderabad','115,Lake View Road','Charminar'),
(06, 'Thanjavur','12,Temple Road','Railway Jn');
select *from place_header;

/* table-4*/
create table fleet_header(fleet_id int(5) primary key, day date, route_id int(5), cat_code int(5),
foreign key(cat_code) references category_header(cat_code));
show tables;
describe fleet_header;
insert into fleet_header (fleet_id, Day, route_id, cat_code)
values
(1, '1996-04-10', '101', 1),
(2, '1996-04-10', '101', 1),
(3, '1996-04-10', '101', 1),
(4, '1996-04-10', '102', 2),
(5, '1996-04-10', '102', 3),
(6, '1996-04-10', '103', 4);
select *from fleet_header;

/* table-5*/
create table ticket_header( fleet_id int(5), ticket_no int (5) primary key, doi date not null, dot date not null ,
time_travel char(8), board_place varchar(20),origin varchar(40),destination varchar(40), adult int(3), childrean int(3),
 total_fare decimal(7,2),route_id int(5),foreign key(fleet_id) references fleet_header(fleet_id),
 foreign key(route_id) references route_header(route_id));
 show tables;
describe ticket_header;
insert  into ticket_header (fleet_id, ticket_no, doi, dot, time_travel, board_place, origin, 
destination, adult, childrean, total_fare, route_id)
values
('01', '01', '1996-04-10', '1996-05-10', '15:00:00', 'Parrys', 'Madras', 'Madurai', 1, 1, 60, 101),
('02', '02', '1996-04-12', '1996-05-05', '09:00:00', 'Kknagar', 'Madurai', 'Madras', 2, 1, 60, 102),
('03', '03', '1996-04-21', '1996-05-15', '21:00:00', 'Cubbon Park', 'Bangalore', 'Madras', 4, 2, 400, 101);

select *from ticket_header;

/* table-6*/
 create table ticket_detail(ticket_no int(5),name varchar(20), sex char(1),age int(3), fare decimal(5,2));
 show tables;
describe ticket_detail;

insert into ticket_detail(ticket_no, name, sex, age, fare)
values
(01,'Charu', 'F', 24, 14.00),
(01,'Lathu', 'F', 10, 15.55),
(02,'Anand', 'M', 28, 17.80),
(02, 'Guatham', 'M', 28, 16.00),
(02, 'Bala', 'M', 9, 17.65),
(05,'Sandip', 'M', 30, 18.00);
select *from ticket_detail;


/* table-7*/
create table route_detail(route_id int(5),place_id int(5),nonstop char(1));
show tables;
describe route_detail;
insert into route_detail(route_id, place_id, nonstop) 
values
(105, 01, 'N'),
(12,  02, 'S'),  
(106, 01, 'S'),
(108, 05, 'N'),
(106, 02, 'N');
select * from route_detail;

-- 1. Give average of the total fare.
SELECT AVG(total_fare) AS avg_total_fare FROM ticket_header;

-- 2. Give the total collection of fare.
SELECT SUM(total_fare) AS total_collection FROM ticket_header;

-- 3. Which bus runs for minimum distance?
SELECT * FROM route_header WHERE distnace = (SELECT MIN(distnace) FROM route_header);

-- 4. Give the total number of people who have traveled so far grouped by ticket number.
SELECT ticket_no, SUM(adult + childrean) AS total_passengers FROM ticket_header GROUP BY ticket_no;

-- 5. Find out total fare for routes with same origin.
SELECT origin, SUM(total_fare) AS total_fare FROM ticket_header GROUP BY origin;

-- 6. Find out total fare for routes with origin as madras.
SELECT SUM(total_fare) AS total_fare FROM ticket_header WHERE origin = 'Madras';

-- 7. Calculate average fare for each ticket.
SELECT ticket_no, AVG(fare) AS avg_fare FROM ticket_detail GROUP BY ticket_no;

-- 8. Find out details of fleets that run on route number 33 or 25.
SELECT * FROM fleet_header 
WHERE route_id IN (SELECT route_id FROM route_header WHERE route_no IN (33, 25));

-- 9. Count how many male or female passengers have traveled till now.
SELECT sex, COUNT(*) AS total_passengers FROM ticket_detail GROUP BY sex;

-- 10. Count total number of routes for each category except category 02.
SELECT cat_code, COUNT(*) AS total_routes FROM route_header WHERE cat_code != 2 GROUP BY cat_code;

-- 11. Find out place names for which nonstop buses run.
SELECT place_name FROM place_header 
WHERE place_id IN (SELECT place_id FROM route_detail WHERE nonstop = 'N');

-- 12. Find out details of tickets from ticket_header having more than two passengers.
SELECT * FROM ticket_header WHERE (adult + childrean) > 2;

-- 13. Find out details of routes having category code same as category code of a route having maximum distance.
SELECT * FROM route_header 
WHERE cat_code = (SELECT cat_code FROM route_header WHERE distnace = (SELECT MAX(distnace) FROM route_header));

-- 14. Display distinct ticket numbers from both ticket_header and ticket_detail.
SELECT DISTINCT ticket_no FROM ticket_header 
UNION 
SELECT DISTINCT ticket_no FROM ticket_detail;

-- 15. Display all ticket numbers from both ticket_header and ticket_detail.
SELECT ticket_no FROM ticket_header 
UNION ALL 
SELECT ticket_no FROM ticket_detail;

-- 16. Display only common fleet_id’s that are present in fleet_header and ticket_header.
SELECT DISTINCT f.fleet_id 
FROM fleet_header f
INNER JOIN ticket_header t ON f.fleet_id = t.fleet_id;


-- 17. Select distinct route_id from route_header and not in route_detail using both the tables.
SELECT DISTINCT route_id FROM route_header 
WHERE route_id NOT IN (SELECT DISTINCT route_id FROM route_detail);

-- 18. Display distinct route_id’s from route_header and route_detail.
SELECT DISTINCT route_id FROM route_header 
UNION 
SELECT DISTINCT route_id FROM route_detail;

-- 19. Display all category_code from route_header and category_header.
SELECT cat_code FROM route_header 
UNION 
SELECT cat_code FROM category_header;

-- 20. Display only common place_id’s that are present in place_header and route_detail.
SELECT DISTINCT p.place_id 
FROM place_header p
INNER JOIN route_detail r ON p.place_id = r.place_id;


-- 21. Select common ticket_numbers from ticket_header and ticket_detail where the route_id’s are smaller than the route_id which belongs to place_id as 01.
SELECT DISTINCT t.ticket_no 
FROM ticket_header t
INNER JOIN ticket_detail d ON t.ticket_no = d.ticket_no
WHERE t.route_id < (SELECT MIN(route_id) FROM route_detail WHERE place_id = 1);


-- 22. Select unique fleet_id’s from ticket_header and fleet_header where the route_id is greater than route_id’s in route_header which belongs to the category_code as 01.
SELECT DISTINCT fleet_id FROM ticket_header 
WHERE route_id > (SELECT MIN(route_id) FROM route_header WHERE cat_code = 1) 
UNION 
SELECT DISTINCT fleet_id FROM fleet_header;

-- 23. Create read-only view route_vw on table route_header to display route_id, origin, and destination.
CREATE VIEW route_vw AS 
SELECT route_id, origin, destination FROM route_header;

-- 24. Try to update any record of view route_vw and explain error message.
UPDATE route_vw SET origin = 'Chennai' WHERE route_id = 101;
/* This will give an error: "View is not updatable because it lacks a primary key or does not directly reference a base table column." */

-- 25. Create view route_vw2 on table route_header with columns route_no, cat_code, origin, and destination.
CREATE VIEW route_vw2 AS 
SELECT route_no, cat_code, origin, destination FROM route_header;

-- 26. Display records of view route_vw2.
SELECT * FROM route_vw2;

-- 27. Try to insert record into view route_vw2 and state the output if possible, else explain error message.
INSERT INTO route_vw2 (route_no, cat_code, origin, destination) VALUES (50, 1, 'Delhi', 'Mumbai');
/* This will give an error: "View is not insertable because it does not contain all NOT NULL columns of the base table." */

-- 28. Create view route_category_vw to display those routes which belong to category ‘delux’.
CREATE VIEW route_category_vw AS 
SELECT route_no, cat_code, origin, destination 
FROM route_header 
WHERE cat_code = (SELECT cat_code FROM category_header WHERE cat_desc = 'delux');
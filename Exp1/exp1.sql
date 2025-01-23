select user from mysql.user;
create user DB1 identified by 'password';
drop user DB1;
Grant all privileges on *.* to DB1;
Grant select, create, delete on *.* to DB1;
show grants for DB1;
select * from training.employee;

alter table training.employee
drop column name;

alter table training.employee
add emp_name character varying;

insert into training.employee
values (1,'Anuja');

---------------postgreSQL task(a) 20-06-2022-----------------------------------
select * from training.customers;

insert into training.customers
values (1,'Anuja',8806819169);

insert into training.customers
values
	(2,'Emils',7878345612),
	(3,'Luffy',8990786759),
	(4,'Zoro',7890679809),
	(5,'Sanji',9078097898);
	
select * from training.customers
order by cust_phone;

insert into training.customers
values
	(6,'Luffy',7575345612),
	(7,'Usopp',8550786759);
	
select distinct cust_name as our_customers
from training.customers;

select distinct on (cust_name) cust_name, cust_id
from training.customers
order by cust_name desc;

alter table training.customers
add gender char;

update training.customers
set gender = 'F'
where cust_id in (1);

select cust_id||' ---- '||cust_name as "first name" 
from training.customers
order by gender nulls first;

------------------ postgreSQL task(b) 20-06-2022 ------------------------------
select * from training.customers
order by cust_id;

alter table training.customers
add salary numeric;

update training.customers
set salary = 50500
where cust_id in (7);

select cust_id, cust_name, salary
from training.customers
where cust_id in (1,2,3)
and salary > 25000;

select * from training.customers
order by cust_id limit 5;

select * from training.customers
fetch first row only;

select cust_id , cust_name as first_name, salary
from training.customers
where salary between 20000 and 40000;
-- including min and mx values of range

select cust_id , cust_name as first_name, salary
from training.customers
where salary not between 20000 and 40000;

select * from training.customers
where cust_name like '%AN%';
-- no output row as LIKE is case sensitive by default

select * from training.customers
where cust_name not like '%uff%';

select * from training.customers
where cust_name ilike '%AN%';
--5	"Sanji"	9078097898	null	20000
--1	"Anuja"	8806819169	"F"	    20000
-- we get output rows because ILIKE is case INSENSITIVE

select * from training.customers
where cust_name not ilike '%UFF%';

select * from training.customers
where gender is null
and mod(salary,3) = 1
order by cust_id;
-- null values in where condition

select * from training.customers
order by cust_id offset 3;
-- showing results from row 4

select * from training.customers
order by cust_id desc offset 3;
-- cutting last 3 rows

select * from training.customers
order by salary desc
limit 3;

create table cust_bkp as
select * from training.customers
where salary > 20000;

drop table cust_bkp;

------------------------- task(c) 20-06-2022 ----------------------------------
select * from training.customers
order by cust_id;

create table department
( dept_id integer primary key,
dep_name character varying(100));

alter table training.customers
add dept_id integer;

create table training.dept as
select * from department;

drop table department;
select * from training.dept;

insert into department
values (100,'IT'),
	(101,'CSE'),
	(102,'EXTC'),
	(103,'MECH');
	
update training.customers
set dept_id = 103
where mod(cust_id,4) = 3;

insert into training.customers
values (8,'Nami',7778889991,'F',55000,null);

----- inner join
select c.cust_id, c.cust_name, c.salary, d.dept_id, d.dep_name
from training.customers c
inner join training.dept d
on c.dept_id = d.dept_id;

----- left join
select c.cust_id, c.cust_name, c.salary, d.dept_id, d.dep_name
from training.customers c
left join training.dept d
on c.dept_id = d.dept_id;

select c.cust_id, c.cust_name, c.salary, d.dept_id, d.dep_name
from training.dept d
left join training.customers c
on c.dept_id = d.dept_id;

----- right join
select c.cust_id, c.cust_name, c.salary, d.dept_id, d.dep_name
from training.customers c 
right join training.dept d
on c.dept_id = d.dept_id;

----- full join
select c.cust_id, c.cust_name, c.salary, d.dept_id, d.dep_name
from training.customers c 
full join training.dept d
on c.dept_id = d.dept_id;

insert into training.dept
values (104,null);


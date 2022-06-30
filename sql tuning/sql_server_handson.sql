select order_id,count(order_id) from sales.order_items
group by order_id
order by order_id;

select * from sales.order_items;
select * from sales.customers;--
select * from production.stocks;
select * from production.categories;
select * from production.brands;
select * from production.products;
select * from sales.stores;
select * from sales.staffs;
select * from sales.orders;--


update sales.customers
set street = '9273_Thorne Ave'
where customer_id = 1;

select customer_id, first_name, last_name, street
from sales.customers
where street like '%Thorne%';

select customer_id, first_name, last_name, street
from sales.customers
where street like '%!_%' escape '!';
--output: the only street name with _ in it's name

select * from production.stocks
where quantity between 5 and 20;

select customer_id, first_name, last_name 
from sales.customers
where phone is null; -- when is null is true

select customer_id, first_name, last_name 
from sales.customers
where phone = null; 
-- wont give any record as = null is considered false (use is null instead)

select customer_id, first_name, last_name from sales.customers
order by 1
offset 10 rows --- displaying records from 11th row onwards
fetch next 10 rows only; --- next 10 records from 11
-- output: records between 11 to 20

select top 10 customer_id, first_name, last_name from sales.customers
order by 1 desc;

select top 10 customer_id, first_name, last_name from sales.customers
where first_name like 'D%';
-- top: selecting top number of records

select top 10 customer_id, first_name, last_name from sales.customers
where first_name in ('Debra','Luke');

select customer_id, first_name, last_name from sales.customers
where first_name like '[A-D]%';
-- names in A-D first character , LIKE WITH REGEX

select customer_id, first_name, last_name from sales.customers
where first_name like '[A-D][K]%';
-- first letter in A-K and second letter as A
-- like is not case-sensitive here

select customer_id, first_name, last_name from sales.customers
where first_name like '[^A-D]%';
-- names in anything except A-D first character

select customer_id, len(first_name)length_of_first_name from sales.customers;
-- len : counting length

select customer_id, (first_name + ' ' + last_name)full_name from sales.customers;
-- concat two columns

select top 20 
* from production.products
order by 6;

select top 20 with ties
* from production.products
order by 6;
-- WITH TIES allows you to return more rows with values that match the last row in limited result set
-- mandatory order by clause

select top 10
* from production.products
where list_price > 250
order by 6;

select top 10 with ties
* from production.products
where list_price > 250
order by 6;

select top 10 percent customer_id, first_name, last_name from sales.customers
where first_name like 'D%';
-- total : 86
-- top 10 percent : 9

--------------------------------------------------------------

create procedure SelectAllCustomers @firstname nvarchar(50), @lastname nvarchar(50)
as
update sales.customers set last_name = @lastname
where first_name = @firstname;
go

exec SelectAllCustomers @firstname = 'Luke', @lastname = 'Simmerman';

select * from sales.customers where first_name  = 'Luke';

--drop procedure SelectAllCustomers;

create procedure Experiment @cust_id int
as
select s.customer_id, s.first_name, s.last_name, o.order_id
from sales.customers s, sales.orders o
where s.customer_id = o.customer_id
and s.customer_id = @cust_id;
go

exec Experiment @cust_id = 1;

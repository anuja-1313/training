-- making a table
create table employee
(emp_id number,
emp_name varchar2(30),
age int,
joining_date date,
department_id number,
salary number
);

drop table customer;
drop table employee;

select * from employee;

select level as emp_id,
dbms_random.string('U', 5) as Name,
trunc(dbms_random.value(21,60)) as age,
sysdate-trunc(dbms_random.value(1,60)) as Joining_date,
trunc(dbms_random.value(1,10)) as Department,
trunc(dbms_random.value(20000,100000)) as Salary
from dual
connect by level <= 1000000;

--inserting values--------------------------------------------------------------
insert into employee
select level as emp_id,
dbms_random.string('U', 5) as Name,
trunc(dbms_random.value(21,60)) as age,
sysdate-trunc(dbms_random.value(1,60)) as Joining_date,
trunc(dbms_random.value(1,10)) as Department,
trunc(dbms_random.value(20000,100000)) as Salary
from dual
connect by level <= 1000000;

--------------------------------------------------------------------------------
select emp_name,department_id from employee 
where department_id = 9;

select * from employee 
where department_id = 9;
--cardinality: 123357, cost: 1320
--cardinality: estimated number of rows a step will return

select * from employee
where emp_id = 720;
--cardinality: 53, cost: 1317

select * from employee 
where age = 23;

--------------------------------------------------------------------------------
--creating index on department_id
-- primary key on emp_id (automatic index)
create index index_emp_dept_id on employee(department_id);

alter table employee
add constraint pk_id primary key (emp_id);-- making emp_id a priamry key

select * from employee 
where department_id = 9;
-- cardinality: 123357, cost: 392

select * from employee
where emp_id = 720;
--cardinality: 1, cost: 3

select * from employee
where to_char(emp_id) = 720;
-- functions like to_char adds on to the cost
--cardinality: 1, cost: 1323 

--set autotrace traceonly explain -- not supported

explain plan for select * from employee;
select * from table(dbms_xplan.display);
/* OUTPUT:

Plan hash value: 2119105728
 
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          |  1110K|    82M|  1319   (1)| 00:00:16 |
|   1 |  TABLE ACCESS FULL| EMPLOYEE |  1110K|    82M|  1319   (1)| 00:00:16 |
------------------------------------------------------------------------------
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
 */  
   

-------------------------------------
/*plan hash value:
when we execute a sql statement in oracle, a hash value is being assigned to that
sql statement and stored into the library cache. Later, if another user requests
the same query, Oracle finds the hash value and executes the same execution plan

autotrace: statement tracing, instantaneous feedback on any successful
SELECT, INSERT, UPDATE, DELETE

set autotrace (a part of explain plan, query for sqlplus)

explain plan:
displays execution plan chosen by Oracle for SELECT, UPDATE, INSERT, DELETE
statements
*/
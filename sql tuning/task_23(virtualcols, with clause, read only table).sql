select * from book_masters;
select * from book_transactions;

alter table book_masters
add book_cost number;

update book_masters
set book_cost = 500
where book_code = 3;

---------------------- virtual column ------------------------------------------

alter table book_masters
add ( book_cost_with_taxes as (book_cost*1.18));

--drop table book_masters;
--drop table book_transactions;

alter table book_masters
add number_of_pages number;

update book_masters
set number_of_pages = 530
where book_code = 3;

alter table book_masters
add (book_length as (
case 
  when number_of_pages <= 500 then 'Small'
  when number_of_pages > 500 and number_of_pages <=600 then 'Medium'
  when number_of_pages > 600 then 'Long'
end)
);

insert into book_masters(book_code,book_name,book_pub_year,book_pub_author,
book_cost,number_of_pages)
values(7,'Black Cake',2022,'Wilkerson',750,385);

desc book_masters;

------------------------- with clause ------------------------------------------

select bm.book_code, bm.book_name, bt.student_code, bt.book_issue_date 
from book_masters bm, book_transactions bt
where bm.book_code = bt.book_code;

with book_record as
(select bm.book_code, bm.book_name, bt.student_code, bt.book_issue_date 
from book_masters bm, book_transactions bt
where bm.book_code = bt.book_code)
select book_code, book_name, student_code
from book_record
where extract(day from book_issue_date) > 5
order by book_code;

------------------------ read only table ---------------------------------------

alter table book_masters
read only;

insert into book_masters(book_code,book_name,book_pub_year,book_pub_author,
book_cost,number_of_pages)
values(8,'The Shining',1980,'Stephen King',800,659);
/*
*Cause:    An attempt was made to update a read-only materialized view.
*Action:   No action required. Only Oracle is allowed to update a
           read-only materialized view.
*/
alter table book_masters
read write;

insert into book_masters(book_code,book_name,book_pub_year,book_pub_author,
book_cost,number_of_pages)
values(8,'The Shining',1980,'Stephen King',800,659);


-- Q1) who is most senior employeed basised on job title

select * from employee
order by levels desc
limit 1;


--Q2) which country have most invoices

Select billing_country,count(total) as total_invoices 
from invoice
group by billing_country
order by total_invoices desc;

--Q3) what are the top 3 values in total invoice

select total from invoice
order by total desc limit 3;

--Q4) write a query that return one city that have highest sum of invoice total


select billing_city,sum(total) as total_invoices
from invoice
group by billing_city
order by total_invoices desc limit 1;

--Q5) write a query that will return  the person who spent the most money

select c.customer_id,c.first_name,c.last_name,sum(i.total) as total_invoice
from invoice i
join customer c on c.customer_id=i.customer_id
 group by c.customer_id
 order by total_invoice desc limit 1 ;

--Q6) 
 
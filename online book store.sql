Create table books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


Select * from books;
Select * from Customers;
Select * from orders;

--Retrive all books in 'fiction' genre

select * from books
where genre='Fiction';

--Find books published after the year 1950

Select * from books 
where published_year > 1950;

--List all customers from the Canada

Select * from customers
where country ='Canada';

--Show orders placed in November 2023

select * from orders
where order_id='Novermber';


--  Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;

--  Find the details of the most expensive book:


SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

--  Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders 
WHERE quantity>1;

--  Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders 
WHERE total_amount>20;

-- List all genres available in the Books table:
SELECT DISTINCT genre
FROM Books;

-- Find the book with the lowest stock:

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;

-- Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) As Revenue 
FROM Orders;


-- Advance Questions : 

-- Retrieve the total number of books sold for each genre:

SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


--  Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';


--  List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- Find the most frequently ordered book:


SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

--  Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

--Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity) as total_sum
from orders o
join books b on o.book_id=b.book_id
group by b.author ;


--List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- Find the customer who spent the most on orders:


select c.customer_id,c.name,sum(o.total_amount) as total_spent
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc limit 1;

-- Calculate the stock remaining after fulfilling all orders:

select b.book_id, b.title, b.stock,COALESCE(sum(o.quantity),0) as order_quantity,
b.stock-COALESCE(sum(o.quantity),0) as remaining_quantity

from orders o
left join books b on b.book_id = o.book_id
group by b.book_id
order by b.book_id;

















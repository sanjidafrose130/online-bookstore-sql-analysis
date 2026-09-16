Create Database Online_bookstore;
Use Online_bookstore
Select * from books;
Select * from Customers;
Select * from Orders;

-- All books belonging to fiction genre
Select * from books
Where Genre='Fiction';

-- Books cost more than $20 
Select * from books
Where Price > 20;

--List all the customers from Canada
Select * from Customers
Where Country='Canada';

-- Show orders placed in November 2023:
Select * from Orders
Where Order_date between '2023-11-01' And '2023-11-30';

-- Retrieve the total stock of books available:
Select sum(stock) as Total_Stocks
from books;

-- Display the the 5 most expensive books
Select * from books
Order by Price desc
Limit 5;

--  Show all customers who ordered more than 1 quantity of a book
Select * from Orders
Where Quantity >1;

-- List all genres available in the Books table
Select distinct genre from books;

-- Calculate the total revenue generated from all orders
Select sum(total_amount) as revenue 
From orders;

-- Retrieve the total number of books sold for each genre
Select * from Orders;
select b.genre, sum(o.quantity) as Total_Books_Sold
from orders o
join books b on b.book_id=o.book_id
group by b.genre;

-- Find the average price of books in the "Fantasy" genre
select avg (price) as Averge_Price
from books
Where genre='Fantasy';

 -- List customers who have placed at least 2 orders
Select Customer_id,count(order_id) as order_count
From Orders
Group by Customer_id
Having Count(Order_id)>=2;

-- Find the top 5 most frequently ordered book
select o.book_id,b.title,Count(o.order_id) as Order_count
From Orders o
Join books b
On o.book_id=b.book_id
Group by o.book_id, b.title
Order by Order_count Desc
Limit 5;

-- Retrieve the total quantity of books sold by each author
select b.author,sum(o.quantity) as Total_books_sold
From Orders o
Join books b
On o.book_id=b.book_id
Group by b.author;

-- List the cities where customers who spent over $30 are located
Select distinct c.city, total_amount
From Orders o
Join customers c on c.customer_id=o.customer_id
Where o.total_amount >30;

-- Calculate the stock remaining after fulfilling all orders
Select b.book_id,b.title,b.stock,
Coalesce(Sum(o.quantity),0) As Total_Sold,
b.stock-Coalesce(Sum(o.quantity),0) As Remaining_Stock
From books b
Left Join orders o 
On b.book_id=o.book_id
Group by b.book_id,b.title,b.stock;

-- Calculate the books which have low stock but high sales
Select b.book_id,b.title,b.stock,
Coalesce(Sum(o.quantity),0) As Total_Sold
From books b
Left Join Orders o
On b.book_id=o.book_id
Group by b.book_id,b.title,b.stock
Having b.stock < 10
And Sum(O.quantity) >10;
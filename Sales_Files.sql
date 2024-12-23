create table customer (Customerid int primary key,Name varchar,Age varchar,Gender varchar, Region varchar,Email varchar);
create table Products (ProductID int primary key, ProductName varchar, Category varchar, Price int,StockQuantity int);
create table sales (SaleID int primary key, Date date, CustomerID int, ProductID int, Quantity int,TotalAmount int);
create table returns (ReturnID int primary key, SaleID int, ReturnDate date, Reason varchar);

\copy customer from '/Users/vipinhedaoo/Documents/Data_Analytics/Mock_assessment/customers.csv' Delimiter ',' csv header;
\copy Products from '/Users/vipinhedaoo/Documents/Data_Analytics/Mock_assessment/products (1).csv' Delimiter ',' csv header;
\copy sales from '/Users/vipinhedaoo/Documents/Data_Analytics/Mock_assessment/sales.csv' Delimiter ',' csv header;
\copy returns from '/Users/vipinhedaoo/Documents/Data_Analytics/Mock_assessment/returns.csv' Delimiter ',' csv header;


select * from customer;
select * from Products;
select * from sales;
select * from returns;

--Q1 Write a query to calculate monthly sales trends for each region and product category.

select to_char(s.Date, 'YYYY-MM') as Month,c.Region,p.Category, sum(s.TotalAmount) as TotalSales from sales s
join customer c on s.CustomerID = c.Customerid
join products p on s.ProductID = p.ProductID
group by to_char(s.Date, 'YYYY-MM'), c.Region, p.Category
order by Month, c.Region, p.Category;

--Q2 Identify top 5 customers contributing to revenue using window functions.

with CustomerRevenue as (select s.CustomerID,c.Name as CustomerName,sum(s.TotalAmount) as TotalRevenue,
                         RANK() over (ORDER BY SUM(s.TotalAmount) DESC) AS Rank from sales s 
	                     join customer c on s.CustomerID = c.Customerid
                         group by s.CustomerID, c.Name
)

SELECT CustomerID,CustomerName,TotalRevenue FROM CustomerRevenue
WHERE Rank <= 5;

--Q3 Create a query to predict stock-out risks based on sales trends using aggregate and ranking functions.


--Q4 Find products with highest return rates by percentage and classify reasons for returns.

select reason,count(returnid) from returns
group by reason;

--Q5 Implement a trigger to update stock automatically after each sale or return.






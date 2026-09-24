Create Table Pizza_sales(
	pizza_id int primary key,
	order_id int not null,
	pizza_name_id varchar(50),
	quantity int,
	order_date date,
	order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(20),
	pizza_category  varchar(50),
	pizza_ingredients varchar(50),
	pizza_name varchar(50)
	
);
drop table Pizza_sales;
select * from Pizza_sales;

ALTER TABLE pizza_sales
ALTER COLUMN pizza_ingredients TYPE TEXT;

--Total Revenue
Select sum(total_price) as Total_Revenue 
from pizza_sales;

--Avg order value
Select sum(total_price)/count(distinct order_id) as avg_order_value 
from pizza_sales;

--Total Pizza sold
Select sum(quantity) as Total_pizza_sold 
from pizza_sales;

--Total oder
Select count(Distinct order_id) as Total_order
from pizza_sales;

--TOtal pizza per order
Select cast(cast(sum(quantity) AS decimal(10,2))/
cast(count(Distinct order_id)As Decimal(10,2)) As decimal(10,2))  as Total_pizza_per_order
from pizza_sales;

--Daily Trend order name
Select To_char(order_date,'day') as order_day , Count(Distinct order_id) As total_order
from pizza_sales
group by To_char(order_date,'day');

--Monthly trend order
Select To_char(order_date,'month') as order_day , Count(Distinct order_id) As total_order
from pizza_sales
group by To_char(order_date,'month')
order by total_order DESC;

--Percentage of trend by sales category
Select pizza_category ,sum(total_price) As total_sales, sum(total_price) * 100/
(Select sum(total_price) from pizza_sales where Extract(Month from order_date) =1 ) AS Pct
from pizza_sales
where extract(month from order_date)= 1
Group by pizza_category;

--pizza size
Select pizza_size ,cast(sum(total_price) AS decimal(10,2)) As total_sales, cast(sum(total_price) * 100/
(Select sum(total_price) from pizza_sales Where Extract(quarter from order_date) =1) AS decimal(10,2)) AS Pct
from pizza_sales
Where Extract(quarter from order_date) =1
Group by pizza_size
order by Pct Desc;

--Top5 best sellers by revenue,total quantity and total order
Select pizza_name, sum(total_price) As Total_revenue 
from pizza_sales
Group by pizza_name
order by Total_revenue asc
Limit 5;


Select pizza_name, sum(quantity) As Total_quantity
from pizza_sales
Group by pizza_name
order by Total_quantity asc
Limit 5;


Select pizza_name, Count(Distinct order_id) As Total_order 
from pizza_sales
Group by pizza_name
order by Total_order desc
Limit 5;













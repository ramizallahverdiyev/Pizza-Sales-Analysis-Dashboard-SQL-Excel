USE Pizza
--KPI Queries Start

--1. Total Revenue
--The sum of the total price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales


--2. Average Order Value
--The average amount spent per order, calculated by dividing the total revenue by the total numbers of orders.
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value  FROM pizza_sales


--3.Total Pizzas Sold
--The sum of quantities of all pizzas sold.
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

--4.Total Orders
--The total numbers of orders placed.
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

--5.Average Pizzas Per Order
--The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.
SELECT CAST(CAST(SUM(quantity) AS decimal(10,2))/
COUNT(DISTINCT order_id) AS decimal(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales

--KPI Queries End

--Trends for Total Orders Queries Start


--1.Daily Trend
SELECT DATENAME(WEEKDAY, order_date) AS Order_day,COUNT(DISTINCT order_id) AS Total_Orders  FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)


--2.Hourly Trend 
SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


--3.Percentage of Sales by Pizza Category
SELECT pizza_category,CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT 
FROM pizza_sales
GROUP BY pizza_category


--4.Percentage of Sales by Pizza Size
SELECT pizza_size,CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC


--5.Total Pizzas Sold by Pizza Category
SELECT pizza_category,SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_category


--6.Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC


--7. Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC

--Trends for Total Orders Queries End


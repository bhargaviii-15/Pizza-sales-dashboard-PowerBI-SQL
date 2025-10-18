/*To check the table content*/
SELECT * 
FROM pizza_sales

--To find total revenue
SELECT 
SUM(total_price) AS TotalRevenue
FROM pizza_sales

--Find the total orders
SELECT 
COUNT( DISTINCT order_id) AS TotalOrders
FROM pizza_sales

--find average order value
SELECT 
Round(SUM(total_price)/ COUNT( DISTINCT order_id), 2) AS Avg_OrderValue
FROM pizza_sales

--Total pizzas sold
SELECT 
SUM(quantity) AS TotalPizzaSold
FROM pizza_sales

--Average pizzas per order
SELECT 
CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT( DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL (10,2))AS Avg_Pizza_PerOrder
FROM pizza_sales

--daily trends for the order
SELECT
DATENAME(DW, order_date) AS OrderDay ,
COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly orders total
SELECT
DATENAME(Month, order_date) AS Month_Name,
COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY DATENAME(Month, order_date)
ORDER BY TotalOrders DESC

--percentage sales by pizza category
SELECT
pizza_category,
CONCAT(ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales),2) ,'%')AS TotalSales
FROM pizza_sales
GROUP BY pizza_category

--percentage sales by pizza size
SELECT
pizza_size,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1),2) AS TotalSales
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY TotalSales DESC

--top 5 best sold pizza
SELECT TOP 5
 pizza_name AS Top5,
 SUM(total_price) AS TotalRevenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalRevenue DESC

--bottom 5 sold pizza
SELECT TOP 5
 pizza_name AS Top5,
 SUM(total_price) AS TotalRevenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalRevenue 

--top 5 pizzas based on quantity
SELECT TOP 5
 pizza_name AS Top5,
 SUM(quantity) AS TotalQuantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalQuantity DESC

--bottom 5 based on quantity
SELECT TOP 5
 pizza_name AS Top5,
 SUM(quantity) AS TotalQuantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalQuantity 

--top 5 pizzas based on orders
SELECT TOP 5
 pizza_name AS Top5,
 COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalOrders DESC

--bottom 5 pizzas based on orders
SELECT TOP 5
 pizza_name AS Top5,
 COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY TotalOrders 




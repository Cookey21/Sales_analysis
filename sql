--List all suppliers in the UK
SELECT [ContactName],[Country]
FROM Supplier
WHERE [Country] LIKE '%UK'

--List the first name, last name, and city for all customers. Concatenate the first
--and last name separated by a space and a comma as a single column
SELECT [FirstName] + ',' + ' ' + [LastName] +',' + ' ' + [City] AS 'Concatenated_column'
FROM Customer

--List all customers in Sweden
SELECT CONCAT ([FirstName], ' ', [LastName]) AS 'Customer_name', [Country]
FROM Customer
WHERE [Country] = 'Sweden';

--List all suppliers in alphabetical order
SELECT[ContactName]
FROM Supplier
ORDER BY [ContactName];

--List all orders with customers information
SELECT CONCAT ([FirstName], ' ', [LastName]) AS 'Customer_name', [OrderNumber], [City], [Country], [Phone]
FROM [dbo].[Order] AS O
JOIN [dbo].[Customer] AS C ON O.[CustomerId] = C.[Id];

-- List all orders with product name, quantity, and price, sorted by order number
SELECT P.UnitPrice AS Price, [Quantity], [OrderNumber], [ProductName]
FROM [dbo].[OrderItem] AS OI
JOIN [dbo].[Order] ON OI.OrderId = [dbo].[Order].Id
JOIN Product AS P ON OI.ProductId = P.Id
ORDER BY [OrderNumber]

--Using a case statement, list all the availability of products. When 0 then not
--available, else available
SELECT [ProductName], [IsDiscontinued],
CASE
WHEN [IsDiscontinued] = 0 THEN 'Not_Available'
WHEN [IsDiscontinued] = 1 THEN 'Available'
END AS 'Availability'
FROM [dbo].[Product]

--List all products that are packaged in Bottles
SELECT [ProductName], [Package]
FROM [dbo].[Product]
WHERE [Package] LIKE '%Bottles'

--List procucts name, unitprice and packages for products that starts with G
SELECT [ProductName], [Package], P.UnitPrice
FROM [dbo].[Product] AS P
WHERE [ProductName] LIKE 'G%'

--List the number of products for each supplier, sorted high to low
SELECT [ContactName], COUNT (*) AS Product_number
FROM [dbo].[Product] AS P
JOIN Supplier AS S ON P.SupplierId = S.Id
GROUP BY [ContactName]
ORDER BY Product_number DESC

--List the number of customers in each country, sorted low to high.
SELECT [Country], COUNT (*) AS Customer_number
FROM [dbo].[Customer]
GROUP BY [Country]
ORDER BY Customer_number ASC

-- List the total order amount for each customer, sorted high to low.
SELECT [FirstName], [LastName], SUM ([Quantity]) AS 'total_orders'
FROM [dbo].[Order] AS O
JOIN Customer ON O.CustomerId = Customer.Id
JOIN  OrderItem  AS OI ON O.Id  = OI.OrderId
GROUP BY [FirstName], [LastName]
ORDER BY SUM([Quantity]) DESC

--List all countries with more than 3 suppliers.
SELECT [Country], COUNT(*) AS Suppliers_number
FROM [dbo].[Supplier]
GROUP BY [Country]
HAVING COUNT (*) > 3

SELECT [Country], COUNT([ContactName]) AS Suppliers_number
FROM [dbo].[Supplier]
GROUP BY [Country]
HAVING COUNT ([ContactName]) > 3

--List the number of customers in each country. Only include countries with more
--than 7 customers.
SELECT [Country], COUNT(*) AS Customer_number
FROM [dbo].[Customer]
GROUP BY [Country]
HAVING COUNT (*) > 7

--List the number of customers in each country, except the Germany, sorted high
--to low. Only include countries with 9 or more customers.
SELECT [Country], COUNT(*) AS Customer_number
FROM [dbo].[Customer]
GROUP BY [Country]
HAVING [Country] NOT LIKE 'Germany%'
AND COUNT(*) >= 9
ORDER BY Customer_number

--List customer with average orders between $1000 and $1200.
SELECT [FirstName], [LastName], AVG([TotalAmount]) AS avg_amount
FROM [dbo].[Order] AS O
JOIN Customer AS C ON O.CustomerId = C.Id
GROUP BY [FirstName], [LastName]
HAVING AVG([TotalAmount]) BETWEEN $1000 AND $1200

--Get the number of orders and total amount sold between Jan 1, 2013 and Dec
--31, 2013.
SELECT SUM([TotalAmount]) AS total_amount, COUNT(*) AS order_amount
FROM [dbo].[Order] 
WHERE [OrderDate] >= '2013-01-01' AND [OrderDate] <= '2013-12-31' 



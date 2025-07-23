CREATE DATABASE WholesaleDB;
GO
USE WholesaleDB;

CREATE TABLE Orders (
    InvoiceID VARCHAR(50),
    CustomerID VARCHAR(50),
    OrderDate DATE,
    Category VARCHAR(100),
    ProductName VARCHAR(255),
    Quantity INT,
    Price DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    Country VARCHAR(100)
);
ALTER TABLE WholesaleOrders
ALTER COLUMN Customer_Status VARCHAR(50);

ALTER TABLE WholesaleOrders
ALTER COLUMN Customer_ID VARCHAR(50);

ALTER TABLE WholesaleOrders
ALTER COLUMN Delivery_Date DATE;

ALTER TABLE WholesaleOrders
ALTER COLUMN Order_ID VARCHAR(100);

ALTER TABLE WholesaleOrders
ALTER COLUMN Product_ID VARCHAR(255);

ALTER TABLE WholesaleOrders
ALTER COLUMN Quantity_Ordered INT;

ALTER TABLE WholesaleOrders
ALTER COLUMN Total_Retail_Price_for_This_Order DECIMAL(10,2);

ALTER TABLE WholesaleOrders
ALTER COLUMN Cost_Price_Per_Unit DECIMAL(10,2);

SELECT * FROM wholesaleorders;

--1. Total Sales

SELECT SUM(Total_Retail_Price_for_This_Order) AS Total_Sales
FROM wholesaleorders;

--2. Monthly Sales Trend

SELECT 
  YEAR(Delivery_Date) AS SalesYear, 
  MONTH(Delivery_Date) AS SalesMonth, 
  SUM(Total_Retail_Price_for_This_Order) AS MonthlySales
FROM WholesaleOrders
GROUP BY YEAR(Delivery_Date), MONTH(Delivery_Date)
ORDER BY SalesYear, SalesMonth;

--3. Top 10 Customers by Revenue

SELECT TOP 10 Customer_ID, SUM(Total_Retail_Price_for_This_Order) AS TotalSpent
FROM WholesaleOrders
GROUP BY Customer_ID
ORDER BY TotalSpent DESC;


--4. Top-Selling Product Categories

SELECT TOP 10 Product_ID, SUM(Quantity_Ordered) AS TotalUnitsSold
FROM WholesaleOrders
GROUP BY Product_ID
ORDER BY TotalUnitsSold DESC;

--5. Average Order Value (AOV)

SELECT AVG(Total_Retail_Price_for_This_Order) AS AverageOrderValue
FROM WholesaleOrders;


--6. Customer_Status:

SELECT Customer_Status, COUNT(DISTINCT Customer_ID) AS UniqueCustomers
FROM WholesaleOrders
GROUP BY Customer_Status
ORDER BY UniqueCustomers 

--7. Calculate Profit per Order and Total Profit by Customer

SELECT 
    Customer_ID,
    Order_ID,
    (Total_Retail_Price_for_This_Order - (Cost_Price_Per_Unit * Quantity_Ordered)) AS ProfitPerOrder
FROM WholesaleOrders
ORDER BY ProfitPerOrder DESC;

--8. Repeat Customers (Ordered more than once)

SELECT Customer_ID, COUNT(*) AS OrdersCount
FROM WholesaleOrders
GROUP BY Customer_ID
HAVING COUNT(*) > 1
ORDER BY OrdersCount DESC;

--9. Highest Revenue Products

SELECT TOP 10 Product_ID, SUM(Total_Retail_Price_for_This_Order) AS ProductRevenue
FROM WholesaleOrders
GROUP BY Product_ID
ORDER BY ProductRevenue DESC;

--10. Daily Average Order Quantity

SELECT Delivery_Date, AVG(Quantity_Ordered) AS AvgQtyPerDay
FROM WholesaleOrders
GROUP BY Delivery_Date
ORDER BY Delivery_Date;

--Step 1: Create the Customers Table
 
CREATE TABLE Customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerEmail VARCHAR(100),
    CustomerStatus VARCHAR(50)
);

--Step 2: Insert Sample Data into Customers

INSERT INTO Customers (Customer_ID, CustomerName, CustomerEmail, CustomerStatus)
VALUES
    ('C101', 'Alice Smith', 'alice.smith@example.com', 'Active'),
    ('C102', 'Bob Johnson', 'bob.johnson@example.com', 'Active'),
    ('C103', 'Charlie Lee', 'charlie.lee@example.com', 'Inactive'),
    ('C104', 'Diana Clark', 'diana.clark@example.com', 'Active');


--Step 3: Run a JOIN Query to Test

SELECT o.Order_ID, o.Customer_ID, c.CustomerName, o.Quantity_Ordered, o.Total_Retail_Price_for_This_Order
FROM WholesaleOrders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Quantity_Ordered > 10;

SELECT * FROM Customers;

SELECT COUNT(*) AS OrdersCount FROM WholesaleOrders;
SELECT COUNT(*) AS CustomersCount FROM Customers;

SELECT DISTINCT o.Customer_ID
FROM WholesaleOrders o
LEFT JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

SELECT TOP 10 * FROM WholesaleOrders;
SELECT TOP 10 * FROM Customers;

--1. SELECT, WHERE, JOINs

SELECT 
    o.Order_ID, 
    o.Customer_ID, 
    c.CustomerName, 
    o.Quantity_Ordered, 
    o.Total_Retail_Price_for_This_Order
FROM WholesaleOrders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Quantity_Ordered > 10;

--2. GROUP BY, COUNT, SUM, AVG

SELECT 
    o.Customer_ID,
    c.CustomerName,
    COUNT(o.Order_ID) AS TotalOrders,
    SUM(o.Total_Retail_Price_for_This_Order) AS TotalSales,
    AVG(o.Quantity_Ordered) AS AvgQuantity
FROM WholesaleOrders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.CustomerName
ORDER BY TotalSales DESC;

--3. CASE WHEN, aliases

SELECT 
    Order_ID,
    Quantity_Ordered,
    CASE 
        WHEN Quantity_Ordered >= 50 THEN 'Large Order'
        ELSE 'Small Order'
    END AS OrderSize
FROM WholesaleOrders;

--4. Subqueries

SELECT Customer_ID, SUM(Total_Retail_Price_for_This_Order) AS TotalSpent
FROM WholesaleOrders
GROUP BY Customer_ID
HAVING SUM(Total_Retail_Price_for_This_Order) > (
    SELECT AVG(CustomerTotal) FROM (
        SELECT Customer_ID, SUM(Total_Retail_Price_for_This_Order) AS CustomerTotal
        FROM WholesaleOrders
        GROUP BY Customer_ID
    ) AS CustomerTotals
);

--5. CTEs (Common Table Expressions)

WITH CustomerProfit AS (
    SELECT 
        Customer_ID,
        SUM(Total_Retail_Price_for_This_Order - (Cost_Price_Per_Unit * Quantity_Ordered)) AS TotalProfit
    FROM WholesaleOrders
    GROUP BY Customer_ID
)
SELECT 
    c.CustomerName,
    cp.TotalProfit,
    RANK() OVER (ORDER BY cp.TotalProfit DESC) AS ProfitRank
FROM CustomerProfit cp
JOIN Customers c ON cp.Customer_ID = c.Customer_ID;

--6. Window Functions

SELECT 
    Delivery_Date,
    Order_ID,
    Total_Retail_Price_for_This_Order,
    SUM(Total_Retail_Price_for_This_Order) OVER (ORDER BY Delivery_Date ROWS UNBOUNDED PRECEDING) AS RunningTotalSales
FROM WholesaleOrders
ORDER BY Delivery_Date;


--
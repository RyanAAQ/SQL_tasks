-- Question 1: Show all data in each of the tables
SELECT * FROM CUSTOMER;
SELECT * FROM INVOICE;
SELECT * FROM INVOICE_ITEM;

-- Question 2: LastName, FirstName and Phone
SELECT LastName, FirstName, Phone
FROM CUSTOMER;

-- Question 3:  LastName, FirstName and Phone of customers with firstName matching "Nikki"
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE FirstName = 'Nikki';

-- Question 4: LastName, FirstName, Phone, DateIn, and DateOut of all orders in excess of $100.00
SELECT LastName, FirstName, Phone, DateIn, DateOut
FROM CUSTOMER, INVOICE
WHERE CUSTOMER.CustomerID = INVOICE.CustomerID
  AND TotalAmount > 100.00;

-- Question 5: LastName, FirstName, and Phone of all customers whose first name starts with B
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE FirstName LIKE 'B%';

-- Question 6: LastName, FirstName, and Phone of all customers whose last name includes the characters 'cat'
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE LastName LIKE '%cat%';

-- Question 7: LastName, FirstName, and Phone for all customers whose second and third digits (from the left) of their phone number are 23
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE Phone LIKE '_23%';

-- Question 8: Determine the maximum and minimum TotalAmount
SELECT MAX(TotalAmount), MIN(TotalAmount)
FROM INVOICE;

-- Question 9: Determine the average TotalAmount
SELECT AVG(TotalAmount)
FROM INVOICE;

-- Question 10: Count the number of customers
SELECT COUNT(*)
FROM CUSTOMER;

-- Question 11: Group customers by LastName and then by FirstName
SELECT LastName, FirstName
FROM CUSTOMER
GROUP BY LastName, FirstName;

-- Question 12: Count the number of customers having each combination of LastName and FirstName
SELECT LastName, FirstName, COUNT(*) AS NumCustomers
FROM CUSTOMER
GROUP BY LastName, FirstName;

-- Question 13: LastName, FirstName, and Phone of all customers who have had an order with TotalAmount greater than $100.00. Use a subquery. Present the results sorted by LastName in ascending order and then FirstName in descending order
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN (SELECT CustomerID FROM INVOICE WHERE TotalAmount > 100.00)
ORDER BY LastName ASC, FirstName DESC;

-- Question 14: LastName, FirstName, and Phone of all customers who have had an order with TotalAmount greater than $100.00. Use a join, but do not use JOIN ON syntax. Present results sorted by LastName in ascending order and then FirstName in descending order.
SELECT LastName, FirstName, Phone
FROM CUSTOMER, INVOICE
WHERE CUSTOMER.CustomerID = INVOICE.CustomerID
  AND TotalAmount > 100.00
ORDER BY LastName ASC, FirstName DESC;

-- Question 15: LastName, FirstName, and Phone of all customers who have had an order with TotalAmount greater than $100.00. Use a join using JOIN ON syntax. Present results sorted by LastName in ascending order and then FirstName in descending order
SELECT LastName, FirstName, Phone
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerID
WHERE TotalAmount > 100.00
ORDER BY LastName ASC, FirstName DESC;

-- Question 16: LastName, FirstName, and Phone of all customers who have had an order with an Item named 'Dress Shirt'. Use a subquery. Present results sorted by LastName in ascending order and then FirstName in descending order.
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN (
    SELECT CustomerID FROM INVOICE
    WHERE InvoiceNumber IN (
        SELECT InvoiceNumber FROM INVOICE_ITEM
        WHERE Item = 'Dress Shirt'
    )
)
ORDER BY LastName ASC, FirstName DESC;

-- Question 17: LastName, FirstName, and Phone of all customers who have had an order with an Item named 'Dress Shirt'. Use a join, but do not use JOIN ON syntax. Present results sorted by LastName in ascending order and then FirstName in descending order.
SELECT LastName, FirstName, Phone
FROM CUSTOMER, INVOICE, INVOICE_ITEM
WHERE CUSTOMER.CustomerID = INVOICE.CustomerID
  AND INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
  AND Item = 'Dress Shirt'
ORDER BY LastName ASC, FirstName DESC;

-- Question 18: LastName, FirstName, and Phone of all customers who have had an order with an Item named 'Dress Shirt'. Use a join using JOIN ON syntax. Present results sorted by LastName in ascending order and then FirstName in descending order.
SELECT LastName, FirstName, Phone
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerID
JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
WHERE Item = 'Dress Shirt'
ORDER BY LastName ASC, FirstName DESC;

-- Question 20: LastName, FirstName, and Phone of all customers who have had an order with an Item named 'Dress Shirt'. Use a combination of a join using JOIN ON syntax and a subquery. Present results sorted by LastName in ascending order and then FirstName in descending order.
SELECT LastName, FirstName, Phone
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerID
WHERE INVOICE.InvoiceNumber IN (
    SELECT InvoiceNumber FROM INVOICE_ITEM
    WHERE Item = 'Dress Shirt'
)
ORDER BY LastName ASC, FirstName DESC;

-- Question 21: LastName, FirstName, Phone, and TotalAmount of all customer orders that included an Item named 'Dress Shirt'. Also show the LastName, FirstName, and Phone of all other customers. Present results sorted by TotalAmount in ascending order, then LastName in ascending order, and then FirstName in descending order.
SELECT LastName, FirstName, Phone, TotalAmount
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerID
WHERE INVOICE.InvoiceNumber IN (
    SELECT InvoiceNumber FROM INVOICE_ITEM
    WHERE Item = 'Dress Shirt'
)

UNION

SELECT LastName, FirstName, Phone, NULL AS TotalAmount
FROM CUSTOMER
WHERE CustomerID NOT IN (
    SELECT CUSTOMER.CustomerID
    FROM CUSTOMER
    JOIN INVOICE ON CUSTOMER.CustomerID = INVOICE.CustomerID
    WHERE INVOICE.InvoiceNumber IN (
        SELECT InvoiceNumber FROM INVOICE_ITEM
        WHERE Item = 'Dress Shirt'
    )
)

ORDER BY TotalAmount ASC, LastName ASC, FirstName DESC;
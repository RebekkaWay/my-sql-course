-- Which are the corporate customers i.e. those with a value, not NULL, in the Company column?

select * from Customer c where c.company is not null;
 
-- How many customers are in each country.  Order by the most popular country first.

select top 1 c.country, count(*) as Count from Customer c group by c.country order by Count(*) desc;
 
-- When was the oldest employee born?  Who is that?

select * from Employee e order by e.BirthDate asc;
 
-- List the 10 latest invoices. Include the InvoiceId, InvoiceDate and Total
-- Then  also include the customer full name (first and last name together)

select top 10 i.InvoiceId, i.InvoiceDate, i.Total, c.FirstName, c.LastName from Invoice i join Customer c on i.CustomerId = c.CustomerId order by InvoiceDate desc;
 
-- List the customers who have spent more than £45

SELECT
    *
FROM
    Customer
WHERE CustomerID IN (SELECT
    i.customerid
    --,sum(i.Total) AS SumTotal
FROM
    Invoice i
GROUP BY i.CustomerId
HAVING sum(i.total) > 45);

-- implement as a table subquery
 
SELECT
    c.FirstName
    ,c.LastName
    ,topCust.InvoiceTotal
FROM
    Customer c JOIN  
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45) topCust
ON c.CustomerId = topCust.CustomerId
 
-- implement as a CTE
;
with cte AS
(SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45 )
select
    c.FirstName
    ,c.LastName
    ,cte.InvoiceTotal
from  Customer c JOIN cte on c.CustomerId = cte.CustomerId
 
--implement as temporary tables
 
SELECT
    i.CustomerId
    ,SUM(i.Total) AS InvoiceTotal
into #topcust
FROM
Invoice i
GROUP BY i.CustomerId
HAVING  SUM(i.Total) > 45

select * from #topcust join customer c on c.CustomerId = #topcust.CustomerId;
 
-- List the City, CustomerId and LastName of all customers in Paris and London,
-- and the Total of their invoices
 

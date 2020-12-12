DROP VIEW Sales.OrderTotals 
GO
CREATE OR ALTER VIEW Sales.OrderTotals
 WITH SCHEMABINDING
AS
SELECT
    O.orderid, O.custid, O.empid, O.shipperid, O.orderdate,
    O.requireddate, O.shippeddate,
    SUM(OD.qty) AS qty,
    CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS NUMERIC(12, 2)) AS val
FROM Sales.Orders AS O
 INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
GROUP BY
 O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.requireddate, O.shippeddate;
GO

-- O primeiro �ndice criado em uma view deve ser UNIQUE e CLUSTERED
CREATE UNIQUE CLUSTERED INDEX idx_cl_orderid ON Sales.OrderTotals(orderid);
GO

-- Acrescentando o COUNT_BIG
CREATE OR ALTER VIEW Sales.OrderTotals
 WITH SCHEMABINDING
AS
SELECT
    O.orderid, O.custid, O.empid, O.shipperid, O.orderdate,
    O.requireddate, O.shippeddate,
    SUM(OD.qty) AS qty,
    -- CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS NUMERIC(12, 2)) AS val, -- necess�rio remover o CAST, pois n�o � poss�vel manipular ou aplicar transforma��es em um resultado agregado
	SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS val, -- ok
	COUNT_BIG(*) AS numorderlines
FROM Sales.Orders AS O
 INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
GROUP BY
 O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.requireddate, O.shippeddate;
GO

--Ap�s a cria��o do �ndice clusterizado
/*
CREATE NONCLUSTERED INDEX idx_nc_custid ON Sales.OrderTotals(custid);
CREATE NONCLUSTERED INDEX idx_nc_empid ON Sales.OrderTotals(empid);
CREATE NONCLUSTERED INDEX idx_nc_shipperid ON Sales.OrderTotals(shipperid);
CREATE NONCLUSTERED INDEX idx_nc_orderdate ON Sales.OrderTotals(orderdate);
CREATE NONCLUSTERED INDEX idx_nc_shippeddate ON Sales.OrderTotals(shippeddate);
*/

-- Edi��es Enterprise / Developer
SELECT orderid, custid, empid, shipperid, orderdate, requireddate, shippeddate, qty, val, numorderlines
FROM Sales.OrderTotals;

-- Outras Edi��es
SELECT orderid, custid, empid, shipperid, orderdate, requireddate, shippeddate, qty, val, numorderlines
FROM Sales.OrderTotals WITH (NOEXPAND);


-- Vers�o Enterprise / Developer
SELECT
    O.orderid, O.custid, O.empid, O.shipperid, O.orderdate,
    O.requireddate, O.shippeddate,
    SUM(OD.qty) AS qty,
    -- CAST(SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS NUMERIC(12, 2)) AS val, -- necess�rio remover o CAST, pois n�o � poss�vel manipular ou aplicar transforma��es em um resultado agregado
	SUM(OD.qty * OD.unitprice * (1 - OD.discount)) AS val, -- ok
	COUNT_BIG(*) AS numorderlines
FROM Sales.Orders AS O
 INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
GROUP BY
 O.orderid, O.custid, O.empid, O.shipperid, O.orderdate, O.requireddate, O.shippeddate;
GO
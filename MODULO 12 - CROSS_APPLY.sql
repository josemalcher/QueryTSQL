USE TSQLV4;
GO

SELECT O.orderid, custid, Tab.Valor_Maximo FROM Sales.Orders O
                       CROSS APPLY (SELECT MAX(OD.UnitPrice) AS Valor_Maximo 
					                FROM Sales.OrderDetails OD
									WHERE OD.orderid = O.orderid) AS Tab

-- Transformando a opera��o em uma fun��o e aplicando a mesma l�gica. 
GO
CREATE FUNCTION dbo.udf_MaxUnitPrice 
(	
   @orderid INT    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT MAX(OD.UnitPrice) AS Valor_Maximo 
					                FROM Sales.OrderDetails OD
									WHERE OD.orderid =  @orderid 
)
GO


SELECT O.orderid, custid, f.Valor_Maximo  FROM Sales.Orders O
                       CROSS APPLY dbo.udf_MaxUnitPrice(O.orderid) AS F


					            
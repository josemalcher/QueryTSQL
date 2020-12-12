use tsqlv4;
go

/*
   1. Aproveitando o script criado para o exerc�cio do m�dulo anterior. Acrescente uma coluna avaliando o tempo para envio de um produto. 
      Se o tempo de envio for maior do que 10 ent�o exiba 'Muito Demorado' sen�o 'Dentro do Prazo'. 

   2. Ajuste o Script para que seja retornado os registros em que a regi�o n�o tenha um valor (seja null), e nesses casos substitua o valor NULL por "Regi�o N�o informada")
*/

SELECT UPPER(SUBSTRING(shipCountry, 1, 3)) AS [Pa�s], 
       COALESCE(shipregion, 'Sem Regi�o Cadastrada') AS [Regi�o],
       DATEDIFF(DAY, orderdate, shippeddate) AS [Dias Para o Envio],
	   IIF(DATEDIFF(DAY, orderdate, shippeddate) > 10, 'Muito Demorado', 'Dentro do Prazo')
FROM Sales.Orders O 
WHERE orderdate BETWEEN '20150101' AND '20151231'
ORDER BY Pa�s


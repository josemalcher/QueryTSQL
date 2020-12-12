/*
 EXERC�CIO
 1. O departamento de Marketing est� trabalhando em uma nova campanha de marketing e solicitou 
 a nossa equipe um relat�rio. Segue abaixo o texto com as especifica��es (N�o me pergunte o por qu� de algumas
 delas). 
    "Desejamos um relat�rio de Pedidos no per�odo de 01-07-2014 at� 31-07-2014, ordenado de data mais antiga para a mais recente e que
	todos os clientes tenham a letra 'K' em qualquer parte do nome. 
	As colunas exibidas no relat�rio devem ser: As tr�s primeiras letras do nome do pa�s de origem do cliente em caixa alta, a Data do Pedido com o m�s e o dia 
	(Obs: o m�s	deve ser escrito por extenso e separado do dia por  uma '/') e o nome do cliente.

	Grato
	Equipe de Marketring"

 2. O departamento de vendas tem estranhado o tempo entre o pedido e a sua data de envio e por isso gostaria de um relat�rio no qual fosse mostrado
    A diferen�a entre as datas do pedido e a data do envio, a regi�o e as tr�s primeiras letras do pa�s, em caixa alta, no qual ser� enviado o produto. 
	O relat�rio deve ser do per�odo do ano de 2015 e deve exibir apenas para pa�ses que possuem uma regi�o cadastrada. 
    
      
*/

SELECT 
   UPPER(SUBSTRING(C.country, 1, 3)) AS [Pa�s], 
   CONCAT(DATENAME(MONTH, orderdate), ' / ', DATEPART(DAY, orderdate)) AS [Data Pedido],
   C.contactname
FROM Sales.Orders O
INNER JOIN Sales.Customers C ON C.custid = O.custid
WHERE C.contactname like '%K%'
  AND O.orderdate BETWEEN '20140701' AND '20140731'
ORDER BY O.orderdate


SELECT UPPER(SUBSTRING(shipCountry, 1, 3)) AS [Pa�s], 
       O.shipregion AS [Regi�o],
       DATEDIFF(DAY, orderdate, shippeddate) AS [Dias Para o Envio]
FROM Sales.Orders O 
WHERE orderdate BETWEEN '20150101' AND '20151231'
  AND shipregion IS NOT NULL
ORDER BY Pa�s


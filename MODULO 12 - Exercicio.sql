/*
 EXERC�CIO 
        1. O departamento de relacionamento com o cliente solicitou um relat�rio que pede as seguintes informa��es: 
          Nome do cliente, A Data da Ultima Compra e o Maior frete pago. 
*/
/*
  EXECUTE OS SCRIPTS ABAIXO PARA REALIZAR O ITEM 2.
*/
		 --Apaga a tabela de backup caso j� exista.
		DROP TABLE IF EXISTS Sales.OrdersBKP
		DROP TABLE IF EXISTS Sales.OrderDetailsBKP
		--insere os dados da tabela de pedidos, criando a tabela de backup
		SELECT * INTO Sales.OrdersBKP FROM Sales.Orders
		SELECT * INTO Sales.OrderDetailsBKP FROM Sales.OrderDetails
		-- deleta os registros anteriores a 2015. 
		DELETE FROM Sales.OrderDetails WHERE orderid IN (SELECT orderid FROM Sales.Orders WHERE orderdate < '20150101')
		DELETE FROM Sales.Orders WHERE orderdate < '20150101'

/*
  
  2. Devido a problemas de espa�o em disco no servidor, os registros de vendas de datas anteriores a 2015 foram movidas para uma tabela 
     de backup. Mas o departamento de vendas ainda precisa analisar as vendas que ocorreram naquele ano. Dessa forma foi solicitado a voc� 
     a constru��o de um relat�rio. 
     2.1 Um relat�rio que fa�a a uni�o novamente entre os registros atuais e os hist�ricos com as informa��es de: 
         orderid, custid, orderdate, productid, unitprice, qty e discount;
*/






/*
A função DATEADD adiciona partes inteiras de uma registro tipo date time ou datetime. As partes são definidas no primeiro argumento
A parte que sera adicionada ou subtraida sera declarada no segundo argumento
*/


SELECT TOP (1000) [LogId]
      ,[DataHora]
      ,DATEADD(YEAR,5,[DataHora]) AS MAIS_5_ANOS
      ,DATEADD(YEAR,-5,[DataHora]) AS MENOS_5_ANOS
	  ,
	  ,
     
  FROM [SQL_PAD].[dbo].[LogSistema]

USE SQL_PAD

GO

/* 
Criação de uma tabela temporaria para receber os dados do csv. A maioria das colulas são do tipo varchar. 
Por que varchar ? Porque é flexivel e evitar erros de compatibilidade de tipos de dados
*/
DROP table if exists #retail_sales_temp;
CREATE table #retail_sales_temp
(
sales_month date
,naics_code varchar(100)
,kind_of_business varchar(100)
,reason_for_null varchar(100)
,sales varchar(50)
)

;
/*
BULK INSERT para inserir os dados do csv na minha tabela temporaria
*/
BULK INSERT #retail_sales_temp
FROM 'C:\SQL2022\us_retail_sales.csv'
WITH (
    FIRSTROW = 2,               -- pula o cabeçalho
    FIELDTERMINATOR = ';',      -- separador de colunas
    ROWTERMINATOR = '\n',       -- quebra de linha
    CODEPAGE = '65001'          -- UTF-8
);

/*
Comando insert na minha tabela retail_sales que é um objeto tipo tabela do meu SGBD.
Nessa etapa eu faço a conversão do tipo de dados varchar para int usando a função CAST
*/
INSERT INTO dbo.retail_sales
SELECT 
	sales_month
	,naics_code 
	,kind_of_business 
	,reason_for_null 
	,CAST(sales AS int)
FROM #retail_sales_temp
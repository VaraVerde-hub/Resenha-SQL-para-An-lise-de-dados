USE SQL_PAD
GO
/*
Tendências simples em séries temporais

Tendência pode ser interpretada como a direção geral
dos dados ao longo do tempo. É um conceito de fácil
entendimento quando lidamos com séries temporais.

Explorar diferentes níveis de agregação, como diário,
mensal ou anual, é uma boa forma de identificar
padrões e tendências nos dados.
*/

---------------------------------------------------------
-- Consulta em nível diário
-- Pode ser utilizada em ferramentas de BI para
-- construção de gráficos e análise de padrões
---------------------------------------------------------

SELECT TOP (10)
    sales_month, -- Atributo do tipo DATE com granularidade diária
    sales
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total'
ORDER BY
    sales_month ASC;

---------------------------------------------------------
-- Redução da granularidade dos dados
-- Objetivo: eliminar ruídos de variações pouco relevantes
-- Agregação dos dados do nível diário para anual
---------------------------------------------------------

SELECT TOP (10)
    DATEPART(YEAR, sales_month) AS sales_year, -- Extração do ano da data da venda
    SUM(sales) AS total_sales                  -- Função de agregação
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total'
GROUP BY
    DATEPART(YEAR, sales_month)
ORDER BY
    DATEPART(YEAR, sales_month) ASC;
USE SQL_PAD
GO

---------------------------------------------------------
-- 1) Investigando tendências por proporção
--    A consulta a seguir mostra a proporção das vendas
--    de roupas femininas em relação às masculinas
---------------------------------------------------------

SELECT
    sales_year,
    womens_sales * 1.0 / mens_sales AS womens_times_of_mens_decimal,
    -- Multiplicamos o numerador por 1.0 para forçar
    -- a conversão do resultado da divisão para DECIMAL

    womens_sales / mens_sales AS womens_times_of_mens
    -- A divisão entre colunas do tipo INT resulta em INT,
    -- mesmo quando o valor real possui casas decimais
FROM (
    SELECT
        DATEPART(YEAR, sales_month) AS sales_year,
        SUM(
            CASE
                WHEN kind_of_business = 'Women''s clothing stores'
                    THEN sales
            END
        ) AS womens_sales,
        SUM(
            CASE
                WHEN kind_of_business = 'Men''s clothing stores'
                    THEN sales
            END
        ) AS mens_sales
    FROM retail_sales
    WHERE kind_of_business IN (
        'Men''s clothing stores',
        'Women''s clothing stores'
    )
      AND sales_month <= '2019-12-01'
    GROUP BY
        DATEPART(YEAR, sales_month)
) AS yearly_sales;

---------------------------------------------------------
-- 2) Investigando tendências por diferença percentual
--    A consulta calcula o quanto (%) as vendas de roupas
--    femininas são maiores ou menores que as masculinas
---------------------------------------------------------

SELECT
    sales_year,
    CAST(
        (
            CAST(womens_sales AS FLOAT) / mens_sales - 1
        ) * 100
        AS DECIMAL(10, 2)
    ) AS womens_pct_of_mens
    -- Conversão para FLOAT evita truncamento das casas decimais
    -- Conversão final para DECIMAL controla a precisão do resultado
FROM (
    SELECT
        DATEPART(YEAR, sales_month) AS sales_year,
        SUM(
            CASE
                WHEN kind_of_business = 'Women''s clothing stores'
                    THEN sales
            END
        ) AS womens_sales,
        SUM(
            CASE
                WHEN kind_of_business = 'Men''s clothing stores'
                    THEN sales
            END
        ) AS mens_sales
    FROM retail_sales
    WHERE kind_of_business IN (
        'Men''s clothing stores',
        'Women''s clothing stores'
    )
      AND sales_month <= '2019-12-01'
    GROUP BY
        DATEPART(YEAR, sales_month)
) AS yearly_sales;

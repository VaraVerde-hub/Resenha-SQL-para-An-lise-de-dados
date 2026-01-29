USE SQL_PAD;
GO
/*
Comparação de componentes em séries temporais

Um conjunto de dados de séries temporais pode possuir
vários componentes distintos dentro do mesmo dataset.
Neste exemplo, comparamos vendas de roupas femininas
e masculinas ao longo do tempo.
*/

---------------------------------------------------------
-- 1) Comparar as vendas de roupas femininas e masculinas
--    ao longo do tempo.
--    Nível de agregação: Ano
---------------------------------------------------------

SELECT TOP (10)
    DATEPART(YEAR, sales_month) AS sales_year,
    kind_of_business,
    SUM(sales) AS total_sales
FROM retail_sales
WHERE kind_of_business IN (
    'Men''s clothing stores',
    'Women''s clothing stores'
)
GROUP BY
    DATEPART(YEAR, sales_month),
    kind_of_business
ORDER BY
    DATEPART(YEAR, sales_month) ASC;

---------------------------------------------------------
-- 2) Pivotar os dados para gerar um único registro
--    por ano, contendo as vendas anuais de cada categoria
---------------------------------------------------------

SELECT TOP (10)
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
GROUP BY
    DATEPART(YEAR, sales_month)
ORDER BY
    DATEPART(YEAR, sales_month) ASC;

---------------------------------------------------------
-- 3) Com os dados pivotados, calcular a diferença
--    entre as vendas de roupas femininas e masculinas
---------------------------------------------------------

SELECT TOP (10)
    sales_year,
    womens_sales - mens_sales AS womens_minus_mens
FROM (
    -- Subquery com os dados anuais pivotados
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
    GROUP BY
        DATEPART(YEAR, sales_month)
) AS aggregated_sales
ORDER BY
    sales_year ASC;

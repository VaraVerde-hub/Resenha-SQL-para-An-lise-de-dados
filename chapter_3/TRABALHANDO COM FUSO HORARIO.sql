/*
A tabela de sistema sys.time_zone_info contém a lista de fusos horários do sistema.
Usando a função AT TIME ZONE [FUSO], podemos fazer a conversão de fuso horário.
*/

SELECT
    SYSDATETIMEOFFSET() AS DATETIME_COM_FUSO_SERVIDOR;
GO

SELECT
    SYSDATETIMEOFFSET()                 -- Retorna a data e hora atual do banco
        AT TIME ZONE 'UTC-11'           -- Conversão para o fuso UTC-11
        AT TIME ZONE 'UTC-09'           -- Conversão do UTC-11 para UTC-09
        AS CONVERSAO_ENTRE_FUSOS;
GO

/*
Usando Subquery para realizar a conversão de fuso horário
*/

SELECT
    GETDATE() AS DATETIME_SEM_FUSO_SERVIDOR;
GO

SELECT
    A.UTC_11 AT TIME ZONE 'UTC-09' AS DATETIME_FUSO
FROM (
    SELECT
        GETDATE() AT TIME ZONE 'UTC-11' AS UTC_11
) AS A;

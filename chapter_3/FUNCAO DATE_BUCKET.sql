/*
DATE_BUCKET é uma função que classifica registros de data e hora
em blocos (intervalos) de tamanho definido.

A função possui os seguintes argumentos:

1. datepart:
   Define o nível de granularidade do bloco.
   Exemplos: day, week, month, hour, minute, second.

2. number:
   Define a largura do bloco.
   Exemplo: se o datepart for DAY e o number for 7,
   todos os registros dentro de intervalos de 7 dias,
   a partir da data de origem, serão agrupados no mesmo bloco.

3. date:
   É a expressão ou coluna de data/hora que será avaliada pela função.

4. origin (opcional):
   Define a data de início dos blocos.
   Considerando o exemplo do item 2, os blocos de 7 dias
   serão calculados a partir dessa origem.

   Caso esse argumento não seja informado,
   o SQL Server utilizará a data padrão:
   1900-01-01 00:00:00.000
*/

SELECT
    [LogId],
    [DataHora],
    DATE_BUCKET(
        MINUTE,
        2,
        [DataHora],
        CAST('2026-01-01 00:00:00' AS DATETIME2)
    ) AS BLOCO -- Agrupa os registros em blocos de 2 minutos a partir de 01/01/2026
FROM
    [SQL_PAD].[dbo].[LogSistema];

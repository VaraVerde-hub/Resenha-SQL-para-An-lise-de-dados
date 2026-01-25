/*
1. DATEADD
   A função DATEADD adiciona ou subtrai uma quantidade inteira a um valor do tipo
   date, datetime ou datetime2.
   - O primeiro argumento define a parte da data (datepart).
   - O segundo argumento define o valor inteiro a ser adicionado ou subtraído.
   - O terceiro argumento é a data base que será utilizada no cálculo.

2. DATEDIFF
   A função DATEDIFF retorna a diferença entre duas datas como um número inteiro.
   Os parâmetros são: datepart, startdate e enddate.

   Observação importante:
   O DATEDIFF calcula a diferença considerando a mudança da parte da data informada,
   e não o intervalo exato de tempo. Isso pode gerar resultados inesperados.
   Exemplo:
     DATEDIFF(MONTH, '2026-01-31', '2026-02-01') = 1
   Mesmo tendo apenas um dia de diferença, ocorreu a mudança de mês.

3. DATEFROMPARTS
   A função DATEFROMPARTS retorna um valor do tipo DATE.
   Ela permite construir uma data completa a partir das partes:
   year, month e day.

4. DATEPART
   A função DATEPART retorna um número inteiro correspondente à parte da data
   especificada na função. Pode ser utilizada para obter, por exemplo:
   minuto, semana do ano, dia do ano ou dia da semana.

5. DATENAME
   A função DATENAME retorna uma string que representa o nome da parte da data
   especificada (por exemplo, nome do mês ou do dia da semana).

6. DATETRUNC
   A função DATETRUNC "trunca" a data para uma parte específica.
   Exemplos para a data '2026-10-11 05:30:55':
   - YEAR  -> 2026-01-01 00:00:00
   - MONTH -> 2026-10-01 00:00:00
   - DAY   -> 2026-10-11 00:00:00
   - HOUR  -> 2026-10-11 05:00:00

7. EOMONTH
   A função EOMONTH retorna o último dia do mês da data informada.
   O segundo argumento é opcional e permite:
   - Valor positivo: somar meses
   - Valor negativo: subtrair meses

8. SWITCHOFFSET
   A função SWITCHOFFSET ajusta apenas o offset de fuso horário,
   representando o mesmo instante de tempo em outro fuso.
   Exemplo:
   Um offset de '+04:00' adiciona 4 horas ao horário original.
*/

SELECT TOP (10000)
       [LogId],
       [DataHora],
       DATEADD(MINUTE, 5, [DataHora]) AS [DATEADD],
       DATEDIFF(
           MINUTE,
           [DataHora],
           DATEADD(MINUTE, 5, [DataHora])
       ) AS [DATEDIFF],
       DATEFROMPARTS(
           YEAR([DataHora]),
           MONTH([DataHora]),
           DAY([DataHora])
       ) AS [DATEFROMPARTS],
       DATEPART(MINUTE, [DataHora]) AS [DATEPART],
       DATENAME(WEEKDAY, [DataHora]) AS [DATENAME],
       DATETRUNC(ISO_WEEK, [DataHora]) AS [DATETRUNC],
       EOMONTH([DataHora], 1) AS [EOMONTH],
       SWITCHOFFSET([DataHora], '+04:00') AS [SWITCHOFFSET]
FROM [SQL_PAD].[dbo].[LogSistema];

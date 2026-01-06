/*
Input data
Create the bank code by splitting out off the letters from the Transaction code, call this field 'Bank'
Change transaction date to the just be the month of the transaction
Total up the transaction values so you have one row for each bank and month combination
Rank each bank for their value of transactions each month against the other banks. 1st is the highest value of transactions, 3rd the lowest. 
Without losing all of the other data fields, find:
The average rank a bank has across all of the months, call this field 'Avg Rank per Bank'
The average transaction value per rank, call this field 'Avg Transaction Value per Rank'
Output the data
*/
WITH cte AS 
    (
    SELECT
        SPLIT_PART(transaction_code,'-',1) AS bank
        ,MONTHNAME(DATE(transaction_date,'dd/MM/yyyy hh24:mi:ss')) AS transaction_month
        ,SUM(value) AS transactions_value
        ,RANK() OVER(PARTITION BY transaction_month ORDER BY transactions_value DESC) AS ranking
    FROM pd2023_wk01
    GROUP BY 1,2
    ),
    avg_rank AS
    (
    SELECT
        ranking
        ,AVG(transactions_value) AS avg_transaction_value_per_rank
    FROM cte
    GROUP BY 1
    ),
    avg_bank AS
    (
   SELECT
        bank
        ,AVG(ranking) AS avg_rank_per_bank
    FROM cte
    GROUP BY 1
    )
SELECT
    cte.*
    ,avg_transaction_value_per_rank
    ,avg_rank_per_bank
FROM cte
INNER JOIN avg_rank ar
    ON ar.ranking = cte.ranking
INNER JOIN avg_bank ab
    ON ab.bank = cte.bank;
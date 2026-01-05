-- Use CTE create Quarter, total_value, online or in person fields from Transactions table
WITH
    transactions_cte AS
    (
        SELECT
        CASE
            WHEN online_or_in_person = 1 THEN 'Online'
            WHEN online_or_in_person = 2 THEN 'In-Person'
        END AS online_or_not
        ,Quarter(TO_DATE(transaction_date,'DD/MM/YYYY hh:mi:ss')) AS Quarter
        ,SUM(value) AS total_value
    FROM pd2023_wk01
    WHERE LEFT(transaction_code,3) = 'DSB'
    GROUP BY 
        online_or_not
        ,Quarter
    ),

-- Use CTE to pivot quarter input, extract quarter, and get quarterly target field
    target_cte AS
    (
        SELECT
        RIGHT(Quarter,1) AS Quarter
        ,online_or_in_person
        ,quarterly_target
    FROM pd2023_wk03_targets
    UNPIVOT(quarterly_target FOR Quarter IN (Q1,Q2,Q3,Q4))
    GROUP BY ALL
    )

 --  Final query
    SELECT
    online_or_not
    ,tc.Quarter
    ,SUM(total_value) AS total_revenue
    ,SUM(quarterly_target) AS quarter_target
    ,total_value - quarterly_target AS var_to_target
FROM transactions_cte AS tc
JOIN target_cte AS tr
    ON tr.quarter = tc.quarter
    AND tr.online_or_in_person = tc.online_or_not
GROUP BY ALL
ORDER BY 
    tc.quarter ASC
    ,var_to_target DESC;

-- Output

-- ONLINE_OR_NOT	QUARTER	TOTAL_REVENUE	QUARTER_TARGET	VAR_TO_TARGET
-- In-Person	1	77576	75000	2576
-- Online	1	74562	72500	2062
-- In-Person	2	70634	70000	634
-- Online	2	69325	70000	-675
-- In-Person	3	74189	70000	4189
-- Online	3	59072	60000	-928
-- Online	4	61908	60000	1908
-- In-Person	4	43223	60000	-16777

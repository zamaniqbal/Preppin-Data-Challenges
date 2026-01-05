/*
Input the data
We want to stack the tables on top of one another, since they have the same fields in each sheet.
Make a Joining Date field based on the Joining Day, Table Names and the year 2023
Now we want to reshape our data so we have a field for each demographic, for each new customer (help)
Make sure all the data types are correct for each field
Remove duplicates (help)
If a customer appears multiple times take their earliest joining date
Output the data
*/

-- Union Tables
WITH 
union_tables AS
    (
    SELECT *, 'pd2023_wk04_january' as tablename FROM pd2023_wk04_january
    
    UNION ALL 
    
    SELECT *, 'pd2023_wk04_february' as tablename FROM pd2023_wk04_february
    
    UNION ALL 
    
    SELECT *, 'pd2023_wk04_march' as tablename FROM pd2023_wk04_march
    
    UNION ALL 
    
    SELECT *, 'pd2023_wk04_april' as tablename FROM pd2023_wk04_april
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_may' as tablename FROM pd2023_wk04_may
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_june' as tablename FROM pd2023_wk04_june
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_july' as tablename FROM pd2023_wk04_july
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_august' as tablename FROM pd2023_wk04_august
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_september' as tablename FROM pd2023_wk04_september
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_october' as tablename FROM pd2023_wk04_october
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_november' as tablename FROM pd2023_wk04_november
    
    UNION ALL
    
    SELECT *, 'pd2023_wk04_december' as tablename FROM pd2023_wk04_december
    ),
-- Create joining date field
join_date AS
    (
    SELECT
        id
        ,demographic
        ,value
,DATE_FROM_PARTS(2023,DATE_PART('month',DATE(SPLIT_PART(tablename,'_',3),'MMMM')),joining_day) as joining_date
    FROM union_tables
    ),
-- Pivot Demographic field, take first joining date for each customer
pivoted AS
    (
    SELECT
        id
        ,joining_date
        ,ethnicity
        ,account_type
        ,CAST(date_of_birth AS DATE) AS date_of_birth
        ,ROW_NUMBER() OVER(PARTITION BY id ORDER BY joining_date ASC) AS rn
    FROM join_date
    PIVOT(MAX(value) FOR demographic IN ('Ethnicity','Account Type','Date of Birth')) AS pvt (id, joining_date, ethnicity, account_type, date_of_birth)
    )
-- Final output
SELECT
    id
    ,joining_date
    ,account_type
    ,date_of_birth
    ,ethnicity
FROM pivoted
WHERE rn = 1;
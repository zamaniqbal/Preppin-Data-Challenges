-- Create CTE to store data for all stores to avoid rewriting main query 5 times
WITH combined_data AS 
    (
    SELECT *, 'Birmingham' AS store FROM pd2021_wk03_birmingham
    UNION ALL
    SELECT *, 'Leeds' AS store FROM pd2021_wk03_leeds
    UNION ALL
    SELECT *, 'London' AS store FROM pd2021_wk03_london
    UNION ALL
    SELECT *, 'Manchester' AS store FROM pd2021_wk03_manchester
    UNION ALL
    SELECT *, 'York' AS store FROM pd2021_wk03_york
    ),

-- Create CTE to UNPIVOT data (columns to rows)
unpivoted_data AS
    (
    SELECT
        "Date"
        ,store
        ,SPLIT_PART(category, '_-_', 1) AS customer_type
        ,SPLIT_PART(category, '_-_', 2) AS product
        ,quantity
    FROM combined_data
    UNPIVOT (
        quantity FOR category IN
            ("New_-_Saddles"
            ,"New_-_Mudguards"
            ,"New_-_Wheels"
            ,"New_-_Bags"
            ,"Existing_-_Saddles"
            ,"Existing_-_Mudguards"
            ,"Existing_-_Wheels"
            ,"Existing_-_Bags")
            )
    )

-- Main Query, calling UNPIVOTED data from second CTE
SELECT
    product
    ,QUARTER("Date") AS Quarter
    ,SUM(quantity) AS products_sold
FROM unpivoted_data
GROUP BY 
    product
    ,Quarter
ORDER BY 
    Quarter
    ,products_sold;

-- Output
-- PRODUCT	QUARTER	PRODUCTS_SOLD
-- Wheels	1	319
-- Saddles	1	321
-- Bags	1	683
-- Mudguards	1	1006
-- Saddles	2	280
-- Wheels	2	303
-- Mudguards	2	442
-- Bags	2	593
-- Wheels	3	306
-- Mudguards	3	331
-- Saddles	3	361
-- Bags	3	564
-- Wheels	4	290
-- Saddles	4	337
-- Bags	4	541
-- Mudguards	4	674
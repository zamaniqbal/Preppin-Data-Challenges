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
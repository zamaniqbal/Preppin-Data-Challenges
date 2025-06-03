SELECT
    QUARTER(date)
    -- Split Store/Bike into two separate fields
    ,SPLIT_PART(store_bike,'-',1) AS store
    -- Cleaning up bike field to group spelling mistake/variations
    ,CASE
        WHEN STARTSWITH(SPLIT_PART(store_bike,'- ',2), 'G') THEN 'Gravel'
        WHEN STARTSWITH(SPLIT_PART(store_bike,'- ',2), 'R') THEN 'Road'
        WHEN STARTSWITH(SPLIT_PART(store_bike,'- ',2), 'M') THEN 'Mountain'
    END AS bike
    ,TO_number(order_id) AS order_id
    ,customer_age
    ,SUM(bike_value) AS Bike_value
    ,existing_customer
    ,dayofmonth(date)
FROM pd2021_wk01
-- Skip first 10 rows
WHERE order_id > 10
GROUP BY
    QUARTER(date)
    ,store
    ,bike
    ,order_id
    ,customer_age
    ,existing_customer
    ,dayofmonth(date)
ORDER BY order_id;

-- Output (sampled)
-- QUARTER(DATE)	STORE	BIKE	ORDER_ID	CUSTOMER_AGE	BIKE_VALUE	EXISTING_CUSTOMER	DAYOFMONTH(DATE)
-- 4	Birmingham 	Road	11	57	902	No	4
-- 1	Leeds 	Road	12	31	946	Yes	17
-- 4	Birmingham 	Road	13	17	1296	Yes	25
-- 3	Manchester 	Road	14	59	1166	Yes	18
-- 4	Manchester 	Mountain	15	24	1781	No	10
-- 4	York 	Mountain	16	59	1074	No	6
-- 3	York 	Mountain	17	57	1188	No	14
-- 4	York 	Mountain	18	56	544	No	23
-- 4	York 	Gravel	19	34	579	Yes	24
-- 2	York 	Gravel	20	17	1021	Yes	24
-- 2	London 	Road	21	36	786	Yes	9
-- 1	London 	Road	22	51	1596	No	2
-- 1	London 	Road	23	24	745	No	20
-- 2	London 	Road	24	50	1937	No	13
-- 3	Leeds 	Mountain	25	35	1958	No	5
-- 4	Birmingham 	Mountain	26	34	659	Yes	21
-- 2	Leeds 	Mountain	27	56	1403	Yes	7
-- 1	Birmingham 	Mountain	28	28	1347	Yes	12
-- 1	Manchester 	Gravel	29	24	1755	No	7
-- 1	Manchester 	Gravel	30	54	1190	No	3
-- 3	York 	Road	31	50	1643	No	17
-- 1	York 	Road	32	22	934	No	29
-- 4	York 	Road	33	30	968	Yes	13
-- 3	York 	Road	34	37	881	Yes	21
-- 4	York 	Mountain	35	52	1413	Yes	2
-- 2	London 	Mountain	36	59	1906	No	30
-- 2	London 	Mountain	37	53	1889	No	5
-- 3	London 	Mountain	38	56	1426	No	20
-- 3	London 	Gravel	39	50	1116	No	1
-- 2	Leeds 	Gravel	40	15	1353	Yes	8
-- Output 1
SELECT
    -- Extract Brand from Model column
    REGEXP_SUBSTR(model, '[A-Za-z]+') AS brand
    ,bike_type
    ,SUM(quantity) AS quantity_sold
    ,SUM(quantity*value_per_bike) AS order_value
    ,ROUND((SUM((quantity)*(value_per_bike)))/SUM(quantity),1) AS avg_bike_value_per_brand
FROM pd2021_wk02_bike_sales
GROUP BY
    brand
    ,bike_type;

-- Output
-- BRAND	BIKE_TYPE	QUANTITY_SOLD	ORDER_VALUE	AVG_BIKE_VALUE_PER_BRAND
-- GIA	Mountain	425	1021329	2403.1
-- SPEC	Mountain	960	2344504	2442.2
-- BROM	Mountain	277	674770	2436.0
-- KONA	Mountain	330	820537	2486.5
-- SPEC	Road	937	2195597	2343.2
-- BROM	Road	257	656539	2554.6
-- KONA	Gravel	324	791841	2444.0
-- GIA	Gravel	323	733087	2269.6
-- GIA	Road	407	896695	2203.2
-- BROM	Gravel	186	433885	2332.7
-- ORRO	Gravel	151	411644	2726.1
-- KONA	Road	273	647684	2372.5
-- ORRO	Mountain	87	206550	2374.1
-- ORRO	Road	84	181300	2158.3
-- SPEC	Gravel	974	2295397	2356.7

-- Output 2
SELECT
    -- Extract Brand from Model column
    REGEXP_SUBSTR(model, '[A-Za-z]+') AS brand
    ,store
    ,SUM(quantity * value_per_bike) AS total_order_value
    ,SUM(quantity) AS total_quantity_sold
    ,ROUND(AVG(DATEDIFF(
        day
        ,TO_DATE(order_date, 'DD/MM/YYYY')
        ,TO_DATE(shipping_date, 'DD/MM/YYYY')
    )), 1) AS avg_days_to_ship
FROM pd2021_wk02_bike_sales
GROUP BY
    brand,
    store;

-- Output
-- BRAND	STORE	TOTAL_ORDER_VALUE	TOTAL_QUANTITY_SOLD	AVG_DAYS_TO_SHIP
-- SPEC	Birmingham	1488013	651	10.6
-- BROM	London	324635	133	11.0
-- BROM	Leeds	389116	150	9.8
-- BROM	York	361852	145	9.8
-- SPEC	London	1358343	578	11.2
-- ORRO	Birmingham	216169	86	11.4
-- BROM	Manchester	339832	137	10.9
-- KONA	London	524879	216	10.7
-- KONA	Manchester	370481	148	10.5
-- ORRO	York	186457	77	9.0
-- BROM	Birmingham	349759	155	11.8
-- GIA	Birmingham	581733	269	9.9
-- SPEC	Leeds	1431894	570	10.4
-- SPEC	Manchester	1451471	614	11.1
-- GIA	Manchester	466613	204	11.0
-- ORRO	Leeds	126334	55	11.9
-- KONA	Leeds	498341	208	9.2
-- GIA	Leeds	460151	203	11.2
-- KONA	Birmingham	435694	184	10.6
-- GIA	London	548821	228	10.7
-- ORRO	London	151734	61	9.4
-- GIA	York	593793	251	10.4
-- SPEC	York	1105777	458	10.4
-- ORRO	Manchester	118800	43	8.4
-- KONA	York	430667	171	11.1
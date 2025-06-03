-- Output 1
SELECT
    SPLIT_PART(TRANSACTION_CODE,'-',1) AS bank_name
    ,SUM(value) AS total_value
FROM pd2023_wk01
GROUP BY bank_name;

-- Output
-- BANK_NAME	TOTAL_VALUE
-- DS	653940
-- DSB	530489
-- DTB	618238


-- Output 2
SELECT
    SPLIT_PART(TRANSACTION_CODE,'-',1) AS bank_name
    ,CASE
        WHEN online_or_in_person = '1' THEN 'Online'
        WHEN online_or_in_person = '2' THEN 'In-Person'
        END AS ONLINE_OR_IN_PERSON
    ,dayname(TO_DATE(TRANSACTION_DATE,'DD/MM/YYYY HH:MI:SS')) AS day_of_week
    ,SUM(value) AS total_value
FROM pd2023_wk01
GROUP BY
    bank_name
    ,online_or_in_person
    ,day_of_week
ORDER BY total_value DESC;

-- Output
-- BANK_NAME	ONLINE_OR_IN_PERSON	DAY_OF_WEEK	TOTAL_VALUE
-- DS	In-Person	Thu	75582
-- DSB	In-Person	Sat	72679
-- DS	Online	Sat	71357
-- DTB	Online	Tue	68959
-- DTB	In-Person	Sat	66334
-- DS	In-Person	Wed	63686
-- DSB	Online	Sat	61350
-- DS	Online	Wed	59104
-- DS	Online	Fri	58731
-- DS	In-Person	Fri	58599
-- DTB	In-Person	Thu	57605
-- DTB	In-Person	Tue	54029
-- DTB	Online	Thu	53756
-- DTB	In-Person	Wed	52819
-- DS	In-Person	Sun	51301
-- DTB	Online	Sun	49087
-- DSB	Online	Wed	47372
-- DSB	Online	Fri	45647
-- DSB	In-Person	Mon	43546
-- DS	In-Person	Mon	42806
-- DTB	In-Person	Fri	41861
-- DTB	Online	Mon	38688
-- DSB	In-Person	Sun	37755
-- DSB	In-Person	Thu	37567
-- DS	Online	Tue	36639
-- DSB	In-Person	Wed	36069
-- DTB	Online	Wed	35313
-- DS	In-Person	Sat	34867
-- DS	Online	Mon	33563
-- DSB	Online	Thu	33463
-- DS	In-Person	Tue	32607
-- DSB	Online	Tue	32257
-- DSB	Online	Mon	31692
-- DTB	In-Person	Sun	29468
-- DSB	In-Person	Tue	28604
-- DTB	Online	Fri	27366
-- DS	Online	Sun	21761
-- DTB	In-Person	Mon	21561
-- DTB	Online	Sat	21392
-- DS	Online	Thu	13337
-- DSB	Online	Sun	13086
-- DSB	In-Person	Fri	9402


-- Output 3
SELECT
    SPLIT_PART(TRANSACTION_CODE,'-',1) AS bank_name
    ,customer_code
    ,SUM(value) AS total_value
FROM pd2023_wk01
GROUP BY 
    bank_name
    ,customer_code
ORDER BY total_value;

-- Output
-- BANK_NAME	CUSTOMER_CODE	TOTAL_VALUE
-- DS	100003	25482
-- DSB	100000	27585
-- DSB	100002	27936
-- DTB	100007	29308
-- DSB	100007	29702
-- DSB	100006	32333
-- DTB	100005	37795
-- DSB	100004	39003
-- DS	100005	39668
-- DTB	100006	41909
-- DTB	100004	44435
-- DSB	100008	47121
-- DTB	100002	48616
-- DSB	100009	51749
-- DTB	100009	52926
-- DS	100001	53063
-- DSB	100005	56396
-- DS	100008	56400
-- DS	100009	56581
-- DS	100000	57909
-- DSB	100003	58154
-- DTB	100001	60675
-- DS	100004	63315
-- DSB	100001	67856
-- DTB	100008	69352
-- DS	100002	69803
-- DTB	100010	71396
-- DS	100007	76190
-- DTB	100000	77252
-- DS	100006	77636
-- DS	100010	77893
-- DTB	100003	84574
-- DSB	100010	92654
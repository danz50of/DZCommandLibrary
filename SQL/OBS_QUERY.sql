--SELECT * 
select DISTINCT A.CONTRACT, A.TOP_LEVEL_PART_NO, A.PART_NO, B.TOP_LEVEL_PART_NO COMP_TOP_LVL_PART
, C.PART_STATUS COMP_PART_STATUS, C.ACCOUNTING_GROUP COMP_ACCOUNTING_GROUP_CODE
from ifsapp.part_cost_bucket A, ifsapp.part_cost_bucket b, IFSAPP.INVENTORY_PART C
where 
B.CONTRACT = A.CONTRACT AND B.PART_NO = A.PART_NO AND
B.COST_SET = A.COST_SET AND B.COST_BUCKET_ID = A.COST_BUCKET_ID AND
C.PART_NO = B.TOP_LEVEL_PART_NO AND C.CONTRACT = B.CONTRACT AND
A.top_level_part_NO IN (&OBS_INVENTORY) AND
C.PART_STATUS <> 'O' AND C.ACCOUNTING_GROUP LIKE 'FG%' AND
A.COST_BUCKET_ID = '110' AND A.COST_SET = 1


--add exist clause
AND NOT EXISTS (SELECT * FROM IFSAPP.PART_COST_BUCKET D 
WHERE D.PART_NO = A.PART_NO AND
D.CONTRACT = A.CONTRACT AND
D.TOP_LEVEL_PART_NO NOT IN (&OBS_INVENTORY))



--*******************************Testing queries****************************************************
--IGNOR BELOW

select PART_NO, COMPONENT_PART from manuf_structure where part_no IN ('DEV-COL510-57S','PM1')

SELECT CONTRACT, TOP_LEVEL_PART_NO FROM IFSAPP.PART_COST_BUCKET WHERE TOP_LEVEL_PART_NO = 'DEV-139-0035'




SELECT TOP_LEVEL_PART_NO
FROM IFSAPP.PART_COST_BUCKET B WHERE B.TOP_LEVEL_PART_NO = A.TOP_LEVEL_PART_NO
AND B.COST_SET = A.COST_SET AND B.COST_BUCKET_ID = A.COST_BUCKET_ID




SELECT CONTRACT, TOP_LEVEL_PART_NO FROM IFSAPP.PART_COST_BUCKET WHERE TOP_LEVEL_PART_NO = 'DEV-139-0035'







--SELECT PART_NO, COMPONENT_PART
SELECT DISTINCT(COST.TOP_LEVEL_PART_NO), STRCT.PART_NO, STRCT.COMPONENT_PART, 
STRCT.ENG_CHG_LEVEL,
STRCT.EFF_PHASE_IN_DATE, STRCT.EFF_PHASE_OUT_DATE,INVENTORY_PART_API.GET_PART_STATUS('MP', STRCT.PART_NO) PART_STATUS
FROM MANUF_STRUCTURE STRCT, PART_COST_BUCKET COST 
WHERE STRCT.CONTRACT = COST.CONTRACT
AND COST.COST_SET = 1 AND 
STRCT.COMPONENT_PART = COST.PART_NO AND STRCT.ENG_CHG_LEVEL = 
(SELECT MAX(LEVL.ENG_CHG_LEVEL) FROM MANUF_STRUCTURE LEVL WHERE LEVL.PART_NO = STRCT.PART_NO AND LEVL.CONTRACT = STRCT.CONTRACT)
AND STRCT.CONTRACT = 'MP' AND INVENTORY_PART_API.GET_PART_STATUS('MP', STRCT.PART_NO) <> 'O'
AND COST.TOP_LEVEL_PART_NO in ('DEV-COL510-57S')
ORDER BY COST.TOP_LEVEL_PART_NO


SELECT DISTINCT TOP_LEVEL_PART_NO, INVENTORY_PART_API.GET_PART_STATUS('MP', TOP_LEVEL_PART_NO) 
FROM PART_COST_BUCKET WHERE PART_NO = 'ST632' AND COST_SET = 1 AND CONTRACT = 'MP' 



SELECT DISTINCT PART_NO, TOP_LEVEL_PART_NO 
FROM PART_COST_BUCKET 
WHERE TOP_LEVEL_PART_NO = 'DEV-COL510-57S'
AND COST_SET = 1 AND CONTRACT = 'MP'




select cost_set, top_level_part_no from part_cost_bucket where part_no = '540-9407'
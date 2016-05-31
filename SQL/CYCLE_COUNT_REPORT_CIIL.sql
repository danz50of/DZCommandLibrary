--GOOD CODE


SELECT PART_NO, DESCRIPTION, SERIAL_NO, COST_PER_UNIT, DEMAND, ABC_CLASS, ACCOUNTING_GROUP, LOCATION_NO, MIN_LAST_COUNT_DATE, ACTUAL_LAST_COUNT_DATE, QTY_ONHAND, DAYS_TO_COUNT, MIN_LAST_COUNT_DATE + DAYS_TO_COUNT AS NEXT_COUNT_DATE, QTY_COUNTED
FROM(
select a.PART_NO, b.description, A.SERIAL_NO, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(a.contract, a.part_no), 2) COST_PER_UNIT,
IFSAPP.ORDER_SUPPLY_DEMAND_API.GET_SUM_QTY_DEMAND('MP',a.PART_NO, '*') DEMAND,
b.abc_class,
B.ACCOUNTING_GROUP,
a.LOCATION_NO, 
(SELECT MIN(NVL(C.LAST_COUNT_DATE, TO_DATE('1/1/1900','MM/DD/YYYY'))) FROM ifsapp.INVENTORY_PART_LOCATION C WHERE C.PART_NO = A.PART_NO AND C.CONTRACT = A.CONTRACT GROUP BY C.PART_NO, C.CONTRACT) MIN_LAST_COUNT_DATE,
A.LAST_COUNT_DATE ACTUAL_LAST_COUNT_DATE,
a.qty_onhand,
        (CASE
            WHEN B.ABC_CLASS = 'A' THEN 30
            WHEN B.ABC_CLASS = 'B' THEN 60
            WHEN B.ABC_CLASS = 'C' THEN 90
            ELSE 120
        END) DAYS_TO_COUNT,
    NULL QTY_COUNTED
    from ifsapp.inventory_part_location a, ifsapp.inventory_part b 
    where a.contract = b.contract and a.part_no = b.part_no 
    and a.contract = 'CIIL' -- and a.warehouse = 'AI' and a.location_no <> 'JOY'
    --and a.part_no IN ('PRG-1','PRG-UNV')
    order by a.part_no, a.location_no)
WHERE (MIN_LAST_COUNT_DATE + DAYS_TO_COUNT) < SYSDATE --AND ABC_CLASS = '&ABC_CLASS' AND ACCOUNTING_GROUP like '&ACCOUNTING_GROUP'



--group by PART_NO, DESCRIPTION,COST_PER_UNIT, DEMAND, ABC_CLASS, LOCATION_NO, DAYS_TO_COUNT, QTY_COUNTED





SELECT * FROM ifsapp.inventory_transaction_hist2 WHERE PART_NO = 'SLWS220/BK'













select a.PART_NO, b.description, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(a.contract, a.part_no), 2) COST_PER_UNIT,
IFSAPP.ORDER_SUPPLY_DEMAND_API.GET_SUM_QTY_DEMAND('MP',a.PART_NO, '*') DEMAND,
b.abc_class,
a.LOCATION_NO, 
(SELECT MIN(NVL(C.LAST_COUNT_DATE, TO_DATE('1/1/1900','MM/DD/YYYY'))) FROM INVENTORY_PART_LOCATION C WHERE C.PART_NO = A.PART_NO AND C.CONTRACT = A.CONTRACT GROUP BY C.PART_NO, C.CONTRACT) LAST_COUNT_DATE,
a.qty_onhand,
        (CASE
            WHEN B.ABC_CLASS = 'A' THEN 30
            WHEN B.ABC_CLASS = 'B' THEN 60
            WHEN B.ABC_CLASS = 'C' THEN 90
            ELSE 120
        END) DAYS_TO_COUNT,
    NULL QTY_COUNTED
    from inventory_part_location a, ifsapp.inventory_part b 
    where a.contract = b.contract and a.part_no = b.part_no 
    and a.contract = 'MP' and a.warehouse = 'AI' and a.location_no <> 'JOY'
    and a.part_no = '009-0223'
    order by a.part_no, a.location_no
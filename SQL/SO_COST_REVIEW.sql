select  SO.ORDER_NO, SOC.PART_NO, SOC.CLOSE_DATE, SOC.REVISED_QTY_DUE BUILD_QTY, SOC.QTY_COMPLETE,
SOC.TOTAL_STD_ACCUM_COST TOTAL_STANDARD_COST, SOC.TOTAL_ACTUAL_ACCUM_COST TOTAL_ACTUAL_COST, SOC.ACT_STD_ACCUM DIFF,
SOC.ACT_STD_ACCUM_FACTOR PRCT_DIFF, IFSAPP.WORK_CENTER_API.GET_DEPARTMENT_NO('MP', IFSAPP.SHOP_ORDER_OPERATION_API.GET_WORK_CENTER_NO(SO.ORDER_NO, '*', '*', 
(select min(operation_no) from shop_order_operation where order_no = so.order_no ))) DEPARTMENT
from shop_ord SO, SHOP_ORDER_COST_OVERVIEW SOC 
where TRUNC(SO.CLOSE_DATE,'DD') between to_date('11/1/2016','mm/dd/yyyy') and to_date('11/30/2016','mm/dd/yyyy')
and so.contract = 'MP'
AND SO.ORDER_NO = SOC.ORDER_NO
order by SOC.ACT_STD_ACCUM desc


SELECT * FROM SHOP_ORDER_COST_OVERVIEW WHERE ORDER_NO = '1131019'

select IFSAPP.SHOP_ORDER_OPERATION_API.GET_WORK_CENTER_NO('1131019', '*', '*', 10) from dual

select IFSAPP.WORK_CENTER_API.GET_DEPARTMENT_NO('MP', 'C-APK') FROM DUAL


select * from shop_order_operation where order_no = '1131019'

select  SO.ORDER_NO, SOC.PART_NO, TRUNC(SOC.CLOSE_DATE,'DD'), SOC.REVISED_QTY_DUE , SOC.QTY_COMPLETE,
SOC.TOTAL_STD_ACCUM_COST , SOC.TOTAL_ACTUAL_ACCUM_COST , SOC.ACT_STD_ACCUM ,
SOC.ACT_STD_ACCUM_FACTOR , IFSAPP.WORK_CENTER_API.GET_DEPARTMENT_NO('MP', IFSAPP.SHOP_ORDER_OPERATION_API.GET_WORK_CENTER_NO(SO.ORDER_NO, '*', '*', 
(select min(operation_no) from ifsapp.shop_order_operation where order_no = so.order_no ))) 
from ifsapp.shop_ord SO, ifsapp.SHOP_ORDER_COST_OVERVIEW SOC 
where TRUNC(SO.CLOSE_DATE,'DD') between to_date('11/1/2016','mm/dd/yyyy') and to_date('11/30/2016','mm/dd/yyyy')
and so.contract = 'MP'
AND SO.ORDER_NO = SOC.ORDER_NO
order by SOC.ACT_STD_ACCUM desc
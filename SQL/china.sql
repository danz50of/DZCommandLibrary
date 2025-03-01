select * from &AO..inventory_part_config_all
where planner_buyer = 'FG_CHINA'

SELECT ORDER_NO, LINE_NO, RELEASE_NO, PART_NO, BUY_QTY_DUE, DATE_ENTERED, PLANNED_DELIVERY_DATE, PLANNED_RECEIPT_DATE,  STATE

SELECT *
FROM PURCHASE_ORDER_LINE_PART WHERE PART_NO = 'LMAM1940'
AND upper(STATE) IN ('RELEASED','CONFIRMED','ARRIVED','PLANNED')



SELECT ifsapp.ORDER_SUPPLY_DEMAND_EXT.PART_NO, ifsapp.ORDER_SUPPLY_DEMAND_EXT.CONTRACT, 
ifsapp.INVENTORY_PART_API.GET_PLANNER_BUYER(ifsapp.ORDER_SUPPLY_DEMAND_EXT.CONTRACT,ifsapp.ORDER_SUPPLY_DEMAND_EXT.PART_NO) PLANNER,
ifsapp.ORDER_SUPPLY_DEMAND_EXT.ORDER_SUPPLY_DEMAND_TYPE, 
ifsapp.ORDER_SUPPLY_DEMAND_EXT.ORDER_NO, 
ifsapp.ORDER_SUPPLY_DEMAND_EXT.LINE_NO, 
ifsapp.ORDER_SUPPLY_DEMAND_EXT.REL_NO, 
ifsapp.ORDER_SUPPLY_DEMAND_EXT.DATE_REQUIRED,
ifsapp.ORDER_SUPPLY_DEMAND_EXT.QTY_SUPPLY, 
ifsapp.ORDER_SUPPLY_DEMAND_EXT.QTY_DEMAND
--FROM ifsapp.LEVEL_1_PART JOIN
from ifsapp.ORDER_SUPPLY_DEMAND_EXT where  
ORDER_SUPPLY_DEMAND_TYPE IN ('Purch order', 'Purch req','MS','Material res SO','Shop ord req') AND
ifsapp.INVENTORY_PART_API.GET_PLANNER_BUYER(ifsapp.ORDER_SUPPLY_DEMAND_EXT.CONTRACT,ifsapp.ORDER_SUPPLY_DEMAND_EXT.PART_NO) = 'FG_CHINA'


select distinct order_supply_Demand_type from &ao..order_supply_demand_ext




select * from ifsinfo.prl_fgchina_sup_dem WHERE PLANNER = 'FG_CHINA'

/*
LEFT JOIN &ao..PURCHASE_ORDER_LINE_PART
ON &ao..ORDER_SUPPLY_DEMAND_EXT.ORDER_NO = &ao..PURCHASE_ORDER_LINE_PART.ORDER_NO
AND &ao..ORDER_SUPPLY_DEMAND_EXT.PART_NO = &ao..PURCHASE_ORDER_LINE_PART.PART_NO
AND &ao..ORDER_SUPPLY_DEMAND_EXT.LINE_NO = &ao..PURCHASE_ORDER_LINE_PART.LINE_NO
AND &ao..ORDER_SUPPLY_DEMAND_EXT.REL_NO = &ao..PURCHASE_ORDER_LINE_PART.RELEASE_NO
*/



select * from ifsinfo.prl_fgchina_header

select * from ifsinfo.prl_fgchina_forecast_ial

select * from ifsinfo.prl_fgchina_sup_dem_ext_Ial


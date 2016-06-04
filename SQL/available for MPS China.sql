--Final Report Query less po boat date.

select part_no, contract, planner, order_supply_demand_type, order_no, line_no, rel_no,
date_required, qty_supply, qty_demand, status_desc, forecast_lev0, consumed_forecast, unconsumed_forecast,
projected_balance, proj_avail, 
(case order_supply_demand_type
when 'Purch order' then ifsapp.mps_get_proj_del_purch(part_no, order_no, rel_no, line_no)
else null end) Delivery_Date,
(case order_supply_demand_type
when 'Purch order' then ifsapp.mps_get_proj_arv_purch(part_no, order_no, rel_no, line_no)
else null end) Arrival_Date
from ifsinfo.prl_fgchina_sup_dem_ext--_IAL 
WHERE PART_NO = 'PJF2-UNV'
order by PART_NO, date_required, order_supply_demand_type desc




SELECT MPS_GET_PROJ_DEL_PURCH('FG_CHINA_BUY', '36874', '1', '1'), mps_get_proj_arv_purch('FG_CHINA_BUY', '36874', '1', '1') from dual



SELECT * FROM IFSAPP.PURCHASE_ORDER_LINE_ALL WHERE PART_NO = 'FG_CHINA_BUY'


SELECT * FROM IFSINFO.PRL_FGCHINA_HEADER



SELECT  IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_INVENTORY_QTY_ONHAND('MP','PJF2-UNV-S','*') TOTAL,
IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_PLANNABLE_QTY_ONHAND('MP','PJF2-UNV-S','*') ON_HAND,
IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_SALES_PLANNABLE_QTY_RES('MP','PJF2-UNV-S','*') RESERVED
 FROM DUAL
 
 
select ifsapp.inventory_part_location_api.get_total_qty_onhand('MP','PJF2-UNV-S') AVAIL
 FROM DUAL
 
 
 
 select A.PART_NO, A.DESCRIPTION, A.CONTRACT
, IFSAPP.INVENTORY_PART_PLANNING_API.GET_SAFETY_STOCK('MP', A.PART_NO) SAFTEY_STOCK,
IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_INVENTORY_QTY_ONHAND(A.CONTRACT,A.PART_NO,'*') TOTAL_QTY,
IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_PLANNABLE_QTY_ONHAND(A.CONTRACT,A.PART_NO,'*') ON_HAND,
IFSAPP.INVENTORY_PART_IN_STOCK_API.GET_SALES_PLANNABLE_QTY_RES(A.CONTRACT,A.PART_NO,'*') RESERVED,
ifsapp.order_supply_demand_api.GET_QTY_PLANNABLE_SHELL('MP','FG_CHINA_BUY',TO_DATE('7/01/2008','MM/DD/YYYY'),'1') QTY
from IFSAPP.inventory_part A
where planner_buyer = 'FG_CHINA'



SELECT * FROM IFSINFO.PRL_FGCHINA_HEADER where part_no = 'PJF2-UNV'


select *
from ifsinfo.prl_fgchina_sup_dem_ext WHERE PART_NO = 'FG_CHINA_BUY'
ORDER BY part_no, DATE_REQUIRED, ORDER_SUPPLY_DEMAND_TYPE DESC




select * from ifsinfo.prl_fgchina_sup_dem_ext WHERE PART_NO = 'FG_CHINA_BUY'
order by date_required, order_supply_demand_type desc








SELECT CONTRACT, PART_NO, DATE_REQUIRED, order_supply_demand_api.GET_DUE_QTY_TO_DATE('MP','FG_CHINA_BUY',TO_CHAR(DATE_REQUIRED, 'MM/DD/YYYY')) 
FROM ORDER_SUPPLY_DEMAND_EXT WHERE PART_NO = 'FG_CHINA_BUY'


--select PART_NO, CONTRACT, PLANNER, ORDER_SUPPLY_DEMAND_TYPE, ORDER_NO, LINE_NO, REL_NO, DATE_REQUIRED, QTY_SUPPLY, QTY_DEMAND, STATUS_DESC, 
--NULL AS FORECAST_LEV0, NULL AS CONSUMED_FORECAST, NULL AS UNCONSUMED_FORECAST 
select part_no, date_required, ifsapp.order_supply_demand_api.get_net_qty_to_date('MP', part_no, date_required)
from ifsapp.order_supply_demand_ext WHERE PART_NO = 'FG_CHINA_BUY'

UNION
select part_no, contract, 'FG_CHINA_BUY', '_FORECAST_INFO', NULL, NULL, NULL, MS_DATE, NULL, NULL, NULL, 
FORECAST_LEV0, CONSUMED_FORECAST, UNCONSUMED_FORECAST 
--SELECT *
from level_1_forecast where part_no = 'FG_CHINA_BUY'
AND FORECAST_LEV0 > 0
ORDER BY DATE_REQUIRED, ORDER_SUPPLY_DEMAND_TYPE DESC



SELECT IFSAPP.ORDER_SUPPLY_DEMAND_EXT.PART_NO, IFSAPP.ORDER_SUPPLY_DEMAND_EXT.CONTRACT, 
IFSAPP.INVENTORY_PART_API.GET_PLANNER_BUYER(IFSAPP.ORDER_SUPPLY_DEMAND_EXT.CONTRACT,IFSAPP.ORDER_SUPPLY_DEMAND_EXT.PART_NO) PLANNER,
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.ORDER_SUPPLY_DEMAND_TYPE, 
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.ORDER_NO, 
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.LINE_NO, 
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.REL_NO, 
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.DATE_REQUIRED,
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.QTY_SUPPLY, 
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.QTY_DEMAND,
IFSAPP.ORDER_SUPPLY_DEMAND_EXT.status_desc,
NULL AS FORECAST_LEV0,
NULL AS CONSUMED_FORECAST,
NULL AS UNCONSUMED_FORECAST
from IFSAPP.ORDER_SUPPLY_DEMAND_EXT where  
ORDER_SUPPLY_DEMAND_TYPE IN 
('Purch order', 'Purch req','MS','Material res SO','Shop ord req')
AND IFSAPP.inventory_part_api.get_planner_buyer(IFSAPP.order_supply_demand_ext.contract,
IFSAPP.order_supply_demand_ext.part_no) = 'FG_CHINA'
UNION
select part_no, contract, IFSAPP.INVENTORY_PART_API.GET_PLANNER_BUYER(CONTRACT,PART_NO) PLANNER
, '_FORECAST_INFO', NULL, NULL, NULL, MS_DATE, NULL, NULL, NULL, 
FORECAST_LEV0, CONSUMED_FORECAST, UNCONSUMED_FORECAST 
--SELECT *
from IFSAPP.level_1_forecast where IFSAPP.INVENTORY_PART_API.GET_PLANNER_BUYER(CONTRACT,PART_NO) = 'FG_CHINA'
AND FORECAST_LEV0 > 0





ifsapp.order_supply_demand_api.get_net_qty_to_date('MP', part_no, date_required)
-- code for current IAL
   SELECT &ao..order_supply_demand_ext.part_no,
          &ao..order_supply_demand_ext.contract,
          &ao..inventory_part_api.get_planner_buyer
                            (&ao..order_supply_demand_ext.contract,
                             &ao..order_supply_demand_ext.part_no
                            ) planner,
          &ao..order_supply_demand_ext.order_supply_demand_type,
          &ao..order_supply_demand_ext.order_no,
          &ao..order_supply_demand_ext.line_no,
          &ao..order_supply_demand_ext.rel_no,
          &ao..order_supply_demand_ext.date_required,
          &ao..order_supply_demand_ext.qty_supply,
          &ao..order_supply_demand_ext.qty_demand,
          &ao..order_supply_demand_ext.status_desc, NULL AS forecast_lev0,
          NULL AS consumed_forecast, NULL AS unconsumed_forecast,
          &ao..order_supply_demand_api.get_net_qty_to_date(&ao..order_supply_demand_ext.contract, &ao..order_supply_demand_ext.part_no, &ao..order_supply_demand_ext.date_required) Projected_Balance
     FROM &ao..order_supply_demand_ext
    WHERE order_supply_demand_type IN
             ('Purch order', 'Purch req', 'MS', 'Material res SO',
              'Shop ord req', 'Cust order')
      AND &ao..inventory_part_api.get_planner_buyer
                                     (&ao..order_supply_demand_ext.contract,
                                      &ao..order_supply_demand_ext.part_no
                                     ) = 'FG_CHINA'
   UNION
   SELECT part_no, contract,
          &ao..inventory_part_api.get_planner_buyer (contract,
                                                       part_no
                                                      ) planner,
          '_FORECAST_INFO', NULL, NULL, NULL, ms_date, NULL, NULL, NULL,
          forecast_lev0, consumed_forecast, unconsumed_forecast, null
     FROM &ao..level_1_forecast
    WHERE &ao..inventory_part_api.get_planner_buyer (contract, part_no) =
                                                                    'FG_CHINA'
      AND forecast_lev0 > 0
          WITH READ ONLY;
          
          
          
          
          
          
SELECT order_supply_demand_api.GET_FUTURE_DUE_QTY('MP','FG_CHINA_BUY',DATE_REQUIRED, DATE_REQUIRED)
FROM DUAL





   SELECT IFSAPP.order_supply_demand_ext.part_no,
          IFSAPP.order_supply_demand_ext.contract,
          IFSAPP.inventory_part_api.get_planner_buyer
                            (IFSAPP.order_supply_demand_ext.contract,
                             IFSAPP.order_supply_demand_ext.part_no
                            ) planner,
          IFSAPP.order_supply_demand_ext.order_supply_demand_type,
          IFSAPP.order_supply_demand_ext.order_no,
          IFSAPP.order_supply_demand_ext.line_no,
          IFSAPP.order_supply_demand_ext.rel_no,
          IFSAPP.order_supply_demand_ext.date_required,
          IFSAPP.order_supply_demand_ext.qty_supply,
          IFSAPP.order_supply_demand_ext.qty_demand,
          IFSAPP.order_supply_demand_ext.status_desc, NULL AS forecast_lev0,
          NULL AS consumed_forecast, NULL AS unconsumed_forecast,
          IFSAPP.order_supply_demand_api.get_net_qty_to_date(IFSAPP.order_supply_demand_ext.contract, IFSAPP.order_supply_demand_ext.part_no, IFSAPP.order_supply_demand_ext.date_required) Projected_Balance,
IFSAPP.MPS_GET_PROJ_AVAIL(PART_NO, DATE_REQUIRED) PROJ_AVAIL     
     FROM IFSAPP.order_supply_demand_ext
    WHERE order_supply_demand_type IN
             ('Purch order', 'Purch req', 'MS', 'Material res SO',
              'Shop ord req', 'Cust order')
      AND IFSAPP.inventory_part_api.get_planner_buyer
                                     (IFSAPP.order_supply_demand_ext.contract,
                                      IFSAPP.order_supply_demand_ext.part_no
                                     ) = 'FG_CHINA'
   UNION
   SELECT part_no, contract,
          IFSAPP.inventory_part_api.get_planner_buyer (contract,
                                                       part_no
                                                      ) planner,
          '_FORECAST_INFO', NULL, NULL, NULL, ms_date, NULL, NULL, NULL,
          forecast_lev0, consumed_forecast, unconsumed_forecast, 
IFSAPP.order_supply_demand_api.get_net_qty_to_date(contract, part_no, ms_date) Projected_Balance,
IFSAPP.MPS_GET_PROJ_AVAIL(PART_NO, MS_DATE) PROJ_AVAIL
     FROM IFSAPP.level_1_forecast
    --WHERE IFSAPP.inventory_part_api.get_planner_buyer (contract, part_no) = 'FG_CHINA'
    WHERE PART_NO = 'FG_CHINA_BUY'
      AND forecast_lev0 > 0
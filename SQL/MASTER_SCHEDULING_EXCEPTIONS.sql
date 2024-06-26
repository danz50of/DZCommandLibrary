---------MONTHLY WEIGHTED DEMAND ANALYSIS 

--SELECT * FROM IFSINFO.PRL_WGHT_DEM_MS_MNTH_SUM 

--WEIGHTED MONTHLY DEMAND ANALYSIS 

-- MUST UPDATE PRL_WEIGHTED_DEMAND_MS IAL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT PART_NO, MS_SET, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(contract, part_no), 2) COST_PER_UNIT,
IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand(CONTRACT,PART_NO,NULL) ONHAND, 
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) OPEN_ORDERS,
round(IFSAPP.MPS_Get_Current_Forecast(contract, part_no, sysdate),2) FORECAST_CURR_MONTH,
IFSAPP.INVENTORY_PART_PLANNING_API.Get_safety_stock(CONTRACT, PART_NO) SAFETY_STOCK,
IFSAPP.PRL_WGHT_DEM_Get_Weighted_Ave(part_no, &MONTH_1, &MONTH_2, &MONTH_3, &MONTH_4) WEIGHTED_MONTHLY_DEMAND,
IFSAPP.MPS_EVALUATE_FLAG(IFSAPP.PRL_WGHT_DEM_Get_Weighted_Ave(part_no, &MONTH_1, &MONTH_2, &MONTH_3, &MONTH_4), 
IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand(CONTRACT,PART_NO,NULL),
IFSAPP.INVENTORY_PART_PLANNING_API.Get_safety_stock(CONTRACT, PART_NO),
round(IFSAPP.MPS_Get_Current_Forecast(contract, part_no, sysdate),2))
FLAG
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_SET = &MS_SET
GROUP BY PART_NO, CONTRACT, MS_SET;

-- SHOW THIS REPORT TO JOY AS A POSSIBLE EXCEPTION REPORT    EXCEPTION FOR AVAIL. TO PLAN.

SELECT PART_NO, 
MS_DATE, 
IFSAPP.INVENTORY_PART_PLANNING_API.Get_Safety_Stock('MP', PART_NO) SAFETY_STOCK,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, ifsapp.mps_get_dem_counter(part_no)) AS ATP_DEMAND_TF,
IFSAPP.MPS_GET_SUM_SUPPLY('MP', PART_NO, 1, 1, IFSAPP.MPS_GET_DEM_COUNTER(PART_NO)) AS SUPPLY_DEMAND_TF,
TRUNC(((IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, ifsapp.mps_get_dem_counter(part_no)))/(IFSAPP.MPS_GET_SUM_SUPPLY('MP', PART_NO, 1, 1, IFSAPP.MPS_GET_DEM_COUNTER(PART_NO))))*100) AS PERCENT_LEFT_SUPPLY_DEM,
(CASE 
WHEN IFSAPP.INVENTORY_PART_PLANNING_API.Get_Safety_Stock('MP', PART_NO) > 0 THEN
ROUND(((IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, ifsapp.mps_get_dem_counter(part_no)))/(IFSAPP.INVENTORY_PART_PLANNING_API.Get_Safety_Stock('MP', PART_NO))), 2)
ELSE 100
END) PERCENT_SS_LEFT_DEM,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, COUNTER) AS ATP_PLANNING_TF,
IFSAPP.MPS_GET_SUM_SUPPLY('MP', PART_NO, 1, 1, COUNTER) AS SUPPLY_PLANNING_TF,
TRUNC(((IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, COUNTER))/(IFSAPP.MPS_GET_SUM_SUPPLY('MP', PART_NO, 1, 1, COUNTER)))*100) AS PERCENT_LEFT_SUPPLY_PLN,
(CASE 
WHEN IFSAPP.INVENTORY_PART_PLANNING_API.Get_Safety_Stock('MP', PART_NO) > 0 THEN
ROUND(((IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, COUNTER))/(IFSAPP.INVENTORY_PART_PLANNING_API.Get_Safety_Stock('MP', PART_NO))),2)
ELSE 100
END) PERCENT_SS_LEFT_PLN
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_DATE = IFSAPP.MPS_GET_NEXT_PLN_DATE(1, part_no)



SELECT * FROM PRL_MPS_TF_COUNTERS






select * from ifsapp.level_1_forecast
where part_no = 'FDS-3250-S'





select * from level_1_forecast

select A.PART_NO, LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev0('MP', A.PART_NO, 1) AS "LEVEL_0_FORECAST",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev1('MP', A.PART_NO, 1) AS "LEVEL_1_FORECAST",
(SELECT SUM(ACTUAL_DEMAND) FROM LEVEL_1_FORECAST B WHERE A.PART_NO = B.PART_NO) AS "ACTUAL_DEMAND",
counter,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', A.PART_NO, 1, (SELECT MIN(C.COUNTER) FROM IFSAPP.LEVEL_1_FORECAST C WHERE A.PART_NO = C.PART_NO), (SELECT MAX(C.COUNTER) FROM IFSAPP.LEVEL_1_FORECAST C WHERE A.PART_NO = C.PART_NO))
AS "CUMULATIVE_ATP" 
FROM LEVEL_1_FORECAST A
GROUP BY A.PART_NO, counter


select PART_NO, COUNTER, MS_DATE, FORECAST_LEV0, FORECAST_LEV1, ACTUAL_DEMAND, UNCONSUMED_FORECAST, 
PROJ_AVAIL, AVAIL_TO_PROM,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, COUNTER, IFSAPP.LEVEL_1_FORECAST_API.get_next_counter_('MP', PART_NO, 1, COUNTER))
AS CUMULATIVE_ATP,
IFSAPP.LEVEL_1_FORECAST_API.get_next_counter_('MP', PART_NO, 1, COUNTER) AS NEXT_COUNTER,
TRUNC(SYSDATE), TRUNC(SYSDATE + IFSAPP.LEVEL_1_PART_API.Get_Planning_Timefence('MP', PART_NO))
from IFSAPP.level_1_forecast
WHERE PART_NO = 'CMJ500'


-- SHOW THIS REPORT TO JOY AS A POSSIBLE EXCEPTION REPORT 

SELECT PART_NO, COUNTER, MS_DATE, 
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, IFSAPP.LEVEL_1_FORECAST_API.get_PREV_counter_('MP', PART_NO, 1, COUNTER)) AS CUMULATIVE_ATP_DEMAND_TF,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_atp('MP', PART_NO, 1, 1, COUNTER) AS CUMULATIVE_ATP_PLANNING_TF
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_DATE = IFSAPP.LEVEL_1_PART_API.Get_Planning_Tf_Date('MP', PART_NO, 1)






--View to Give Important dates to planning   CREATED MPS_TF_DATES 





------------------------------------------------------

SELECT PART_NO, COUNTER, MS_DATE, MASTER_SCHED_RCPT, SCHED_ORDERS, ROLL_UP_RCPT, CONSUMED_SUPPLY, AVAIL_TO_PROM 
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MASTER_SCHED_RCPT > 0
AND MS_DATE >= TRUNC(SYSDATE)
ORDER BY part_no, MS_DATE

SELECT * 
FROM IFSAPP.LEVEL_1_FORECAST
WHERE PART_NO = 'DCT100'

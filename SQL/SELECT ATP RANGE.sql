





-- Query to review availability to plan values 

SELECT PART_NO, MS_SET, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(contract, part_no), 2) COST_PER_UNIT,
MPS_GET_CURRENT_DAY(PART_NO) CURRENT_DAY, 
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) TO_DEM_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) TO_DEM_DEM,
IFSAPP.mps_get_demand_date(part_no) DEMAND_TF_DAY,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no), IFSAPP.mps_get_pln_counter(part_no)) DEM_PLN_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no)+1, IFSAPP.mps_get_pln_counter(part_no)) DEM_PLN_DEM,
IFSAPP.mps_get_planning_date(part_no) PLANNING_TF_DAY,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_DEM,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev0('MP', PART_NO, MS_SET) LEVEL_0_FORECAST,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev1('MP', PART_NO, MS_SET) LEVEL_1_FORECAST,
IFSAPP.PRL_WGHT_DEM_Get_Weighted_Ave(part_no, 15, 15, 30, 40) WEIGHTED_MONTHLY_DEMAND
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_SET = 1
GROUP BY PART_NO, CONTRACT, MS_SET
ORDER BY MS_SET, PART_NO


----------MONTHLY WEIGHTED DEMAND ANALYSIS 

--SELECT * FROM IFSINFO.PRL_WGHT_DEM_MS_MNTH_SUM 

--WEIGHTED MONTHLY DEMAND ANALYSIS 

-- MUST UPDATE PRL_WEIGHTED_DEMAND_MS IAL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT PART_NO, MS_SET, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(contract, part_no), 2) COST_PER_UNIT,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_DEM,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev0('MP', PART_NO, MS_SET) LEVEL_0_FORECAST,
IFSAPP.PRL_WGHT_DEM_Get_Weighted_Ave(part_no, &MONTH_1, &MONTH_2, &MONTH_3, &MONTH_4) WEIGHTED_MONTHLY_DEMAND
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_SET = &MS_SET
GROUP BY PART_NO, CONTRACT, MS_SET;

---------------------------------------------------------------TEST 

SELECT PART_NO, MS_SET, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(contract, part_no), 2) COST_PER_UNIT,
MPS_GET_CURRENT_DAY(PART_NO) CURRENT_DAY, 
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) TO_DEM_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) TO_DEM_DEM,
IFSAPP.mps_get_demand_date(part_no) DEMAND_TF_DAY,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no), IFSAPP.mps_get_pln_counter(part_no)) DEM_PLN_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no)+1, IFSAPP.mps_get_pln_counter(part_no)) DEM_PLN_DEM,
IFSAPP.mps_get_planning_date(part_no) PLANNING_TF_DAY,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_ATP,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) SUM_TOTAL_DEM,
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev0('MP', PART_NO, MS_SET) LEVEL_0_FORECAST
FROM IFSAPP.LEVEL_1_FORECAST
WHERE MS_SET = &MS_SET
GROUP BY PART_NO, CONTRACT, MS_SET
CREATE OR REPLACE VIEW MPS_PART_REVIEW_IAL AS
SELECT PART_NO, MS_SET, 
ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(contract, part_no), 2) as "COST_PER_UNIT",
MPS_GET_CURRENT_DAY(PART_NO) AS "CURRENT_DAY", 
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) as "TO_DEM_ATP",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_current_counter(part_no)) as "TO_DEM_DEM",
IFSAPP.mps_get_demand_date(part_no) as "DEMAND_TF_DAY",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no), IFSAPP.mps_get_pln_counter(part_no)) as "DEM_PLN_ATP",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, IFSAPP.mps_get_dem_counter(part_no)+1, IFSAPP.mps_get_pln_counter(part_no)) as "DEM_PLN_DEM",
IFSAPP.mps_get_planning_date(part_no) as "PLANNING_TF_DAY",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_atp(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) as "SUM_TOTAL_ATP",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.get_sum_act_dem(contract, part_no, MS_SET, 1, IFSAPP.mps_get_lst_counter(part_no)) as "SUM_TOTAL_DEM",
IFSAPP.LEVEL_1_FORECAST_UTIL_API.Get_Sum_Forecast_lev0('MP', PART_NO, MS_SET) AS "LEVEL_0_FORECAST"
FROM IFSAPP.LEVEL_1_FORECAST
GROUP BY PART_NO, CONTRACT, MS_SET
WITH   read only
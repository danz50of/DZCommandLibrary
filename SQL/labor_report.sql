select OP_ID, a.EMP_NO, PART_NO, a.ACCOUNT_DATE, ORDER_NO, 
ifsapp.time_pers_diary_result_api.Get_Wage_Hours(11,a.emp_no,null,null,null,a.account_date,a.account_date) WAGE_HOURS, 
RUN_STANDARD,  
SETUP_STANDARD,
R_PROD_QTY,
R_DAMAGAED_SCRAP + 
R_SETUP_SCRAP + 
R_OPERATOR_SCRAP + 
R_MACHINE_SCRAP + 
R_OBSOLETE_SCRAP + 
R_RETURN_SCRAP + 
R_REGULAR_SCRAP + 
R_RUSTED_SCRAP + 
R_DESIGN_SCRAP + 
R_OUTSIDE_PROCESS_SCRAP R_TOTAL_SCRAP,
--R_TOTAL_WORKING_DURATION_100, 
R_WORK_HOURS,
S_WORK_HOURS,
--null 
(R_HOT_IRUPT +
R_PROTOTYPE_IRUPT +
R_MEETING_IRUPT +
R_CLEANING_IRUPT + 
R_MAINTENANCE_IRUPT + 
R_MOVING_IRUPT + 
R_REWORK_IRUPT + 
R_SETUP_RESET_IRUPT + 
R_TRAINING_IRUPT + 
R_INSPECTION_IRUPT +
S_HOT_IRUPT +  
S_PROTOTYPE_IRUPT +
S_MEETING_IRUPT + 
S_CLEANING_IRUPT + 
S_MAINTENANCE_IRUPT +  
S_MOVING_IRUPT + 
S_REWORK_IRUPT + 
S_SETUP_RESET_IRUPT + 
S_TRAINING_IRUPT +
S_INSPECTION_IRUPT) TOTAL_Irupt,
--R_LUNCH_IRUPT,  
R_HOT_IRUPT, 
--R_INSPECTION_IRUPT, 
R_PROTOTYPE_IRUPT,
R_MEETING_IRUPT,  
R_CLEANING_IRUPT, 
R_MAINTENANCE_IRUPT, 
R_MOVING_IRUPT, 
R_REWORK_IRUPT, 
R_SETUP_RESET_IRUPT, 
R_TRAINING_IRUPT, 
R_INSPECTION_IRUPT,
WORK_CENTER_NO, 
--S_TOTAL_WORKING_DURATION_100, 
--S_WORK_HOURS,
--S_LUNCH_IRUPT,  
S_HOT_IRUPT,  
S_PROTOTYPE_IRUPT,
S_MEETING_IRUPT, 
S_CLEANING_IRUPT, 
S_MAINTENANCE_IRUPT,  
S_MOVING_IRUPT, 
S_REWORK_IRUPT, 
S_SETUP_RESET_IRUPT, 
S_TRAINING_IRUPT,
S_INSPECTION_IRUPT, 
S_PROD_QTY, 
S_DAMAGAED_SCRAP + 
S_SETUP_SCRAP + 
S_OPERATOR_SCRAP + 
S_MACHINE_SCRAP + 
S_OBSOLETE_SCRAP + 
S_RETURN_SCRAP + 
S_REGULAR_SCRAP + 
S_RUSTED_SCRAP + 
S_DESIGN_SCRAP +
S_OUTSIDE_PROCESS_SCRAP S_TOTAL_SCRAP 
from IFSINFO.prl_labor_rpt_new a
WHERE a.ACCOUNT_DATE BETWEEN TO_DATE('&FROM_DATE','YYYYMMDD') AND TO_DATE('&END_DATE','YYYYMMDD')
order by a.account_date, a.emp_no






select ifsapp.time_pers_diary_result_api.Get_Wage_Hours(11,'3897',null,null,null,to_date('10/13/2009','mm/dd/yyyy'),to_date('10/13/2009','mm/dd/yyyy'))
from dual
select * from ifsapp.level_1_forecast_tab WHERE COUNTER = 1560

select part_no, counter, avail_to_prom, ms_date, forecast_lev0, consumed_forecast, proj_avail, rowversion
from ifsapp.level_1_forecast_tab
order by MS_DATE 

select part_no, counter, avail_to_prom, ms_date, forecast_lev0, consumed_forecast, proj_avail, rowversion,
-- Get next Counter will supply the ID for the next forecast date.  Can be used to calc avail to promise. 
ifsapp.level_1_forecast_api.get_next_counter_('MP', part_no, 1, 1558) as "NEXT_COUNTER",
ifsapp.level_1_forecast_util_api.get_sum_atp('MP', part_no, 1, counter, ifsapp.level_1_forecast_api.get_next_counter_('MP', part_no, 1, counter)) as "CUMULATIVE_ATP"
from ifsapp.level_1_forecast_tab
where MS_DATE >= SYSDATE
--where counter = 1555 

-- Test Query 

select part_no, counter, avail_to_prom, ms_date, forecast_lev0, consumed_forecast, proj_avail, rowversion,
-- Get next Counter will supply the ID for the next forecast date.  Can be used to calc avail to promise. 
ifsapp.level_1_forecast_api.get_next_counter_('MP', part_no, 1, 1558) as "NEXT_COUNTER",
ifsapp.level_1_forecast_api.get_prev_counter_('MP', part_no, 1, 1558) as "PREV_COUNTER",
ifsapp.level_1_forecast_util_api.get_sum_atp('MP', part_no, 1, ifsapp.level_1_forecast_api.get_prev_counter_('MP', part_no, 1, counter), ifsapp.level_1_forecast_api.get_next_counter_('MP', part_no, 1, counter)) as "CUMULATIVE_ATP"
from ifsapp.level_1_forecast_tab
where MS_DATE >= SYSDATE
and PART_NO = 'PLCM-1CP'

update xtms_task_detail 
set xttd_earliest_start = to_date('12/5/2008 00:00:00','mm/dd/yyyyhh24:mi:ss')
WHERE xttd_earliest_start = to_date('12/5/2008 23:59:00','mm/dd/yyyyhh24:mi:ss')
And xttd_status = 'UNASSIGNED'
--AND XTTD_TASK_TYPE = 'HOT_TRUCK'

rollback




SELECT * FROM XTMS_TASK_DETAIL WHERE 
xttd_earliest_start = to_date('12/5/2008 23:59:00','mm/dd/yyyyhh24:mi:ss')
And xttd_status = 'UNASSIGNED' 
--xttd_earliest_start = to_date('12/5/2008 00:00:00','mm/dd/yyyyhh24:mi:ss')
--and XTTD_TASK_TYPE = 'HOT_TRUCK'


COMMIT
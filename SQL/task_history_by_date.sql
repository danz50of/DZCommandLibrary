select * from xtms_task_history where xtth_status = 'COMPLETE'
and trunc(xtth_status_date) = to_date('2008-12-18','yyyy-mm-dd')
--and xtth_descriptive_text like ('%SA745PU%')
order by xtth_status_date desc




select * from xtms_task_history where xtth_reference LIKE ('C755701%')-- and xtth_status = 'COMPLETE'


select * from xtms_task_history where trunc(xtth_status_date) between to_date('2/18/2010','mm/dd/yyyy') and to_date('2/18/2010','mm/dd/yyyy') 




select * from xdc_trans where xt_body like '%1064610%'
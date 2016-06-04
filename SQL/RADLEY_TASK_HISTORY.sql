select * 
--xtth_task_id, xtth_status, xtth_task_type, xtth_reference, xtth_update_user, xtth_update_stamp 
from xtms_task_history 
where 
--xtth_update_stamp > to_date ('7/1/2014','mm/dd/yyyy')
--and xtth_user_id = 'PICK0507WH'
--order by xtth_update_stamp
--and xtth_status = 'COMPLETE'
--xtth_reference like 'C901633%'
xtth_user_id = 'TAFARIL11US' 
AND XTTH_STATUS_DATE BETWEEN TO_DATE ('9/25/2015','MM/DD/YYYY') AND ('9/26/2015','MM/DD/YYYY')
 
 
 
 
select * from ifsinfo.
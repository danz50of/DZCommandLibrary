delete from xdc.xtms_task_detail where
--select * from xdc.xtms_task_detail where
XTTD_REFERENCE = 'C672869-860849'
--XTTD_UPDATE_STAMP
AND XTTD_TASK_ID > 4733
--ORDER BY XTTD_TASK_ID 

 ROLLBACK;
 
 commit;
 
 
 
 
 
 
 select xttd_task_id, xttd_task_type, xttd_reference, xttd_serial, xttd_bin, xttd_earliest_start, xttd_status, xttd_user_id, xttd_descriptive_text, XTTD_STATUS 
 from xtms_task_detail
 where xttd_task_type = 'UPS' --AND XTTD_REFERENCE > 'C672865-860845'
 order by xttd_reference, xttd_serial
select trunc(xtth_status_date,'mm'), COUNT(xtth_task_id) from xtms_task_history 
where xtth_status = 'COMPLETE' 
AND XTTH_TASK_TYPE IS NOT NULL
group by trunc(xtth_status_date,'mm')



SELECT * FROM XTMS_TASK_HISTORY
WHERE XTTH_STATUS = 'COMPLETE'
AND XTTH_TASK_TYPE IS NOT NULL 
select xtth_task_id, xtth_reference, min(xtth_status_date) as UNASSIGNED_STATUS_DATE, NULL AS ASSIGNED_STATUS, NULL AS COMPLETE_STATUS 
from xtms_task_history
WHERE XTTH_STATUS = 'UNASSIGNED'
group by xtth_task_id, xtth_reference
UNION
SELECT xtth_task_id, XTTH_REFERENCE, NULL, max(XTTH_STATUS_DATE) AS ASSIGNED_STATUS, NULL
FROM XTMS_TASK_HISTORY
WHERE XTTH_STATUS = 'ASSIGNED'
group by xtth_task_id, xtth_reference
UNION
SELECT xtth_task_id, XTTH_REFERENCE, NULL, NULL, max(XTTH_STATUS_DATE) AS COMPLETE_STATUS
FROM XTMS_TASK_HISTORY
WHERE XTTH_STATUS = 'COMPLETE'
group by xtth_task_id, xtth_reference

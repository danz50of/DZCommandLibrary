SELECT LOG_ID, ORDER_NO, HISTORY_TYPE, TIME_STAMP, USERNAME, NEW_ORDER_NO_VALUE, 
NEW_PART_NO_VALUE, OLD_PART_NO_VALUE NEW_QTY_DUE_VALUE, OLD_QTY_DUE_VALUE,
NEW_ORG_QTY_DUE_VALUE, OLD_ORG_QTY_DUE_VALUE
FROM IFSINFO.PRL_SO_HISTORY
WHERE NEW_PART_NO_VALUE = '&PART_NO' OR OLD_PART_NO_VALUE = '&PART_NO'


SELECT BACK.JOB_ID, BACK.ACTION_TYPE_SHORT, BACK.SO_NUM, BACK.USERNAME, 
BACK.EXECUTED, HIST.TIME_STAMP, HIST.HISTORY_TYPE, HIST.USERNAME, 
HIST.NEW_CONTRACT_VALUE, HIST.OLD_CONTRACT_VALUE, HIST.NEW_PART_NO_VALUE, 
HIST.OLD_PART_NO_VALUE, HIST.OLD_DATE_ENTERED_VALUE, 
HIST.NEW_QTY_DUE_VALUE, HIST.OLD_QTY_DUE_VALUE, HIST.NEW_ORG_QTY_DUE_VALUE,
HIST.OLD_ORG_QTY_DUE_VALUE
FROM IFSINFO.PRL_SO_HIST_BACK BACK, IFSINFO.PRL_SO_HISTORY HIST
WHERE  BACK.SO_NUM = HIST.ORDER_NO(+)
AND BACK.SO_NUM = '&SHOP ORDER NO'

SELECT * FROM IFSINFO.PRL_SO_HIST_BACK WHERE SO_NUM = 656485





-- INDIVIDUAL SQL STATEMENTS TO MAKE PRL_SO_HISTORY AND PRL_SO_HIST_BACK

select 
DEF.JOB_ID, SUBSTR(DEF.ARGUMENTS_STRING,1,27) ACTION_TYPE, SUBSTR(DEF.ARGUMENTS_STRING,54,7) SO_NUM, DEF.USERNAME, DEF.EXECUTED,
ADMIN.LOG_ID, ADMIN.TABLE_NAME, ADMIN.TIME_STAMP, KEYS,
SUBSTR(ADMIN.KEYS,10,6) ORDER_NO, ADMIN.HISTORY_TYPE, ADMIN.USERNAME,
(SELECT ATTR.NEW_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORDER_NO') NEW_ORDER_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORDER_NO') OLD_ORDER_NO_VALUE,
(SELECT ATTR.NEW_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'CONTRACT') NEW_CONTRACT_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'CONTRACT') OLD_CONTRACT_VALUE,
(SELECT ATTR.NEW_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'PART_NO') NEW_PART_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'PART_NO') OLD_PART_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'DATE_ENTERED') OLD_DATE_ENTERED_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'REVISED_QTY_DUE') OLD_QTY_DUE_VALUE,
(SELECT ATTR.NEW_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'REVISED_QTY_DUE') NEW_QTY_DUE_VALUE,
(SELECT ATTR.NEW_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORG_QTY_DUE') NEW_ORG_QTY_DUE_VALUE,
(SELECT ATTR.OLD_VALUE FROM HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORG_QTY_DUE') OLD_QTY_DUE_VALUE
from IFSAPP.deferred_job DEF,
ifsapp.history_log_admin ADMIN 
where DEF.procedure_name = 'Op_Plan_API.Transaction'
AND SUBSTR(DEF.ARGUMENTS_STRING,54,7) = SUBSTR(ADMIN.KEYS,10,6)
AND ADMIN.MODULE = 'SHPORD' 
AND ADMIN.TIME_STAMP > TO_DATE('04/07/2009','MM/DD/YYYY')
ORDER BY SUBSTR(ADMIN.KEYS,10,6);


--select DEF.JOB_ID, SUBSTR(DEF.ARGUMENTS_STRING,1,27) ACTION_TYPE, SUBSTR(DEF.ARGUMENTS_STRING,54,7) SO_NUM, DEF.USERNAME, DEF.EXECUTED 
--from deferred_job where DEF.procedure_name = 'Op_Plan_API.Transaction'


select 
DEF.JOB_ID, SUBSTR(DEF.ARGUMENTS_STRING,1,27) ACTION_TYPE, SUBSTR(DEF.ARGUMENTS_STRING,7,8) ACTION_TYPE_SHORT,
SUBSTR(DEF.ARGUMENTS_STRING,54,7) SO_NUM, DEF.USERNAME, DEF.EXECUTED
FROM IFSAPP.deferred_job DEF
WHERE DEF.procedure_name = 'Op_Plan_API.Transaction' --AND JOB_ID = 17719535


SELECT * FROM IFSAPP.DEFERRED_JOB --WHERE JOB_ID = 17719535


SELECT * FROM ifsapp.history_log_admin WHERE TABLE_NAME LIKE 'SHOP%'



SELECT LOG_ID, 
TABLE_NAME,
TIME_STAMP,
KEYS,
ORDER_NO,
HISTORY_TYPE,
USERNAME,
NEW_ORDER_NO_VALUE,
OLD_ORDER_NO_VALUE,
NEW_CONTRACT_VALUE,
OLD_CONTRACT_VALUE,
NEW_PART_NO_VALUE,
OLD_PART_NO_VALUE,
OLD_DATE_ENTERED_VALUE,
OLD_QTY_DUE_VALUE,
NEW_QTY_DUE_VALUE,
NEW_ORG_QTY_DUE_VALUE,
OLD_ORG_QTY_DUE_VALUE
FROM IFSINFO.PRL_SO_HISTORY --WHERE ORDER_NO = '&ORDER_NO'
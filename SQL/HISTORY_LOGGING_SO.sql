select ADMIN.LOG_ID, ADMIN.TABLE_NAME, ADMIN.TIME_STAMP, KEYS,
SUBSTR(ADMIN.KEYS,10,6) ORDER_NO, ADMIN.HISTORY_TYPE, ADMIN.USERNAME,
(SELECT ATTR.NEW_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORDER_NO') NEW_ORDER_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORDER_NO') OLD_ORDER_NO_VALUE,
(SELECT ATTR.NEW_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'CONTRACT') NEW_CONTRACT_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'CONTRACT') OLD_CONTRACT_VALUE,
(SELECT ATTR.NEW_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'PART_NO') NEW_PART_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'PART_NO') OLD_PART_NO_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'DATE_ENTERED') OLD_DATE_ENTERED_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'REVISED_QTY_DUE') OLD_QTY_DUE_VALUE,
(SELECT ATTR.NEW_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'REVISED_QTY_DUE') NEW_QTY_DUE_VALUE,
(SELECT ATTR.NEW_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORG_QTY_DUE') NEW_ORG_QTY_DUE_VALUE,
(SELECT ATTR.OLD_VALUE FROM ifsapp.HISTORY_LOG_ATTRIBUTE ATTR WHERE ATTR.LOG_ID = ADMIN.LOG_ID
AND ATTR.COLUMN_NAME = 'ORG_QTY_DUE') OLD_QTY_DUE_VALUE
from 
ifsapp.history_log_admin ADMIN 
where MODULE = 'INVENT' 
AND TIME_STAMP > TO_DATE('12/1/2010','MM/DD/YYYY')
ORDER BY SUBSTR(ADMIN.KEYS,10,6)


select * from deferred_job where JOB_ID = 17544679




SELECT * FROM ifsapp.history_log_admin WHERE LOG_ID = 1014022

SELECT * FROM IFSAPP.HISTORY_LOG_ATTRIBUTE WHERE LOG_ID = 440908

SELECT * FROM HISTORY_LOG_ATTRIBUTE WHERE LOG_ID = 961726
select * from history_log_admin hl, HISTORY_LOG_ATTRIBUTE B WHERE HL.MODULE = 'SHPORD' AND HL.LOG_ID = B.LOG_ID


select a.log_id, a.module, a.time_stamp, USERNAME,
(select new_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'ACCOUNT_DATE') ACCOUNT_DATE,
(select new_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'EMP_NO') EMP_NO,
(select new_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'REG_STAMP') reg_stamp  
from history_log_admin a where A.MODULE = 'TIMREP' 
AND A.TIME_STAMP BETWEEN TO_DATE('20090101','YYYYMMDD') AND TO_DATE('20090301','YYYYMMDD')
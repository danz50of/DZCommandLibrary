select * from history_log_admin hl, HISTORY_LOG_ATTRIBUTE B WHERE HL.MODULE = 'SHPORD' AND HL.LOG_ID = B.LOG_ID


select a.log_id, a.module, a.time_stamp, USERNAME,
(select new_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'PAY_TERM_ID') NEW_PAY_TERM,
(select old_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'PAY_TERM_ID') OLD_PAY_TERM,
(select new_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'CREDIT_BLOCK') NEW_VALUE_CREADIT_BLOCK,
(select OLD_value from history_log_attribute b where b.log_id = a.log_id and column_name = 'CREDIT_BLOCK') OLD_VALUE_CREADIT_BLOCK
from history_log_admin a where A.MODULE IN ('PAYLED','INVOIC')
AND A.TIME_STAMP BETWEEN TO_DATE('20160901','YYYYMMDD') AND TO_DATE('20160928','YYYYMMDD')

SELECT * FROM HISTORY_LOG_ATTRIBUTE WHERE LOG_ID = 102711530

select * from history_log_admin where time_stamp between to_date('20160927','yyyymmdd') and sysdate and MODULE IN ('PAYLED','INVOIC')
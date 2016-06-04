select * from ifsapp.history_log where trunc(time_stamp,'dd') >= to_date('2011/09/01','yyyy/mm/dd') 
and KEYS LIKE '%046-0067%'


SELECT * FROM IFSAPP.HISTORY_LOG
Where trunc(time_stamp,'dd') >= to_date('2012/10/03','yyyy/mm/dd')
AND MODULE = 'MFGSTD'

SELECT * FROM IFSAPP.HISTORY_LOG_ATTRIBUTE WHERE LOG_ID = 21550201




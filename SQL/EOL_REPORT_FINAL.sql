SELECT SITE
, PART_NO
, (ON_HAND_QTY + EOL_PLANNED + EOL_WIP - OPEN_CUSTOMER_DEMAND) NET_AVAILABLE
, PHASE_OUT_DATE
, ON_HAND_QTY
, EOL_PLANNED
, EOL_WIP
, OPEN_CUSTOMER_DEMAND
, AVG_3_MONTHS AVG_3_MONTH_USAGE
FROM IFSINFO.PRL_EOL_SUMMARY_IAL WHERE
SITE = '&SITE' 
AND PART_NO = 'PLCT'

SELECT * FROM IFSINFO.PRL_EOL_SUMMARY_IAL WHERE PART_NO = 'PLCT' AND SITE = 'MP'
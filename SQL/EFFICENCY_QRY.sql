SELECT OP_ID, OP_INFO_CODE, EMP_NO, PART_NO, ACCOUNT_DATE, MCH_CODE, ORDER_NO, OP_NO, WORK_HOURS,
(SELECT SUM(OP_QTY) FROM OP_QUANTITY_TAB B WHERE A.OP_ID = B.OP_ID AND A.EMP_NO = B.EMP_NO AND UPPER(A.OP_INFO_CODE) = 'RUN') AS QTY_COMPLETED,
(SELECT SUM(OP_QTY) FROM OP_QUANTITY_TAB B WHERE A.OP_ID = B.OP_ID AND A.EMP_NO = B.EMP_NO AND UPPER(A.OP_INFO_CODE) = 'RUN') / WORK_HOURS AS UNITS_PER_HOUR,
--(SELECT LABOR_RUN_FACTOR FROM ROUTING_OPERATION C WHERE C.PART_NO = A.PART_NO AND CONTRACT = 'MP' AND A.OP_NO = C.OPERATION_NO AND PHASE_IN_DATE <= TRUNC(ACCOUNT_DATE,'DD') AND NVL(PHASE_OUT_DATE,TRUNC(SYSDATE, 'DD')) >= TRUNC(ACCOUNT_DATE,'DD') AND UPPER(A.OP_INFO_CODE) = 'RUN') AS STANDARD_RUN,
(SELECT LABOR_SETUP_TIME FROM ROUTING_OPERATION C WHERE C.PART_NO = A.PART_NO AND CONTRACT = 'MP' AND A.OP_NO = C.OPERATION_NO AND PHASE_IN_DATE <= TRUNC(ACCOUNT_DATE,'DD') AND NVL(PHASE_OUT_DATE,TRUNC(SYSDATE, 'DD')) >= TRUNC(ACCOUNT_DATE,'DD') AND UPPER(A.OP_INFO_CODE) = 'SETUP') AS STANDARD_SETUP,
OP_STATUS
FROM OP_RESULT_SUMMARY A
--WHERE A.ORDER_NO = '430154';
--WHERE A.MCH_CODE = 'MW1'
--AND ACCOUNT_DATE > TO_DATE('05/01/2006','MM/DD/YYYY')
WHERE ACCOUNT_DATE = TO_DATE('07/09/2001','MM/DD/YYYY') 
AND PART_NO = '128-0023'
--AND UPPER(OP_STATUS) != 'CLOSED';



SELECT A.OP_ID, A.OP_INFO_CODE, A.EMP_NO, A.PART_NO, trunc(A.ACCOUNT_DATE,'DD') AS ACCOUNT_DATE, A.MCH_CODE, A.ORDER_NO, A.OP_NO, A.WORK_HOURS, A.QTY_COMPLETED,
 A.UNITS_PER_HOUR, A.STANDARD_RUN, A.STANDARD_SETUP, ROUND((A.UNITS_PER_HOUR / A.STANDARD_RUN) * 100) AS PERCENT_RUN_VARIANCE,
 ROUND((A.WORK_HOURS / A.STANDARD_SETUP) * 100) AS PERCENT_SETUP_VARIANCE, 
 OP_STATUS 
FROM IFSINFO.PRL_LABOR_RPT_IAL A --WHERE ACCOUNT_DATE BETWEEN TO_DATE('07/09/2001','MM/DD/YYYY')
--AND TO_DATE('07/15/2001','MM/DD/YYYY')








(SELECT LABOR_RUN_FACTOR FROM ROUTING_OPERATION C WHERE C.PART_NO = A.PART_NO AND CONTRACT = 'MP' AND PHASE_IN_DATE <= TRUNC(SYSDATE,'DD') AND NVL(PHASE_OUT_DATE,TRUNC(SYSDATE, 'DD')) >= TRUNC(SYSDATE,'DD') AND UPPER(A.OP_INFO_CODE) = 'RUN' GROUP BY LABOR_RUN_FACTOR) AS LABOR_RUN_FACTOR,
OP_STATUS

SELECT * FROM ROUTING_OPERATION

SELECT * FROM ROUTING_OPERATION C WHERE C.PART_NO = '128-0023' AND CONTRACT = 'MP' AND C.OPERATION_NO = '30'
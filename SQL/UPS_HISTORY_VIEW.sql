SELECT ORDER_NUM, PACKAGE_CHARGE, TO_DATE(SUBSTR(PICKUP_DATE,1,8), 'YYYY/MM/DD') AS PICKUP_DATE
FROM IFSINFO.UPS_EXPORT_HISTORY_TAB
WHERE TO_DATE(SUBSTR(PICKUP_DATE,1,8), 'YYYY/MM/DD') > TO_DATE('20061121','YYYYMMDD');


SELECT * FROM IFSINFO.UPS_EXPORT_TRACKING_TAB;
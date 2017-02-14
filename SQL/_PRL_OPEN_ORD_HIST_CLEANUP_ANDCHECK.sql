/*  Script to clean up PRL_OPEN_ORDERS_HIST when the table gets too large.  That IAL
    will append each daily snapshot.  
    
    MUST BE RAN AS IFSINFO
    
    DZ:  2/6/2017       -- Created   */

DELETE FROM IFSINFO.PRL_OPEN_ORDERS_HIST WHERE OBJDATE = TO_DATE('2/3/2017','MM/DD/YYYY')
--besure to run commit when completed
COMMIT;

--CODE TO LOOK AT DAILY TOTALS AND MATCH TO DAILY SHIPMENTS AS OPEN ORDER AMOUNT

SELECT OBJDATE, SUM(OPEN_$) OPEN_$ FROM IFSINFO.PRL_OPEN_ORDERS_HIST
GROUP BY OBJDATE
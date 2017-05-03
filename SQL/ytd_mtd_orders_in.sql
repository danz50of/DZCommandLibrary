--Updated   5/2/2017 to change salesperson to commision receiver.  

SELECT A.CATALOG_NO, A.QTY_INVOICED, A.CUSTOMER_NO, A.CUSTOMER_NAME, A.ORDER_NO, A.LINE_NO, A.SALE_UNIT_PRICE, A.QTY_ON_ORDER, A.QTY_RETURNED, A.REVISED_QTY_DUE, 
A.BUY_QTY_DUE, A.OBJVERSION, A.LINE_STATE, A.REAL_SHIP_DATE, A.PLANNED_SHIP_DATE, A.PLANNED_DUE_DATE, A.PROMISED_DELIVERY_DATE, A.DATE_ENTERED, 
A.AUTHORIZE_CODE, A.ORDER_ID, A.CONTRACT, B.STATE, (a.buy_qty_due*sale_unit_price) AS BUY_QTY_LINE_TOTAL, (a.revised_qty_due*sale_unit_price) AS REV_LINE_TOTAL, 
B.SALESMAN_CODE, c.commission_receiver COMMISSION_RECEIVER
FROM IFSAPP.CUSTOMER_ORDER_JOIN A, IFSAPP.CUSTOMER_ORDER B, ifsapp.cust_def_com_receiver c
WHERE A.ORDER_NO = B.ORDER_NO and B.CUSTOMER_NO = c.customer_no (+) 
and ((trunc(a.date_entered,'yy')>=trunc(sysdate,'yy')) AND (trunc(a.date_entered,'dd')<=trunc(sysdate,'dd')) AND (A.CONTRACT='MP') OR (trunc(a.date_entered,'yy')>=trunc(add_months(sysdate,-12),'yy')) AND (trunc(a.date_entered,'dd')<=trunc(add_months(sysdate,-12),'dd')) AND (A.CONTRACT='MP'))
AND upper(CATALOG_TYPE) IN ('INVENTORY PART','PACKAGE PART')

--Commission receiver info from IFS

--select * from ifsapp.CUST_DEF_COM_RECEIVER
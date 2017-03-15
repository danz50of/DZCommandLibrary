SELECT A.CATALOG_NO, A.QTY_INVOICED, A.CUSTOMER_NO, A.CUSTOMER_NAME, A.ORDER_NO, A.LINE_NO, A.SALE_UNIT_PRICE, A.QTY_ON_ORDER, A.QTY_RETURNED, A.REVISED_QTY_DUE, A.BUY_QTY_DUE, A.OBJVERSION, A.LINE_STATE, A.REAL_SHIP_DATE, A.PLANNED_SHIP_DATE, A.PLANNED_DUE_DATE, A.PROMISED_DELIVERY_DATE, A.DATE_ENTERED, A.AUTHORIZE_CODE, A.ORDER_ID, A.CONTRACT, B.STATE, (a.buy_qty_due*sale_unit_price) AS BUY_QTY_LINE_TOTAL, (a.revised_qty_due*sale_unit_price) AS REV_LINE_TOTAL, A.SALESMAN_CODE
FROM IFSAPP.CUSTOMER_ORDER_JOIN A, IFSAPP.CUSTOMER_ORDER B
WHERE A.ORDER_NO = B.ORDER_NO AND ((trunc(a.date_entered,'YY')>=(trunc(sysdate-365,'YY')))
AND (A.CONTRACT='MP'))
AND upper(CATALOG_TYPE) IN ('INVENTORY PART','PACKAGE PART')




-- AND (trunc(a.date_entered,'dd')<=trunc(sysdate,'dd')) AND (A.CONTRACT='MP') OR (trunc(a.date_entered,'mm')>=trunc(add_months(sysdate,-12),'mm')) AND (trunc(a.date_entered,'dd')<=trunc(add_months(sysdate,-12),'dd'))
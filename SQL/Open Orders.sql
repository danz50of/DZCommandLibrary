SELECT A.CATALOG_NO, A.QTY_INVOICED, A.CUSTOMER_NO, A.CUSTOMER_NAME, A.ORDER_NO, A.LINE_NO, A.SALE_UNIT_PRICE, A.QTY_ON_ORDER, A.QTY_RETURNED, A.REVISED_QTY_DUE, 
A.BUY_QTY_DUE, A.OBJVERSION, A.LINE_STATE, A.REAL_SHIP_DATE, A.PLANNED_SHIP_DATE, A.PLANNED_DUE_DATE, A.PROMISED_DELIVERY_DATE, A.DATE_ENTERED, 
A.AUTHORIZE_CODE, A.ORDER_ID, A.CONTRACT, B.STATE, (a.buy_qty_due*sale_unit_price) AS BUY_QTY_LINE_TOTAL, (a.revised_qty_due*sale_unit_price) AS REV_LINE_TOTAL, 
B.SALESMAN_CODE,
a.real_ship_date date_shipped
FROM IFSAPP.CUSTOMER_ORDER_JOIN A, IFSAPP.CUSTOMER_ORDER B
WHERE A.ORDER_NO = B.ORDER_NO 
and a.line_state in ('Released','Reserved','Partially Delivered','Picked','Delivered')
and a.customer_no = '907148'

--Need to clean up due to package parts, doubling those items.  Check Volta as example.
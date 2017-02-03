select * from ifsinfo.past_due_ord_all 

select * from ifsinfo.past_due_ord_crblk

TRUNC (SYSDATE, 'DD') OBJDATE

--WAITING FOR JOE TO UPDATE PAST DUE AND PAST DUE CRBLK WITH LINE_NO AND REL_NO

   select SITE,   COORD,    ORDER_NO, LINE_NO, REL_NO,   SALES_PART, DUE_DATE, CUR_MTH_OPEN, PAST_DUE, FUTURE_MTH_OPEN, DUE_MTH, PLANNED_DELIV, PROMISED_DELIV, HDR_DATE, DATE_ENTERED, LINE_STATUS, ORDER_STATUS, SALE_UNIT_PRICE, CUSTOMER_NO,
   CUSTOMER_NAME,
   QTY_ASSIGNED,
   QTY_SHORT,
   BUY_QTY_DUE,
   QTY_SHIPPED,
   BASE_SALE_UNIT_PRICE,
   OPEN_BUY_QTY_DUE,
   OPEN_BUY_LESS_SHIPPED,
   OPEN_$,
   QTY_OPEN,
   null start_date,
   TRUNC (SYSDATE, 'DD') OBJDATE
   from ifsinfo.past_due_ord_all
   union
   select SITE,  COORD,   ORDER_NO, LINE_NO, REL_NO,   SALES_PART, DUE_DATE, CUR_MTH_OPEN, PAST_DUE,  FUTURE_MTH_OPEN, DUE_MTH,  PLANNED_DELIV, PROMISED_DELIV,  HDR_DATE, DATE_ENTERED,    LINE_STATUS,    ORDER_STATUS,    SALE_UNIT_PRICE,    CUSTOMER_NO,    CUSTOMER_NAME, 
      QTY_ASSIGNED, null qty_short, null buy_qty_due, null qty_shipped, null base_sale_unit_price, null open_buy_qty_due, null open_buy_less_shipped, open_$, qty_open,
   START_DATE,
   TRUNC (SYSDATE, 'DD') OBJDATE
   from ifsinfo.past_due_ord_crblk

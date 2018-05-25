select customer_no, customer_name, month_shipped, count(order_no) Num_Orders, (insert sub-selects to only return values > 0
select ORDER_NO, count(LINE_NO) Num_Of_Lines, count(REL_NO) Rel_num_total, CUSTOMER_NO, CUSTOMER_NAME, 
sum(QTY_SHIPPED) Total_Units_Shipped, 
--DATE_ENTERED, PLANNED_DELIVERY_DATE, 
--PROMISED_DELIVERY_DATE, 
trunc(REAL_SHIP_DATE,'mm') Month_SHIPPED, 
sum(PROMISED_DELIVERY_DATE - REAL_SHIP_DATE) AS OTD_PROMISED,
sum(PLANNED_DELIVERY_DATE - REAL_SHIP_DATE) AS OTD_PLANNED
from ifsapp.customer_order_join
where trunc(date_entered,'yyyy') >= (trunc(sysdate,'yyyy')-365)
AND state = 'Invoiced/Closed'
group by order_no, customer_no, customer_name, trunc(real_ship_date,'mm')


select * from ifsapp.customer_order_join
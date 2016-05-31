select customer_no, sum((qty_invoiced * part_price) - additional_discount), to_char(date_entered,'yyyymm')
from ifsapp.customer_order_join
where customer_no = '798849' and objstate = 'Invoiced'
group by customer_no, to_char(date_entered,'yyyymm')
; 

select count (*) from IFSAPP.CUSTOMER_ORDER_INV_HEAD;

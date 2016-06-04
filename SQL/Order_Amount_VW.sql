create OR REPLACE view PRL_ORDER_TOTAL AS
select customer_no, ORDER_NO, LINE_NO, sum((qty_invoiced * part_price) - additional_discount) AS ORDER_TOTAL, date_entered
from ifsapp.customer_order_join
group by customer_no, ORDER_NO, LINE_NO, DATE_ENTERED
;
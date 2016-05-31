select A.ORDER_NO, A.CUSTOMER_NO, a.CUSTOMER_PO_NO , B.CHARGE_TYPE, B.CHARGE_AMOUNT,  C.QTY_INVOICED, C.PART_PRICE, c.ADDITIONAL_DISCOUNT
from customer_order a join customer_order_charge b on 
a.order_no = b.order_no join customer_order_line c on a.order_no = c.order_no
JOIN CUSTOMER_ORDER_HISTORY D ON A.ORDER_NO = D.ORDER_NO
where a.DATE_ENTERED between TO_DATE ('01012005', 'MMDDYYYY') and to_date ('12/31/2005')
--and b.charge_type like 'Z%'
and b.charge_type IN (SELECT CHARGE_TYPE FROM SALES_CHARGE_TYPE WHERE CONTRACT = 'MP')
AND D.MESSAGE_TEXT LIKE 'UPS:%'




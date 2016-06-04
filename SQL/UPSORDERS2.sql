select A.ORDER_NO, A.CUSTOMER_NO, B.CHARGE_TYPE, sum (B.CHARGE_AMOUNT) as Charge_Amount
from customer_order a left join customer_order_charge b on 
a.order_no = b.order_no
where a.DATE_ENTERED >= TO_DATE ('01012005', 'MMDDYYYY')
and b.charge_type IN (SELECT h.CHARGE_TYPE FROM SALES_CHARGE_TYPE h WHERE h.CONTRACT = 'MP')
AND A.OBJSTATE = 'Invoiced'
group by a.order_no, a.customer_no, B.CHARGE_TYPE

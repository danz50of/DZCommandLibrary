--SELECT * 
--select A.ORDER_NO, B.QTY_INVOICED, B.PART_PRICE, B.DISCOUNT, ((B.PART_PRICE * B.QTY_INVOICED) - ((B.DISCOUNT / 100) * (B.PART_PRICE * B.QTY_INVOICED))) AS LINE_TOTAL
select a.customer_no, A.ORDER_NO, a.date_entered, to_char(a.date_entered,'mm') Period,
to_char(a.date_entered,'yyyy') Fiscal_Year
, SUM ((B.SALE_UNIT_PRICE * B.QTY_INVOICED) - ((B.DISCOUNT / 100) * (B.SALE_UNIT_PRICE * B.QTY_INVOICED))) AS LINE_TOTAL 
from customer_order a join customer_order_line b on 
a.order_no = b.order_no
where a.DATE_ENTERED >= TO_DATE ('01012002', 'MMDDYYYY')
and A.STATE = 'Invoiced/Closed'
and b.state = 'Invoiced/Closed'
--AND B.DISCOUNT > 0
group by a.customer_no, a.order_no, a.date_entered
order by a.date_entered
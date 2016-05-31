--SELECT * 
--select A.ORDER_NO, B.QTY_INVOICED, B.PART_PRICE, B.DISCOUNT, ((B.PART_PRICE * B.QTY_INVOICED) - ((B.DISCOUNT / 100) * (B.PART_PRICE * B.QTY_INVOICED))) AS LINE_TOTAL
select a.customer_no, A.ORDER_NO, a.date_entered, CASE
WHEN a.date_entered >= TO_DATE ('01012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('01312002', 'MMDDYYYY') THEN 'JAN_02'
WHEN a.date_entered >= TO_DATE ('02012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('02282002', 'MMDDYYYY') THEN 'FEB_02'
WHEN a.date_entered >= TO_DATE ('03012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('03312002', 'MMDDYYYY') THEN 'MAR_02'
WHEN a.date_entered >= TO_DATE ('04012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('04302002', 'MMDDYYYY') THEN 'APR_02'
WHEN a.date_entered >= TO_DATE ('05012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('05312002', 'MMDDYYYY') THEN 'MAY_02'
WHEN a.date_entered >= TO_DATE ('06012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('06302002', 'MMDDYYYY') THEN 'JUN_02'
WHEN a.date_entered >= TO_DATE ('07012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('07312002', 'MMDDYYYY') THEN 'JUL_02'
WHEN a.date_entered >= TO_DATE ('08012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('08312002', 'MMDDYYYY') THEN 'AUG_02'
WHEN a.date_entered >= TO_DATE ('09012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('09302002', 'MMDDYYYY') THEN 'SEP_02'
WHEN a.date_entered >= TO_DATE ('10012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('10312002', 'MMDDYYYY') THEN 'OCT_02'
WHEN a.date_entered >= TO_DATE ('11012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('11302002', 'MMDDYYYY') THEN 'NOV_02'
WHEN a.date_entered >= TO_DATE ('12012002', 'MMDDYYYY') and a.date_entered <= TO_DATE ('12312002', 'MMDDYYYY') THEN 'DEC_02'
-- 2003 
WHEN a.date_entered >= TO_DATE ('01012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('01312003', 'MMDDYYYY') THEN 'JAN_03'
WHEN a.date_entered >= TO_DATE ('02012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('02282003', 'MMDDYYYY') THEN 'FEB_03'
WHEN a.date_entered >= TO_DATE ('03012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('03312003', 'MMDDYYYY') THEN 'MAR_03'
WHEN a.date_entered >= TO_DATE ('04012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('04302003', 'MMDDYYYY') THEN 'APR_03'
WHEN a.date_entered >= TO_DATE ('05012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('05312003', 'MMDDYYYY') THEN 'MAY_03'
WHEN a.date_entered >= TO_DATE ('06012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('06302003', 'MMDDYYYY') THEN 'JUN_03'
WHEN a.date_entered >= TO_DATE ('07012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('07312003', 'MMDDYYYY') THEN 'JUL_03'
WHEN a.date_entered >= TO_DATE ('08012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('08312003', 'MMDDYYYY') THEN 'AUG_03'
WHEN a.date_entered >= TO_DATE ('09012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('09302003', 'MMDDYYYY') THEN 'SEP_03'
WHEN a.date_entered >= TO_DATE ('10012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('10312003', 'MMDDYYYY') THEN 'OCT_03'
WHEN a.date_entered >= TO_DATE ('11012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('11302003', 'MMDDYYYY') THEN 'NOV_03'
WHEN a.date_entered >= TO_DATE ('12012003', 'MMDDYYYY') and a.date_entered <= TO_DATE ('12312003', 'MMDDYYYY') THEN 'DEC_03'
-- 2004 
WHEN a.date_entered >= TO_DATE ('01012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('01312004', 'MMDDYYYY') THEN 'JAN_04'
WHEN a.date_entered >= TO_DATE ('02012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('02292004', 'MMDDYYYY') THEN 'FEB_04'
WHEN a.date_entered >= TO_DATE ('03012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('03312004', 'MMDDYYYY') THEN 'MAR_04'
WHEN a.date_entered >= TO_DATE ('04012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('04302004', 'MMDDYYYY') THEN 'APR_04'
WHEN a.date_entered >= TO_DATE ('05012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('05312004', 'MMDDYYYY') THEN 'MAY_04'
WHEN a.date_entered >= TO_DATE ('06012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('06302004', 'MMDDYYYY') THEN 'JUN_04'
WHEN a.date_entered >= TO_DATE ('07012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('07312004', 'MMDDYYYY') THEN 'JUL_04'
WHEN a.date_entered >= TO_DATE ('08012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('08312004', 'MMDDYYYY') THEN 'AUG_04'
WHEN a.date_entered >= TO_DATE ('09012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('09302004', 'MMDDYYYY') THEN 'SEP_04'
WHEN a.date_entered >= TO_DATE ('10012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('10312004', 'MMDDYYYY') THEN 'OCT_04'
WHEN a.date_entered >= TO_DATE ('11012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('11302004', 'MMDDYYYY') THEN 'NOV_04'
WHEN a.date_entered >= TO_DATE ('12012004', 'MMDDYYYY') and a.date_entered <= TO_DATE ('12312004', 'MMDDYYYY') THEN 'DEC_04'
--2005 
WHEN a.date_entered >= TO_DATE ('01012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('01312005', 'MMDDYYYY') THEN 'JAN_05'
WHEN a.date_entered >= TO_DATE ('02012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('02282005', 'MMDDYYYY') THEN 'FEB_05'
WHEN a.date_entered >= TO_DATE ('03012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('03312005', 'MMDDYYYY') THEN 'MAR_05'
WHEN a.date_entered >= TO_DATE ('04012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('04302005', 'MMDDYYYY') THEN 'APR_05'
WHEN a.date_entered >= TO_DATE ('05012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('05312005', 'MMDDYYYY') THEN 'MAY_05'
WHEN a.date_entered >= TO_DATE ('06012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('06302005', 'MMDDYYYY') THEN 'JUN_05'
WHEN a.date_entered >= TO_DATE ('07012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('07312005', 'MMDDYYYY') THEN 'JUL_05'
WHEN a.date_entered >= TO_DATE ('08012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('08312005', 'MMDDYYYY') THEN 'AUG_05'
WHEN a.date_entered >= TO_DATE ('09012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('09302005', 'MMDDYYYY') THEN 'SEP_05'
WHEN a.date_entered >= TO_DATE ('10012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('10312005', 'MMDDYYYY') THEN 'OCT_05'
WHEN a.date_entered >= TO_DATE ('11012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('11302005', 'MMDDYYYY') THEN 'NOV_05'
WHEN a.date_entered >= TO_DATE ('12012005', 'MMDDYYYY') and a.date_entered <= TO_DATE ('12312005', 'MMDDYYYY') THEN 'DEC_05'
ELSE 'INVALID'
END "PERIOD"
, SUM ((B.SALE_UNIT_PRICE * B.QTY_INVOICED) - ((B.DISCOUNT / 100) * (B.SALE_UNIT_PRICE * B.QTY_INVOICED))) AS LINE_TOTAL 
from customer_order a join customer_order_line b on 
a.order_no = b.order_no
where a.DATE_ENTERED >= TO_DATE ('01012002', 'MMDDYYYY')
and A.STATE = 'Invoiced/Closed'
and b.state = 'Invoiced/Closed'
--AND B.DISCOUNT > 0
group by a.customer_no, a.order_no, a.date_entered
order by a.date_entered
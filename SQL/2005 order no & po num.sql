select A.ORDER_NO, a.CUSTOMER_PO_NO
from customer_order a  
where a.DATE_ENTERED between TO_DATE ('01012005', 'MMDDYYYY') and to_date ('12/31/2005', 'MM/DD/YYYY');
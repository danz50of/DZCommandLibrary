select order_no, part_no, line_no, rel_no, REAL_SHIP_DATE, catalog_no, 
buy_qty_due, qty_assigned, QTY_PICKED, QTY_INVOICED, QTY_SHIPPED
from customer_order_line where ((BUY_QTY_DUE < QTY_SHIPPED
AND QTY_SHIPPED <> 0) OR (BUY_QTY_DUE < QTY_PICKED AND QTY_PICKED <>0)
or (BUY_QTY_DUE < QTY_ASSIGNED AND QTY_ASSIGNED <> 0)) 
AND REAL_SHIP_DATE > TO_DATE('8/31/2008','MM/DD/YYYY')


select * 
from customer_order_line where order_no = 'A346677'
select vendor_no, po.order_no, po.line_no, po.release_no, po.part_no, 
PO.buy_qty_due, PO.original_qty, PO.planned_receipt_date, po.objstate, hist.dated, hist.quantity
from ifsapp.purchase_order_line_part po, ifsapp.inventory_transaction_hist2 hist
--where po.order_no = 35803
where vendor_no = '188100'
and hist.transaction = 'ARRIVAL'
and hist.dated > to_date('1/1/2008','mm/dd/yyyy')
and po.order_no = '36500'
--and po.line_no = 1 and po.release_no = 1
and po.order_no = hist.order_no
and po.line_no = hist.release_no
and po.RELEASE_NO = hist.sequence_no
order by to_number(line_no)




select * from ifsapp.inventory_transaction_hist2 where order_no = '31870' and transaction = 'ARRIVAL'


select * from ifsapp.purchase_order_line_part where order_no = 36500
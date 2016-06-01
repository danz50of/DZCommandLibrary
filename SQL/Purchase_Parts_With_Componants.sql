--select order_no, component_part, part_no 
select *
from purchase_order_line_comp a join purchase_order b on a.order_no = b.order_no
join purchase_order_line_part c on a.order_no = c.order_no and a.line_no = c.line_no
where b.vendor_no = '045400' and part_no = upper('095-ksa740p-b')
order by date_entered desc
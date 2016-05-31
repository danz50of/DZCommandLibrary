select ip.part_no, ip.description, so.order_no, so.state, so.date_entered, so.need_date, so.priority_category, so.process_type
from shop_ord so, inventory_part ip
where so.contract = 'MP'
and (so.state in ('Released','Started'))
and so.process_type = 'SSC'
--and (so.need_date >= TO_DATE ( '12/15/2010', 'MM/DD/YYYY')
--and  so.need_date <= TO_DATE ( '12/16/2010', 'MM/DD/YYYY'))
and ip.part_no = so.part_no
and ip.contract = 'MP'
--order by ip.part_no, so.order_no





select somat.order_no, somat.line_item_no, somat.part_no, somat.qty_required, somat.qty_issued, somat.qty_required - somat.qty_issued qty_remain,
ROUND((SELECT SUM(qty_onhand) - SUM(qty_reserved)
          FROM inventory_part_in_stock invstck
         WHERE invstck.part_no = somat.part_no
             AND invstck.contract = somat.contract
             AND invstck.warehouse = 'AI'
             AND invstck.availability_control_id IS NULL
             AND invstck.location_no like 'STG%'), 4) STG_QTY_AVAIL,
ROUND((SELECT SUM(qty_onhand) - SUM(qty_reserved)
          FROM inventory_part_in_stock invstck
         WHERE invstck.part_no = somat.part_no
             AND invstck.contract = somat.contract
             AND invstck.warehouse = 'AI'
             AND invstck.availability_control_id IS NULL
             AND invstck.location_no not like 'STG%'),4) NONSTG_AVAIL
from shop_material_alloc somat
where somat.order_no in ('774595')--,'775478','775748','775495','775496','776120','775360','775302','775315','775319','775528')
--124-0841;200-0552;124-8789;1184-701;9GN-71GN04
and somat.contract = 'MP'
and somat.qty_required > 0
order by somat.order_no, somat.line_item_no
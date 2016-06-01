select * from shop_material_alloc where order_no = '584904'

select * from shop_ord



select so.order_no, so.close_date, so.part_no, so.revised_qty_due, 
somat.part_no, somat.component_scrap
from shop_ord so, shop_material_alloc somat 
where so.order_no = somat.order_no
and somat.component_scrap > 0
order by so.part_no, somat.part_no
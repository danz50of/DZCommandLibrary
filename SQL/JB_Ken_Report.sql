select
  a.catalog_no,
  c.catalog_desc,
  ifsapp.level_1_part_api.get_demand_timefence('MP', A.CATALOG_NO),
  b.safety_stock,
  sum(a.buy_qty_due),
  count(a.line_no)
from
  ifsapp.customer_order_join a,
  ifsapp.inventory_part_planning b,
  ifsapp.sales_part c
--  ifsapp.level_1_part d
where
  a.contract = 'MP' and b.contract = 'MP' and c.contract = 'MP' and a.catalog_no = b.part_no(+) and a.catalog_no = c.catalog_no
  and a.date_entered between to_date ('&From_Date','MM/DD/YYYY') and to_date  ('&To_Date','MM/DD/YYYY') and (upper (a.Line_State) <> upper ('Cancelled'))
group by
  a.catalog_no,
  c.catalog_desc,
--  d.part_no,
  b.safety_stock
order by
  sum(a.buy_qty_due) desc
  
  
  
  
  
  
  
  select * from level_1_part
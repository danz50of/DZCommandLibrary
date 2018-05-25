select a.CONTRACT, a.PART_NO, a.CREATE_DATE, a.LAST_ACTIVITY_DATE, a.ESTIMATED_MATERIAL_COST,
round(b.inventory_value,2) Inventory_value, c.comparison_value
from 
ifsapp.inventory_part a, inventory_part_unit_cost_sum b, INVENTORY_VALUE_COMPARATOR c
where a.part_no = b.part_no and a.contract = b.contract
and a.part_no = c.part_no and a.contract = c.contract and c.comparator_type_id = 'ESTIMATED COST'
and a.accounting_group like ('FGCUS')
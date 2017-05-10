select A.PART_NO,
A.CREATE_DATE,
A.ESTIMATED_MATERIAL_COST,
B.TOTAL_ACCUM_COST STD_PART_COST_SET1,
B.EFFECTIVE_DATE LAST_COST_ROLL,
C.COMPARISON_VALUE ROUGH_ESTIMATE_COST
 from
ifsapp.inventory_part a,
ifsapp.part_cost b,
ifsapp.inventory_value_comparator c
where A.ACCOUNTING_GROUP = 'FGCUS'
and a.part_no = b.part_no
and b.cost_set = '1'
and a.part_no = c.part_no
and c.comparator_type_id = 'ESTIMATED COST'


select * from ifsapp.INVENTORY_VALUE_COMPARATOR


select * from ifsapp.WORK_ORDER2   -- work order cost tables
where 1 = 0

select * from ifsapp.ACTIVE_SEPARATE_OVERVIEW   
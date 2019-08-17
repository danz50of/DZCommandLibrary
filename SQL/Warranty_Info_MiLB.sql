--Dan Z    1/18/2019
--This query shows what warranty ID's have been assigned to the parts under MiLB setup.

select * from CUST_WARRANTY_TYPE_PUB

select part_no, cust_warranty_id, catalog_group, warranty_Type_id, b.note_text
from sales_part a, cust_warranty_type_pub b where catalog_group = 'MILB'
and a.cust_warranty_id = b.warranty_id
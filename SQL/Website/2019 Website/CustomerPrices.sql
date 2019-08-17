Select
a.customer_no,
a.sales_price_group_id,
IFSAPP.SALES_PRICE_GROUP_API.GET_DESCRIPTION(a.sales_price_group_id) as Group_Description,
IFSAPP.SALES_PART_API.get_catalog_desc('MP', c.catalog_no, 'en') as Catalog_Description,
a.price_list_no, 
c.catalog_no,
--c.min_quantity,
--c.valid_from_date,
--c.base_price,
c.sales_price,
d.CERTIFICATE_FOR_ORIGIN,
d.U_P_C_CODE,
d.SHIP_WEIGHT,
d.SHIPPING_DIMENSIONS,
d.PRODUCT_COLOR
from
customer_pricelist a,
sales_price_list_part c,
IFSINFO.CUSTOMER_PRICE_LIST_NEW2_IAL d
where
a.customer_no in ('034950')--in ('422660', '422661','827730','827731','836540','836541','810200','100149') 
and
a.price_list_no = c.price_list_no
and c.catalog_no = d.SALES_PART_NO(+)
and a.sales_price_group_id <> 'PRO'
order by a.SALES_PRICE_GROUP_ID, c.CATALOG_NO
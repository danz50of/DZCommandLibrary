select sales_price_group_id, sales_part_no, sales_part_status, inv_part_status, price_list, price, ifsapp.sales_part_api.get_catalog_desc('MP', sales_part_no, 'en') as Description 
from(
select
sales_price_group_id,
sales_part_no,
sales_part_status,
inv_part_status,
concat(sales_Price_group_id, 'DEAL') as price_list,
dealer_2019 as price
from
ifsinfo.customer_price_list_new
union
select
sales_price_group_id,
sales_part_no,
sales_part_status,
inv_part_status,
concat(sales_Price_group_id, 'SPEC') as price_list,
special_2019 as price
from
ifsinfo.customer_price_list_new
union
select
sales_price_group_id,
sales_part_no,
sales_part_status,
inv_part_status,
concat(sales_Price_group_id, 'PART') as price_list,
partner_2019 as price
from
ifsinfo.customer_price_list_new
union
select
sales_price_group_id,
sales_part_no,
sales_part_status,
inv_part_status,
concat(sales_Price_group_id, 'DIST') as price_list,
distributor_2019 as price
from
ifsinfo.customer_price_list_new)
where sales_PRICE_group_id in ('ADS','AET','ACORE','AKIOSK','DS','ET','CORE','HOSP','KIOSK','E-TAIL','RETAIL')
AND PRICE > 0
order by
sales_price_group_id, sales_part_no
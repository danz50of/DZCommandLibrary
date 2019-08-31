/****************************************************************************
 *                                                                          *
 * SQL File: CustomerPrices_Therese.sql                                     *
 * Date:     8/31/2019                                                      *
 *                                                                          *
 ****************************************************************************
 ****************************************************************************
 *                                                                          *
 * Note:  This file will extract all IT Disty account prices from their     *
 *        account assigned pricing.  This was created to maintain the IT    *
 *        disty accounts during the 2019 pricing conversion.                *
 *                                                                          *
 ***************************************************************************/
Select
a.customer_no,
IFSAPP.CUSTOMER_INFO_API.GET_NAME(a.customer_no) Account_Name,
a.sales_price_group_id,
IFSAPP.SALES_PRICE_GROUP_API.GET_DESCRIPTION(a.sales_price_group_id) as Group_Description,
case sales_price_group_id
    when 'ACORE' then 'Mounts'
    when 'CORE' then 'Mounts'
    when 'KIOSK' THEN 'Kiosks'
    when 'AKIOSK' THEN 'Kiosks'
    when 'AET' THEN 'Emerging Technologies and Displays'
    when 'ET' THEN 'Emerging Technologies and Displays'
    when 'DS' then 'Digital Signage'
    when 'ADS' then 'Digital Signage'
    when 'RETAIL' then 'TruVue'
    when 'HOSP' then 'Hospitality'
    when 'E-TAIL' then 'E-Tail'
    else 'Unknown'
end as Price_List_Group_Name,
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
a.customer_no in ('422660', '422661','827730','827731','836540','836541','810200','100149') 
and
a.price_list_no = c.price_list_no
and c.catalog_no = d.SALES_PART_NO(+)
and a.sales_price_group_id <> 'PRO'
order by a.SALES_PRICE_GROUP_ID, c.CATALOG_NO
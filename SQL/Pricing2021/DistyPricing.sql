Select
a.customer_no,
IFSAPP.CUSTOMER_INFO_API.GET_NAME(a.customer_no) as Name,
case sales_price_group_id
    when 'ACORE' then 'Mounts -- Authorized'
    when 'CORE' then 'Mounts'
    when 'KIOSK' THEN 'Kiosks'
    when 'AKIOSK' THEN 'Kiosks -- Authorized'
    when 'AET' THEN 'Emerging Technologies and Displays -- Authorized'
    when 'ET' THEN 'Emerging Technologies and Displays'
    when 'DS' then 'Digital Signage'
    when 'ADS' then 'Digital Signage -- Authorized'
    when 'RETAIL' then 'TruVue'
    when 'HOSP' then 'Hospitality'
    when 'E-TAIL' then 'E-Tail'
    when 'SHADE' then 'SHADE TV'
    else 'Unknown'
end as Price_List_Group_Name,
c.catalog_no,
IFSAPP.SALES_PART_API.get_catalog_desc('MP', c.catalog_no, 'en') as "Catalog Description",
c.min_quantity,
c.valid_from_date,
c.base_price,
c.sales_price,
d.DESCRIPTION_DOC_TEXT,
d.SHIPPING_DIMENSIONS,
d.PRODUCT_COLOR,
d.PACKAGING,
d.SHIP_WEIGHT,
IFSAPP.GET_INV_CHAR(c.catalog_no, 'MP', 'UPC') as U_P_C_CODE,
d.UPCM,
d.MPQTY,
d.PROD_DIM_I,
d.PROD_DIM_M,
d.PRICE_SHEET_DATE,
d.SALES_UNIT_MEAS,
d.CATALOG_DESC,
d.MODEL_NAME,
d.ITEM_DESCRIPTION_OTHER,
d.SERIALIZED,
d.NOT_FOR_SALE,
d.ITEM_STATUS,
d.MANUFACTURER_CATEGORY_CODE,
d.ITEM_PART_NUMBER_REPLACEMENT,
d.ITEM_MODEL_NUMBER_REPLACEMENT,
d.REQUIRED_ACCESSORIES,
d.OPTIONAL_ACCESSORIES,
d.MAP_PRICE,
d.G_S_A_ITEM_COST,
d.G_S_A_ITEM_SELL_PRICE,
d.DISCOUNT_OFF_LIST,
d.FREIGHT_POLICY,
d.FREIGHT_CODE,
d.FREIGHT_CLASS,
d.DROP_SHIP,
d.CERTIFICATE_FOR_ORIGIN,
d.MANUFACTURER_WEBSITE_LINK,
d.MANUFACTURER_DIVISION_NAME,
d.ITEM_INFOCOMM_I_Q_CATEGORY,
d.INFOCOMM_MEMBER_NUMBER,
d.NOTES
from
customer_pricelist a,
sales_price_list_part c,
ifsinfo.CUSTOMER_PRICE_LIST_NEW2_IAL d
where c.valid_from_date =
                    (SELECT MAX (g.valid_from_date)
                     FROM sales_price_list_part g
                     WHERE     c.catalog_no = g.catalog_no
                           AND c.price_list_no = g.price_list_no
                           AND c.min_quantity = g.min_quantity)
and
--a.customer_no in (827730,422660,810200,836540,827731,836541,422661,423850,695801,118261,695800,015051,575656,062362,154070,423153,695802,546670,521053,719966,186276,722549,852253,499759,985810,373888,359851,598800,364251,936350,147303)
a.customer_no in (600149,783056,614260,125351,059154,076780,719559,173941,423850,695800,062362,154070,695802)
and
a.price_list_no = c.price_list_no
and c.CATALOG_NO = d.sales_part_no (+)
and a.SALES_PRICE_GROUP_ID in ('ACORE','CORE','DS','ADS','ET','AET','HOSP', 'E-TAIL','RETAIL','KIOSK','AKIOSK','SHADE')
and IFSAPP.SALES_PART_API.GET_ACTIVEIND('MP', c.catalog_no) = 'Active part'
order by c.catalog_no




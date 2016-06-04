select * from ifsapp.customer_order_line where order_no like 'W%'

select order_no, ifsapp.customer_order_api.get_customer_po_no(order_no) as "PO_NUMBER"
, catalog_no, buy_qty_due, date_entered, sale_unit_price,
ifsapp.customer_order_line_api.get_sale_price_total(order_no, line_no, rel_no, line_item_no) as "LINE_TOTAL"
, IFSAPP.CUSTOMER_ORDER_ADDRESS_API.GET_STATE(ORDER_NO) AS "DELIVERY_STATE"
, ifsapp.customer_order_api.get_state__(order_no) AS "ORDER_STATUS"
from ifsapp.customer_order_line where 
order_no like 'W%'

SELECT * FROM IFSINFO.CUSTOMER_B2C_ORDERS


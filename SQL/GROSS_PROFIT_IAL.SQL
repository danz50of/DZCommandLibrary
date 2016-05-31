select substr(h.invoice_id,1,10) AS "PRELIM_INVOICE", substr(h.invoice_no,1,10) AS "INVOICE_NO",
d.order_no AS "ORDER_NO", d.line_no AS "LINE_NO", d.release_no AS "RELEASE_NO",
d.line_item_no AS "LINE_ITEM_NO", h.identity AS "CUSTOMER", d.company AS "COMPANY", 
substr(&AO..customer_info_api.get_name(h.identity),1,30) AS "CUST_NAME",
d.item_id AS "LINE_ID", h.invoice_date AS "INV_DATE", d.catalog_no AS "PART", 
d.invoiced_qty AS "QTY", round(d.sale_unit_price,3) AS "UNIT_PRICE", 
substr(&AO..Get_Ledger(h.invoice_id,d.item_id),1,10) AS "LEDGER",
substr(&AO..Get_Product_Line(d.catalog_no,d.contract),1,10) AS "PRODUCT_LINE",
round(d.net_curr_amount,2) AS "SALE_AMT",
substr(&AO..Get_Order_Part_Cost(d.order_no,d.line_no,d.release_no,d.line_item_no),1,10) AS "PART_COST",
substr(&AO..Get_Order_Part_Cost(d.order_no,d.line_no,d.release_no,d.line_item_no),1,10) * d.invoiced_qty AS "EXT_PART_COST",
d.contract AS "SITE",
h.objstate AS "STATUS"
from &AO..customer_order_inv_item d,
&AO..customer_order_inv_head h
where d.invoice_id = h.invoice_id  and
h.objstate <> 'Preliminary'
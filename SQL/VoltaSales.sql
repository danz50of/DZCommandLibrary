select  
substr(h.invoice_id,1,10)                                PRELIM_INVOICE,  
substr(h.invoice_no,1,10)                               INVOICE_NO,  
d.order_no                                                      Order_num,  
h.identity                                                         Customer,   
d.item_id                                                         Line_ID,   
h.invoice_date                                                Inv_Date,  
substr(d.catalog_no,1,16)                               PART,  
d.company                                                      Company,  
substr(IFSAPP.get_prop_code(h.identity,d.company),1,5)   Prop_Code,  
d.description,  
d.invoiced_qty                                                      QTY,  
d.customer_po_no                                          cust_po_no, 
round(d.sale_unit_price,3)                                     Unit_Price,  
substr(IFSAPP.Get_Salesman(h.identity),1,10)      Salesman,  
substr(IFSAPP.Get_Ledger(h.invoice_id,d.item_id),1,10)   Ledger,  
substr(IFSAPP.Get_Product_Line(d.catalog_no,d.contract),1,10)                product_Line,  
substr(IFSAPP.Get_Territory(h.invoice_id,d.item_id),1,10)  Territory,  
round(d.net_curr_amount * h.curr_rate,2)                            SALE_AMT,  
substr(IFSAPP.Get_Order_Part_Cost(d.order_no,d.line_no,d.release_no,d.line_item_no),1,10)   Part_Cost,  
substr(IFSAPP.Get_Order_Part_Cost(d.order_no,d.line_no,d.release_no,d.line_item_no),1,10) * d.invoiced_qty   Ext_Part_Cost,  
substr(IFSAPP.Get_Est_Mat_Costb(d.contract,d.catalog_no),1,10) E_Material_Cost,  
substr(IFSAPP.Get_Labor_Costb(d.contract,d.catalog_no),1,10)  Labor_Cost,  
substr(IFSAPP.Get_Labor_Overhead_Costb(d.contract,d.catalog_no),1,10)         Labor_Overhead_Cost,  
d.contract                 Site,  
h.objstate                  Status,  
substr(IFSAPP.Get_Market_Code(d.order_no),1,10)  Market_Code,  
substr(IFSAPP.Get_Cust_Grp(h.identity),1,10)   Stat_Grp,  
substr(IFSAPP.Get_District(h.identity),1,10)   District,  
substr(IFSAPP.Get_Pricelist(d.order_no,d.item_id),1,10) Pricelist, 
h.curr_rate  Curr_Rate,  
k.name, 
m.address_id, 
m.state, 
p.address1  add1, 
p.address2  add2, 
p.city city, 
p.state  st, 
p.zip_code  zip, 
p.country_code country,
CASE WHEN p.state IN ('ND', 'MO', 'IA', 'NE', 'KS', 'UT', 'CO') 
        THEN 'CENTRAL PLAINES'
     WHEN p.state IN ('IN', 'MI', 'OH', 'KY', 'MN', 'WI') 
        THEN 'NORTH CENTRAL - GREAT LAKES'
     WHEN p.state IN ('MA', 'CT', 'NH', 'ME', 'VT', 'RI', 'ON','PE', 'QC', 'NB', 'NL', 'NS', 'NY') 
        THEN 'NEW ENGLAND'
     WHEN p.state IN ('MD', 'WV', 'DE', 'PA', 'VA', 'DC', 'NJ')
        THEN 'MID ATLANTIC'
     WHEN p.state IN ('OR', 'AK', 'WY', 'BC', 'SK', 'YT', 'NU', 'WA', 'MT', 'ID', 'AB', 'MB', 'NT', 'NU')   
        THEN 'NORTHWEST'
     WHEN p.state IN ('LA', 'TX', 'AR', 'OK', 'MS', 'NM')
        THEN 'SOUTH'
     WHEN p.state IN ('AL', 'GA', 'NC', 'TN', 'FL', 'SC', 'PR')
        THEN 'SOUTHEAST'
     WHEN p.state in ('AZ', 'HI', 'NV')   
        THEN 'SOUTHWEST'
     WHEN p.state in ('CA', 'IL')
        THEN
        CASE WHEN SUBSTR(P.ZIP_CODE,1,5) BETWEEN '60000' AND '61199' 
           THEN 'NORTH CENTRAL - GREAT LAKES'
           WHEN SUBSTR(P.ZIP_CODE,1,5) BETWEEN '93301' AND '96699'
              THEN 'NORTHWEST'
           WHEN SUBSTR(P.ZIP_CODE,1,5) BETWEEN '61200' AND '62999'
              THEN 'CENTRAL PLAINS'
           WHEN SUBSTR(P.ZIP_CODE,1,5) BETWEEN '90000' AND '93300'
              THEN 'SOUTHWEST'
           ELSE 'INVALID NY,IL,CA' END
ELSE '*CHANGE TO HEADQUARTERED REGION*' END AS REGION
from  
IFSAPP.customer_order_inv_item d, 
IFSAPP.customer_order_inv_head h, 
IFSAPP.customer_info k, 
IFSAPP.customer_info_address m, 
IFSAPP.customer_order_address p 
where  
     d.invoice_id = h.invoice_id and  
     d.identity = h.identity and  
     h.objstate <> 'Preliminary' and 
     d.identity = k.customer_id and 
     d.identity = m.customer_id and 
     m.customer_id = '907148' and
     d.identity = p.customer_no and  
     d.order_no = p.order_no and 
     h.delivery_address_id = m.address_id

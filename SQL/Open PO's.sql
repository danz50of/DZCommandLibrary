select Order_no, IFSAPP.PURCHASE_ORDER_API.GET_VENDOR_NO( ORDER_NO ) VENDOR_NO, IFSAPP.SUPPLIER_API.GET_VENDOR_NAME(IFSAPP.PURCHASE_ORDER_API.GET_VENDOR_NO( ORDER_NO )) AS VENDOR_NAME,
Line_no, Release_no, BUYER_CODE, BUY_UNIT_Meas, REQUISITION_NO, BUY_QTY_DUE, BUY_UNIT_PRICE, BUY_QTY_DUE * BUY_UNIT_PRICE AS TOTAL_QTY_DUE, DATE_ENTERED, PLANNED_RECEIPT_DATE,
TO_CHAR(TRUNC(PLANNED_RECEIPT_DATE, 'MM'), 'YYYY/MM') 
from 
    purchase_order_line_all 
where
    contract = 'MP' 
    and state in ('Released', 'Confirmed', 'Received','Arrived')
    
    
   
    
    grant select on ifsinfo.peer_rcptnotinvd to danz50of
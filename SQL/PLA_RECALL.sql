select A.ORDER_NO, A.CUSTOMER_PO_NO, B.LINE_NO, A.CUSTOMER_NO, e.name, B.REAL_SHIP_DATE, 
B.CATALOG_NO, B.CATALOG_DESC, B.QTY_SHIPPED, 
C.PRIMARY_CONTACT BILLING_CONTACT, C.ADDRESS1 BILLING_ADDRESS_1, C.ADDRESS2 BILLING_ADDRESS_2, C.ZIP_CODE BILLING_ZIP_CODE
, C.CITY BILLING_CITY, C.STATE BILLING_STATE, C.COUNTRY BILLING_COUNTRY 
,D.ADDR_1 SHIP_TO_ADDRESS_1, D.ADDR_2 SHIP_TO_ADDRESS_2, D.ADDR_3 SHIP_TO_ADDRESS_3, D.CITY SHIP_TO_CITY, D.STATE SHIP_TO_STATE
, D.ZIP_CODE SHIP_TO_ZIPCODE, D.COUNTRY_CODE SHIP_TO_COUNTRY
from 
customer_order a
join customer_order_line b
on a.order_no = b.order_no and a.customer_NO = b.customer_NO
JOIN CUSTOMER_INFO_ADDRESS C ON A.CUSTOMER_NO = C.CUSTOMER_ID AND A.BILL_ADDR_NO = C.ADDRESS_ID
JOIN CUSTOMER_ORDER_ADDRESS D ON A.ORDER_NO = D.ORDER_NO
join customer_info e on e.customer_id = a.customer_no
where part_no in ('43998','PLA50','PLA50-S','PLA50-UNL','PLA50-UNLP','PLA50-UNLP-GB','PLA50-UNLP-GS','PLA50-UNLP-S',
'PLA50-UNL-S','RTPLA50','RTPLA50-S')
AND TRUNC(REAL_SHIP_DATE, 'DD') BETWEEN TO_DATE('5/14/2007','MM/DD/YYYY') AND TO_DATE('7/30/2007','MM/DD/YYYY') 
and a.state = 'Invoiced/Closed'





SELECT * FROM CUSTOMER_ORDER_ADDRESS WHERE ORDER_NO = 'A220699'

SELECT * FROM CUSTOMER_ORDER WHERE ORDER_NO = 'A214571'


SELECT * FROM CUSTOMER_INFO_ADDRESS WHERE CUSTOMER_ID = '719559'
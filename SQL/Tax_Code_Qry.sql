select A.CUSTOMER_ID, A.LIABILITY_TYPE, B.DATE_DEL, C.FEE_CODE from 
customer_info_vat A, CUST_ORD_CUSTOMER_ENT B, DELIVERY_FEE_CODE C
where A.liability_type = 'TAX'
AND A.CUSTOMER_ID = B.CUSTOMER_ID 
AND A.CUSTOMER_ID = C.IDENTITY
AND C.FEE_CODE <> ' '
ORDER BY A.CUSTOMER_ID



SELECT * FROM DELIVERY_FEE_CODE WHERE IDENTITY = '131664'

SELECT * FROM CUSTOMER_INFO_VAT WHERE CUSTOMER_ID = '131664'




select * from cust_ord_customer_ent where customer_id = '687349'



SELECT * FROM statutory_fee_deduct_multiple
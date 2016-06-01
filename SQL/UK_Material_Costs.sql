select IPART.CONTRACT, IPART.PART_NO, PSUP.VENDOR_NO, 
IFSAPP.SUPPLIER_API.GET_VENDOR_NAME(PSUP.VENDOR_NO) VENDOR_NAME, 
PSUP.CURRENCY_CODE,
(select cur.currency_rate from ifsapp.currency_rate cur where cur.company = '31' 
and cur.currency_type = 10 and cur.currency_code = PSUP.CURRENCY_CODE and cur.valid_from = 
(select max(cur1.valid_from) from ifsapp.currency_rate cur1 where cur1.company = cur.company
and cur1.currency_type = cur.currency_type and cur1.currency_code = cur.currency_code)) CURRENCY_RATE,
PSUP.LIST_PRICE CURRENT_VENDOR_PRICE,
IPART.ESTIMATED_MATERIAL_COST CURRENT_EMAT_COST,
(PSUP.LIST_PRICE * (select cur.currency_rate from ifsapp.currency_rate cur where cur.company = '31' 
and cur.currency_type = 10 and cur.currency_code = PSUP.CURRENCY_CODE and cur.valid_from = 
(select max(cur1.valid_from) from ifsapp.currency_rate cur1 where cur1.company = cur.company
and cur1.currency_type = cur.currency_type and cur1.currency_code = cur.currency_code))) NEW_STD_MATERIAL_COST
FROM INVENTORY_PART IPART, IFSAPP.PURCHASE_PART_SUPPLIER PSUP
WHERE IPART.CONTRACT = 'BBG'
AND PSUP.CONTRACT = IPART.CONTRACT
AND PSUP.PART_NO = IPART.PART_NO
AND PSUP.PRIMARY_VENDOR_DB = 'Y'





   



select * from currency_rate
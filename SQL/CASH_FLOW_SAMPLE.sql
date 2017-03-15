--Ken requested a look at cash flow.  This query will look at open AR and open AP.  Combined with Excel this should break down in's and out's by timeframe

select 'REC' TYPE, INVOICE_ID, SERIES_ID, INVOICE_NO, IDENTITY, NAME, INVOICE_DATE, DUE_DATE, NET_AMOUNT, INVOICE_AMOUNT, OPEN_AMOUNT, (TRUNC(SYSDATE,'DD') - DUE_DATE) DAYS_PASSED_DUE 
from INVOICE_LEDGER_ITEM_CU_QRY
WHERE FULLY_PAID = 'FALSE'
AND COMPANY = '11'
AND SERIES_ID IN ('CR','CD','II')



--Ken requested a look at cash flow.  This query will look at open AR and open AP.  Combined with Excel this should break down in's and out's by timeframe

select 'REC' as TYPE, INVOICE_ID, SERIES_ID, INVOICE_NO, IDENTITY, NAME, INVOICE_DATE, DUE_DATE, NET_AMOUNT, INVOICE_AMOUNT, OPEN_AMOUNT, (TRUNC(SYSDATE,'DD') - DUE_DATE) DAYS_PASSED_DUE, to_char(to_date(to_char(due_date,'yyyymmdd'), 'yyyymmdd'), 'iw') WEEK_NUM 
from INVOICE_LEDGER_ITEM_CU_QRY
WHERE FULLY_PAID = 'FALSE'
AND COMPANY = '11'
AND SERIES_ID IN ('CR','CD','II')
UNION
select 'PAY' as TYPE, INVOICE_ID, SERIES_ID, INVOICE_NO, IDENTITY, NAME, INVOICE_DATE, DUE_DATE, NET_AMOUNT, INVOICE_AMOUNT, OPEN_AMOUNT, (TRUNC(SYSDATE,'DD') - DUE_DATE) DAYS_PASSED_DUE, to_char(to_date(to_char(due_date,'yyyymmdd'), 'yyyymmdd'), 'iw') WEEK_NUM 
from INVOICE_LEDGER_ITEM_SU_QRY
WHERE FULLY_PAID = 'FALSE'
AND COMPANY = '11'
AND SERIES_ID IN ('SI')
SELECT IDENTITY, NAME, invoice_no, GROSS_AMOUNT, NET_AMOUNT, INVOICE_DATE, to_char(INVOICE_DATE,'MM') PERIOD,
to_char(INVOICE_DATE,'YYYY') AS FISCAL_YEAR  
FROM IFSAPP.CUSTOMER_ORDER_INV_HEAD


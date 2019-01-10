select sum(extended_sale) as Sales from ifsinfo.PIVOT_ROLLING_YR_OVER_YR_IAL
where sales_type = 'POS SALES' 
and invoice_date between to_date('1/1/2018','mm/dd/yyyy') and to_date('12/31/2018','mm/dd/yyyy')
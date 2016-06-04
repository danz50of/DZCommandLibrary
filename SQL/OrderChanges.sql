select a.order_no, a.line_no, a.rel_no, a.date_entered Changed_Date, a.userid, a.message_text, b.date_entered order_date_entered from 
customer_order_line_hist a, customer_order_line b
where a.order_no = b.order_no and a.line_no = b.line_no and a.rel_no = b.rel_no
and trunc(a.date_entered, 'dd') = to_date('&ENTER_DATE','mm/dd/yyyy') 
and (a.message_text like 'The quant%' or a.message_text like 'The price%')

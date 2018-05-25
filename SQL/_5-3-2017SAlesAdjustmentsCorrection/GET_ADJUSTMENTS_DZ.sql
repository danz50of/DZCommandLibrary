CREATE OR REPLACE FUNCTION Get_Adjustments_DZ  (Invoice_id_ IN NUMBER, invoice_type_ IN VARCHAR2 ) RETURN NUMBER
IS
Adjustments_ NUMBER;
CURSOR Get_Adjustments  IS
select sum(net_curr_amount)
from ifsapp.invoice_item_tab a, ifsapp.man_cust_invoice_postings b
--, ifsapp.outgoing_invoice_qry c
where invoice_type_ = 'INSTINV' AND
      a.invoice_id = invoice_id_ AND
      b.company = a.company AND
      b.invoice_id = a.invoice_id AND
      b.item_id = a.item_id AND
      --and     c.invoice_id = a.invoice_id
      --and     c.invoice_type = 'INSTINV' 
      b.code_a IN( '5000', '5025', '5027', '5030') and
      b.voucher_type is NOT NULL;
BEGIN
OPEN Get_Adjustments;
FETCH Get_Adjustments INTO Adjustments_;
IF (Get_Adjustments%NOTFOUND) THEN
RETURN 0;
CLOSE Get_Adjustments;
ELSE
RETURN Adjustments_;
CLOSE Get_Adjustments;
END IF;
END;

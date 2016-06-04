CREATE OR REPLACE FUNCTION IFSAPP.MPS_GET_PROJ_ARV_PURCH(
part_no_ in varchar2, order_no_ in varchar2, rel_no_ in varchar2, line_no_ in varchar2) 
return date
is
arv_date_ date;
CURSOR Get_proj_arv is
SELECT PLANNED_RECEIPT_DATE
FROM IFSAPP.PURCHASE_ORDER_LINE_ALL
WHERE PART_NO = part_no_ AND ORDER_NO = order_no_ AND LINE_NO = line_no_ 
AND RELEASE_NO = rel_no_;
Begin
open Get_proj_arv;
fetch Get_proj_arv into arv_date_;
close Get_proj_arv;
return (arv_date_);
end;
 

grant execute on ifsapp.MPS_GET_PROJ_arv_PURCH to ifsinfo;



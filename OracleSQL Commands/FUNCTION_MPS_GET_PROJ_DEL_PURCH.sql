CREATE OR REPLACE FUNCTION IFSAPP.MPS_GET_PROJ_DEL_PURCH(
part_no_ in varchar2, order_no_ in varchar2, rel_no_ in varchar2, line_no_ in varchar2) 
return date
is
del_date_ date;
CURSOR Get_proj_del is
SELECT PLANNED_DELIVERY_DATE
FROM IFSAPP.PURCHASE_ORDER_LINE_ALL
WHERE PART_NO = part_no_ AND ORDER_NO = order_no_ AND LINE_NO = line_no_ 
AND RELEASE_NO = rel_no_;
Begin
open Get_proj_del;
fetch Get_proj_del into del_date_;
close Get_proj_del;
return (del_date_);
end;
 

grant execute on ifsapp.MPS_GET_PROJ_DEL_PURCH to ifsinfo;



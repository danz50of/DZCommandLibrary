CREATE OR REPLACE FUNCTION Get_total_qty(OP_ID_ IN VARCHAR2)
RETURN NUMBER
IS 
scrap_qty number;
cursor Get_Scrap_Qty IS
select get_total_scrap_qty(op_id_) + get_total_prod_qty(op_id_) from dual;
BEGIN
OPEN Get_Scrap_Qty;
fetch Get_Scrap_Qty into scrap_qty;
close Get_Scrap_Qty;
return(scrap_qty);
END;




--grant execute on Get_total_qty to REQUESTIONER;
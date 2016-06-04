CREATE OR REPLACE FUNCTION Get_total_scrap_qty(OP_ID_ IN VARCHAR2)
RETURN NUMBER
IS 
scrap_qty number;
cursor Get_Scrap_Qty IS
select sum (op_qty) from ifsinfo.PRL_LBR_QTY_DET_IAL where op_id = OP_ID_
and reject_reason is not null
group by OP_ID;
BEGIN
OPEN Get_Scrap_Qty;
fetch Get_Scrap_Qty into scrap_qty;
close Get_Scrap_Qty;
return(scrap_qty);
END;




--grant execute on Get_total_scrap_qty to REQUESTIONER;
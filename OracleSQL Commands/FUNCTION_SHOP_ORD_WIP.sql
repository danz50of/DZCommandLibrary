CREATE OR REPLACE FUNCTION EOL_GET_SHOP_ORD_WIP (
part_no_ in varchar2, contract_ in varchar2) return NUMBER
is
wip_ NUMBER;
CURSOR Get_Shop_Ord_Wip IS
SELECT sum(REVISED_QTY_DUE - QTY_COMPLETE) AS WIP 
FROM IFSAPP.SHOP_ORD 
WHERE UPPER(state) in ('STARTED','RELEASED') 
AND PART_NO = part_no_
AND CONTRACT = contract_;
BEGIN
OPEN Get_Shop_Ord_Wip;
FETCH Get_Shop_Ord_Wip INTO wip_;
CLOSE Get_Shop_Ord_Wip;
RETURN wip_;
END;

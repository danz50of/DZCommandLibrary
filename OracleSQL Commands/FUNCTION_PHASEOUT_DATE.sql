CREATE OR REPLACE FUNCTION EOL_GET_CURRENT_POUT_DATE (
part_no_ in varchar2, contract_ in varchar2) return date
is
date_temp_ date;
CURSOR Get_Pout_Date IS
SELECT MIN(EFF_PHASE_OUT_DATE) 
FROM IFSAPP.PROD_STRUCTURE_HEAD
WHERE EFF_PHASE_OUT_DATE >= TRUNC(SYSDATE)
AND PART_NO = part_no_
AND CONTRACT = contract_;
BEGIN
OPEN Get_Pout_Date;
FETCH Get_Pout_Date INTO date_temp_;
CLOSE Get_Pout_Date;
RETURN date_temp_;
END;

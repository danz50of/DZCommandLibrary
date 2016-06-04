CREATE OR REPLACE FUNCTION EOL_GET_CURRENT_PIN_DATE (
part_no_ in varchar2, contract_ in varchar2) return date
is
date_temp_ date;
CURSOR Get_Pin_Date IS
SELECT MAX(EFF_PHASE_IN_DATE) 
FROM IFSAPP.PROD_STRUCTURE_HEAD
WHERE EFF_PHASE_IN_DATE <= TRUNC(SYSDATE)
AND PART_NO = part_no_
AND CONTRACT = contract_;
BEGIN
OPEN Get_Pin_Date;
FETCH Get_Pin_Date INTO date_temp_;
CLOSE Get_Pin_Date;
RETURN date_temp_;
END;

CREATE OR REPLACE FUNCTION Get_Total_Labor_PROD_QTY(op_id_ in varchar2, date_ IN date, EMP_NO_ IN VARCHAR2, OP_INFO_CODE_ IN VARCHAR2)
return number
IS
qty_return_ number(9,5);
CURSOR Get_Qty IS
select SUM(op_qty)
from ifsinfo.prl_lbr_qty_det
where op_id = op_id_
and account_date = trunc(date_,'dd')
and upper(emp_no) = upper(emp_no_)
AND NVL(REJECT_REASON, 'BLANK') = 'BLANK'
GROUP BY OP_ID, ACCOUNT_DATE, EMP_NO, REJECT_REASON;
begin
open Get_Qty;
fetch Get_Qty into QTY_RETURN_;
CLOSE GET_QTY;
IF(UPPER(OP_INFO_CODE_) = 'SETUP') THEN
	QTY_RETURN_ := 0;
END IF;
RETURN nvl(QTY_RETURN_,0);
end;

--GRANT EXECUTE ON Get_Total_Labor_PROD_QTY TO REQUESTIONER;
CREATE OR REPLACE FUNCTION PRL_GET_DEMAND (
part_no_ in varchar2, contract_ in varchar2, days_out_ number) return number
is
output_ number;
cursor Get_Demand is
SELECT  
NVL(SUM(QTY_DEMAND), 0)
FROM ORDER_SUPPLY_DEMAND
WHERE PART_NO = part_no_ AND CONTRACT = contract_
AND UPPER(STATUS_CODE) IN ('PLANNED','STARTED','RELEASED')
AND TRUNC(DATE_REQUIRED) <= TRUNC(SYSDATE+ days_out_);
begin
open Get_Demand;
fetch Get_Demand into output_;
close Get_Demand;
return output_;
end;

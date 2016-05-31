CREATE OR REPLACE FUNCTION MPS_Get_Current_Forecast (
contract_ in varchar2, part_no_ in varchar2, current_day_ in date) return number
is
forecast_ number;
CURSOR Get_Current_Forecast is 
select FORECAST 
from forecast_day_pub
WHERE PART_NO = part_no_
AND CONTRACT = contract_
AND TO_CHAR(START_DATE,'YYYYMM') = TO_CHAR(current_day_,'YYYYMM')
AND TO_CHAR(END_DATE,'YYYYMM') = TO_CHAR(current_day_,'YYYYMM');
Begin
open Get_Current_Forecast;
fetch Get_Current_Forecast into forecast_;
close Get_Current_Forecast;
return forecast_;
end;

--GRANT EXECUTE ON MPS_Get_Current_Forecast to REQUESTIONER;
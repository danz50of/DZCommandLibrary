CREATE OR REPLACE FUNCTION Get_Total_Labor_Hours(op_id_ in varchar2, op_info_code_ in varchar2)
return number
IS
eod_flag varchar2(10);
stop_stamp_ date;
start_stamp_ date;
total_duration number(10,5);

CURSOR Get_Times IS
select start_stamp, stop_stamp, irupt_code 
from ifsinfo.prl_lbr_hrs_det
where op_id = op_id_
and upper(op_info_code) = upper(op_info_code_)
order by start_stamp;
rec Get_Times%rowtype;
begin
total_duration := 0;
open Get_Times;
--fetch Get_Times into rec;
loop
	fetch Get_Times into rec;
	  exit when Get_Times%notfound;
	start_stamp_ := rec.start_stamp;
	stop_stamp_ := rec.stop_stamp;  
	total_duration := total_duration + round((stop_stamp_ - start_stamp_) * 24 * 60, 5);
end loop;
RETURN nvl(total_duration,0);
end;

--GRANT EXECUTE ON Get_Total_Labor_Hours TO REQUESTIONER;
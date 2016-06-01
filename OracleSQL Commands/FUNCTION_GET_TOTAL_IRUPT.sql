CREATE OR REPLACE FUNCTION Get_Total_Labor_IRUPT(op_id_ in varchar2, op_info_code_ in varchar2, date_ IN date, IRUPT_ IN VARCHAR2
, EMP_NO_ IN VARCHAR2)
return varchar2
IS
eod_flag varchar2(10);
counter_ number(10);
stop_stamp_ date;
prev_stop_stamp_ date;
start_stamp_ date;
total_duration number(10,5);
save_total_duration number(10,5);
hours number (2);
minutes number (2);
return_time varchar2(5);
CURSOR Get_Times IS
select start_stamp, stop_stamp, irupt_code
from ifsinfo.prl_lbr_hrs_det
where op_id = op_id_ AND
upper(op_info_code) = upper(op_info_code_)
and account_date = trunc(date_,'dd')
and upper(emp_no) = upper(emp_no_)
--and irupt_code = irupt_
order by op_info_code, start_stamp;
CURSOR Get_Next_Time IS
select start_stamp, stop_stamp, irupt_code
from ifsinfo.prl_lbr_hrs_det
where --op_id = op_id_ AND
--upper(op_info_code) = upper(op_info_code_)
account_date = trunc(date_,'dd')
and upper(emp_no) = upper(emp_no_)
and start_stamp > start_stamp_
--and irupt_code = irupt_
order by start_stamp;
rec Get_Times%rowtype;
rec2 Get_Next_Time%rowtype;
begin
total_duration := 0;
counter_ := 0;
open Get_Times;
fetch Get_Times into rec;
loop
--	fetch Get_Times into rec;
	  exit when Get_Times%notfound;
	 IF (upper(rec.irupt_code) = upper(IRUPT_)) then
	 	stop_stamp_ := rec.stop_stamp;
		start_stamp_ := rec.start_stamp;
		open Get_Next_Time;
		fetch Get_Next_Time into rec2;
			  exit when Get_Times%notfound;
	 	start_stamp_ := rec2.start_stamp;
	 	total_duration := total_duration + round((start_stamp_ - stop_stamp_) * 24, 5);
		fetch Get_Times into rec;
		close Get_Next_Time;
	else
		fetch Get_Times into rec;
	end if;
end loop;
save_total_duration := total_duration;
--convert to minutes, not 100s of minutes
-- (h(hundreds of minutes) * 100) / 1.666666 = M(Minutes)
--hours := trunc(total_duration);
--minutes := round((mod(total_duration, hours) * 100 ) / 1.666666, 2);
--return_time := concat(hours, ':');
--return_time := concat(return_time, minutes); 
--RETURN return_time;
RETURN save_total_duration;
end;

--GRANT EXECUTE ON Get_Total_Labor_Duration TO REQUESTIONER;
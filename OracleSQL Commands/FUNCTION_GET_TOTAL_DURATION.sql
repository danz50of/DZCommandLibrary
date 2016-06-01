CREATE OR REPLACE FUNCTION Get_Total_Labor_Duration(op_id_ in varchar2, op_info_code_ in varchar2, date_ in date, emp_no_ in varchar2,
type_ in varchar2)
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
where op_id = op_id_
and upper(op_info_code) = upper(op_info_code_)
and upper(emp_no) = upper(emp_no_)
and account_date = trunc(date_,'dd')
--and irupt_code = irupt_code_
order by start_stamp;
rec Get_Times%rowtype;
begin
total_duration := 0;
--counter_ := 0;
open Get_Times;
fetch Get_Times into rec;
loop
--	fetch Get_Times into rec;
	  exit when Get_Times%notfound;
	 stop_stamp_ := rec.stop_stamp;
	 start_stamp_ := rec.start_stamp;
--	 if counter_ = 0 then
	 	total_duration := total_duration + round((stop_stamp_ - start_stamp_) * 24, 5);
--	 else
--	 	total_duration := total_duration + round((stop_stamp_ - start_stamp_) * 24, 5);
--		total_duration := total_duration + round((start_stamp_ - prev_stop_stamp_) * 24, 5);
--	 end if;
--    prev_stop_stamp_ := stop_stamp_;
--	if UPPER(rec.irupt_code) = 'INS' then 
--	 	counter_ := 0;
--	else
--		counter_ := 0; 
--	end if;
	fetch Get_Times into rec;
end loop;
save_total_duration := total_duration;
--convert to minutes, not 100s of minutes
-- (h(hundreds of minutes) * 100) / 1.666666 = M(Minutes)
hours := trunc(total_duration);
minutes := round((mod(total_duration, hours) * 100 ) / 1.666666, 2);
return_time := concat(hours, ':');
if minutes < 10 then
   return_time := concat(return_time, '0');
end if;
return_time := concat(return_time, minutes); 
if upper(type_) = 'HH' then
   RETURN return_time;
else
   RETURN nvl(save_total_duration,0);
end if;
end;

--GRANT EXECUTE ON Get_Total_Labor_Duration TO REQUESTIONER;
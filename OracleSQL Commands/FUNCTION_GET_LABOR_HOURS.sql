CREATE OR REPLACE FUNCTION Get_labor_hours(op_id_ in varchar2, emp_no_ in varchar2,
irupt_code_ in varchar2, info_code in varchar2)
return number
IS
hours number(9,4);
begin_time date;
end_time date;
CURSOR Get_Start_Time IS
select start_stamp
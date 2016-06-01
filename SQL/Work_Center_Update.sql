select * from work_center_resource_avail_tab 
where contract = 'MP'
order by begin_date



update work_center_resource_avail_tab
set begin_date = to_date('1/1/2001','mm/dd/yyyy')
where work_center_no = 'PP10' and contract = 'MP';


commit
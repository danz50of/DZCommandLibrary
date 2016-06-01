select contract, part_no, resource_id, work_center_no, trunc(work_day,'iw') WEEK, op_finish_time - op_start_time Hours 
from ifsapp.crp_mach_op_load
where work_day > to_date('1/1/2009','mm/dd/yyyy')

select * from ifsapp.crp_mach_op_load

select * from crp_mach_op_load_tab where work_day = to_date('4/14/2009', 'mm/dd/yyyy') and work_center_no = 'PK1'

select work_center_no, part_no, order_no, trunc(op_finish_date,'iw') WEEK, op_finish_time - op_start_time HOURS,
revised_qty_due
from crp_mach_operation2 where op_start_date > to_date('4/14/2011', 'mm/dd/yyyy') --and work_center_no = 'PK1'

select order_no, part_no, revised_qty_due, null, trunc(op_start_date,'iw') WEEK, null, 
work_center_no, null, op_finish_time - op_start_time HOURS, null
from crp_mach_operation2 where order_no is null

select mac_op.order_no, so.part_no, so.revised_qty_due , mac_op.operation_no, trunc(mac_op.work_day,'iw') WORK_WEEK,
mac_op.work_day, 
mac_op.work_center_no, mac_op.resource_id, 
mac_op.Hours_loaded, so.STATE
from mach_operation_load_tab mac_op, shop_ord so,
ifsinfo.prl_capacity_routing cap_rout
where so.order_no = mac_op.order_no
and cap_rout.part_no = so.part_no
and cap_rout.operation_no = mac_op.operation_no
and cap_rout.contract = 'MP'
and so.contract = 'MP'
and mac_op.contract = 'MP'
and op_start_date > to_date('1/1/2009','mm/dd/yyyy')
union
select order_no, part_no, revised_qty_due, null, trunc(op_start_date,'iw') WORK_WEEK, null, 
work_center_no, null, op_finish_time - op_start_time HOURS, null
from crp_mach_operation2 where order_no is null
and op_start_date > to_date('1/1/2009','mm/dd/yyyy')








order by work_day, part_no


select * from mach_operation_load_tab where work_day > to_date('4/1/2009','mm/dd/yyyy')



select * from mach_operation_load_tab where order_no = 644159


select * from ifsinfo.prl_capacity_routing order by phase_out_date desc

select * from ifsinfo.prl_capacity_routing where part_no = 'ST632' and phase_in_date <= sysdate and (phase_out_date >= sysdate or phase_out_date is null) 




select max(routing_revision j) from ifsinfo.capacity_routing where j.part_no = cap_rout.part_no and j.contract = 'MP' and j.phase_in_date <= sysdate and (j.phase_out_date >= sysdate or j.phase_out_date is not null)







select * from ifsinfo.prl_capacity_routing where 1 = 0 
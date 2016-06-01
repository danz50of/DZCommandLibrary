select
org_code,
emp_no,
emp_name,
account_date,
part_no,
order_no,
op_no,
op_id,
revised_qty_due S_O_Qty,
work_center W_C,
work_center_description W_C_Description,
max(setup_standard) Stnd_Setup_Hours,
max(actual_setup_hours) Actual_Setup_Hours,
max(Setup_Labor_rate) Setup_Labor_Rate,
  max(stnd_setup_cost) Stnd_Op_Setup_Cost,
  max(Actual_setup_cost) Actual_Op_Setup_Cost,
max(stnd_production_work_hours) Stnd_Production_Work_Hours,
max(actual_production_work_hours) Actual_Production_Work_Hours,
max(Setup_Labor_rate) Stnd_Labor_Rate,
  max(Stnd_Run_Labor_Cost) Stnd_Run_Labor_Cost,
  max(actual_run_labor_cost) Actual_Run_Labor_Cost,
max(standard_crewsize) Stnd_Crew_Size,
max(shop_ord_op_crewsize) S_O_Op_Crew_Size,
max(op_qty_complete) Op_Qty_Complete,
max(stnd_w_c_machine_rate) Stnd_Machine_Rate,
max(Stnd_Mach_Run_Cost) Stnd_Mach_Run_Cost,
max(actual_machine_run_cost) Actual_Machine_Run_Cost,
max(Stnd_Mach_Setup_Cost) Stnd_Mach_Setup_Cost,
max(actual_machine_setup_cost) Actual_Machine_Setup_Cost,
max(standard_p_p_h) Stnd_P_P_H,
max(Actual_P_P_H) Actual_P_P_H,
max(stnd_setup_cost) - max(Actual_setup_cost) + max(Stnd_Run_Labor_Cost) - max(actual_run_labor_cost) Didderence

from
(select
a.org_code,
a.emp_no,
a.emp_name,
a.account_date,
a.part_no,
a.order_no,
a.op_no,
a.op_id,
b.revised_qty_due,
a.work_center_no work_center,
a.work_center_description,
a.setup_standard,
a.s_work_hours actual_setup_hours,
round(d.labor_class_rate + (d.labor_class_rate * (d.overhead_fac/100)),2) Setup_Labor_Rate,
round(d.labor_class_rate + (d.labor_class_rate * (d.overhead_fac/100)),2) *a.setup_standard Stnd_Setup_Cost,
round(d.labor_class_rate + (d.labor_class_rate * (d.overhead_fac/100)),2) *a.s_work_hours Actual_Setup_Cost,

(case a.run_standard
    when 0
        then 0
    else
        round(a.r_prod_qty / a.run_standard,2)
    end) 
Stnd_Production_Work_Hours,

a.r_work_hours actual_production_work_hours,

round(d.labor_class_rate + (d.labor_class_rate * (d.overhead_fac/100)),2) * a.r_work_hours Actual_Run_Labor_Cost,

(case a.run_standard
    when 0
        then 0
    else
        round(a.r_prod_qty / a.run_standard,2) * round(d.labor_class_rate + (d.labor_class_rate * (d.overhead_fac/100)),2)
end)
Stnd_Run_Labor_Cost,
a.shop_ord_op_crewsize,
a.standard_crewsize,
a.r_prod_qty Op_Qty_Complete,
c.wc_rate Stnd_W_C_Machine_Rate,

(case a.run_standard
    when 0
        then 0
    else
        round(a.r_prod_qty / a.run_standard,2) * c.wc_rate
    end) 
Stnd_Mach_Run_Cost,

round(c.wc_rate * a.r_work_hours,2) Actual_Machine_Run_Cost,
round(c.wc_rate * a.setup_standard,2) Stnd_Mach_Setup_Cost,
round(c.wc_rate * a.s_work_hours,2) Actual_Machine_Setup_Cost,
a.run_standard Standard_P_P_H,
(case r_work_hours
      when 0
        then 0
      else
        round(r_prod_qty / r_work_hours,0)
      end) 
Actual_P_P_H


from
ifsinfo.labor_by_operation_ial a,
ifsapp.shop_ord b,
ifsapp.work_center_cost c,
ifsapp.labor_class_cost d,
ifsapp.part_cost e

where
b.contract = 'MP' and c.contract = 'MP' and d.contract = 'MP' and e.contract = 'MP'
and a.order_no = b.order_no
and a.work_center_no = c.work_center_no and c.cost_set = '1'
and a.labor_class_no = d.labor_class_no and d.cost_set = '1'
and a.part_no = e.part_no and e.cost_set = '1'
and TRUNC(a.ACCOUNT_DATE,'DD') BETWEEN
TO_DATE('&FROM_DATE','MM/DD/YYYY') AND
TO_DATE('&TO_DATE','MM/DD/YYYY'))

group by
org_code,
emp_no,
emp_name,
account_date,
part_no,
order_no,
op_no,
op_id,
revised_qty_due,
work_center,
work_center_description
order by
org_code,
emp_name,
order_no,
op_id
/

 --   Date Format:  MM/DD/YYYY
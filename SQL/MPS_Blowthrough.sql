SELECT
MPS_PART,
ON_HAND,
ALLOCATED,
CURR_BUDGET,
NEXT_MO_BUDGET,
BUDGET_2_MO,
UNIT_COST,
PART_NO,
BOM_TYPE,
COMPONENT_PART,
COMPONENT_UNIT_COST,
ALTERNATE,
QTY_PER_ASSEMBLY,
operation_no,
operation_description,
mach_run_factor,
mach_setup_time,
(qty_per_assembly * curr_budget) total_budget_qty,
(((qty_per_assembly * curr_budget) / (mach_run_factor+.00000000000000000001)) + mach_setup_time ) CURR_MO_total_machine_hours,
(((qty_per_assembly * NEXT_MO_budget) / (mach_run_factor+.00000000000000000001)) + mach_setup_time ) NEXT_MO_total_machine_hours,
(((qty_per_assembly * BUDGET_2_MO) / (mach_run_factor+.00000000000000000001)) + mach_setup_time ) NEXT2_MO_total_machine_hours,
labor_class_type,
labor_class_rate,
labor_overhead_fac,
labor_setup_time,
labor_run_Factor,
crew_size,
(((qty_per_assembly * curr_budget) / (labor_run_factor+.00000000000000000001) * crew_size ) + labor_setup_time ) CURR_MO_total_labor_hours,
(((qty_per_assembly * NEXT_MO_BUDGET) / (labor_run_factor+.00000000000000000001) * crew_size ) + labor_setup_time ) NEXT_MO_total_labor_hours,
(((qty_per_assembly * BUDGET_2_MO) / (labor_run_factor+.00000000000000000001) * crew_size ) + labor_setup_time ) NEXT2_MO_total_labor_hours,
work_center_no,
Description,
WC_DEPARTMENT,
IFSAPP.CODE_B_API.GET_DESCRIPTION(11, WC_DEPARTMENT, 'EN') DEPARTMENT,
wrk_cnt_cost
FROM
     (SELECT a.part_no MPS_part,
            a.qty_onhand on_hand,
            a.qty_allocated allocated,
            (select sum(budget) from ifsapp.forecast_day_pub z where trunc(add_months(sysdate, 0),'MM') between start_date and end_date and a.part_no = z.part_no) CURR_BUDGET,
            (select sum(budget) from ifsapp.forecast_day_pub z where trunc(add_months(sysdate, 1),'MM') between start_date and end_date and a.part_no = z.part_no) NEXT_MO_BUDGET,
            (select sum(budget) from ifsapp.forecast_day_pub z where trunc(add_months(sysdate, 2),'MM') between start_date and end_date and a.part_no = z.part_no) BUDGET_2_MO,   
            CASE
               WHEN    e.operation_no IS NOT NULL
                    OR SUBSTR (c.component_part, 1, 2) = 'VP'
               THEN
                  0
               ELSE
                  ROUND (d.inventory_value, 2)
            END
               unit_cost,
            c.part_no,
            c.bom_type,
            c.component_part,
            CASE
               WHEN    e.operation_no IS NOT NULL
                    OR SUBSTR (c.component_part, 1, 2) = 'VP'
               THEN
                  0
               ELSE
                  ROUND (f.inventory_value, 2)
            END
               component_unit_cost,
            c.alternate,
            c.qty_per_assembly,
            CASE
               WHEN e.operation_no IS NULL THEN 'NO ROUTING'
               ELSE SUBSTRB (e.operation_no, 1, 7)
            END
               operation_no,
            e.operation_description,
            e.mach_run_factor,
            e.mach_setup_time,
            e.labor_class_no labor_class_type,
            g.labor_class_rate,
            g.overhead_fac labor_overhead_fac,
            e.labor_setup_time,
            E.LABOR_RUN_FACTOR,
            e.crew_size,
            e.work_center_no,
            ifsapp.work_center_api.Get_Description ('MP', e.work_center_no)
               Description,
            IFSAPP.WORK_CENTER_API.GET_DEPARTMENT_NO('MP', E.WORK_CENTER_NO) WC_DEPARTMENT,
            h.wc_rate wrk_cnt_cost
       FROM IFSAPP.level_1_part a,
            IFSAPP.inventory_part b,
            ifsinfo.exploded_part_load_all c,
            IFSAPP.inventory_part_unit_cost_sum d,
            IFSAPP.routing_operation e,
            IFSAPP.inventory_part_unit_cost_sum f,
            IFSAPP.labor_class_cost g,
            IFSAPP.work_center_cost h
      WHERE     a.ms_active_flag_db = 'A'
            AND b.part_status = 'A'
            AND a.part_no = b.part_no
            AND b.contract = 'MP'
            AND a.part_no = c.part_in
            AND c.site = 'MP'
            AND c.alternate = '*'
            AND a.part_no = d.part_no(+)
            AND d.contract(+) = 'MP'
            AND c.component_part = f.part_no(+)
            AND f.contract(+) = 'MP'
            AND c.component_part = e.part_no(+)
            AND e.contract(+) = 'MP'
            AND e.phase_in_date(+) <= TRUNC (SYSDATE)
            AND e.phase_out_date(+) IS NULL
            AND e.alternative_no(+) = '*'
            AND e.labor_class_no = g.labor_class_no(+)
            AND g.cost_set(+) = 1
            AND g.contract(+) = 'MP'
            AND e.work_center_no = h.work_center_no(+)
            AND h.cost_set(+) = 1
            AND h.contract(+) = 'MP'
   ORDER BY a.part_no, c.component_part, e.operation_no)
   
   
   
   
   
   
   
   
   select sum(budget) from ifsapp.forecast_day_pub where trunc(add_months(sysdate, 0),'MM') between start_date and end_date
   
   
   
   
   select add_months(sysdate, 1) from dual 
   
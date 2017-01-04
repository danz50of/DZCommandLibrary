--LABOR REPORT SOURCE FOR 2016 DATA REVIEW

     SELECT org_code,
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
            MAX (setup_standard) Stnd_Setup_Hours,
            MAX (actual_setup_hours) Actual_Setup_Hours,
            MAX (Setup_Labor_rate) Setup_Labor_Rate,
            MAX (stnd_setup_cost) Stnd_Op_Setup_Cost,
            MAX (Actual_setup_cost) Actual_Op_Setup_Cost,
            MAX (stnd_production_work_hours) Stnd_Production_Work_Hours,
            MAX (actual_production_work_hours) Actual_Production_Work_Hours,
            MAX (Setup_Labor_rate) Stnd_Labor_Rate,
            MAX (Stnd_Run_Labor_Cost) Stnd_Run_Labor_Cost,
            MAX (actual_run_labor_cost) Actual_Run_Labor_Cost,
            MAX (standard_crewsize) Stnd_Crew_Size,
            MAX (shop_ord_op_crewsize) S_O_Op_Crew_Size,
            MAX (op_qty_complete) Op_Qty_Complete,
            MAX (stnd_w_c_machine_rate) Stnd_Machine_Rate,
            MAX (Stnd_Mach_Run_Cost) Stnd_Mach_Run_Cost,
            MAX (actual_machine_run_cost) Actual_Machine_Run_Cost,
            MAX (Stnd_Mach_Setup_Cost) Stnd_Mach_Setup_Cost,
            MAX (actual_machine_setup_cost) Actual_Machine_Setup_Cost,
            MAX (standard_p_p_h) Stnd_P_P_H,
            MAX (Actual_P_P_H) Actual_P_P_H,
            (  (MAX (stnd_setup_cost) - MAX (Actual_setup_cost))
             + (MAX (Stnd_Run_Labor_Cost) - MAX (actual_run_labor_cost))
             + (MAX (Stnd_Mach_Setup_Cost) - MAX (actual_machine_setup_cost))
             + (MAX (Stnd_Mach_Run_Cost) - MAX (actual_machine_run_cost)))
               Difference,
            shop_ord_run_code,
            routing_run_code,
            phase_in_date_to_use,
            (CASE
                WHEN MAX (Actual_setup_cost) > 0
                THEN
                   (MAX (stnd_setup_cost) / MAX (Actual_setup_cost)) * 100
                ELSE
                   0
             END)
               PTS_SETUP,
            (CASE
                WHEN MAX (actual_run_labor_cost) > 0
                THEN
                     (MAX (stnd_run_labor_cost) / MAX (actual_run_labor_cost))
                   * 100
                ELSE
                   0
             END)
               PTS_RUN
       FROM (SELECT a.org_code,
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
                    ROUND (
                         d.labor_class_rate
                       + (d.labor_class_rate * (d.overhead_fac / 100)),
                       2)
                       Setup_Labor_Rate,
                      ROUND (
                           d.labor_class_rate
                         + (d.labor_class_rate * (d.overhead_fac / 100)),
                         2)
                    * a.setup_standard
                       Stnd_Setup_Cost,
                      ROUND (
                           d.labor_class_rate
                         + (d.labor_class_rate * (d.overhead_fac / 100)),
                         2)
                    * a.s_work_hours
                       Actual_Setup_Cost,
                    (CASE (SELECT run_time_code
                             FROM IFSAPP.routing_operation g
                            WHERE     g.part_no = a.part_no
                                  AND a.op_no = g.operation_no
                                  AND g.phase_in_date =
                                         IFSAPP.phase_in_account_date (
                                            a.part_no,
                                            'MP',
                                            a.account_date)
                                  AND g.alternative_no = '*'
                                  AND g.contract = 'MP'
                                  AND g.bom_type_db <> 'F')
                        WHEN 'Hours/Unit'
                        THEN
                           (CASE a.run_standard
                               WHEN 0 THEN 0
                               ELSE ROUND (a.r_prod_qty * a.run_standard, 2)
                            END)
                        WHEN 'Hours'
                        THEN
                           a.run_standard
                        ELSE
                           (CASE a.run_standard
                               WHEN 0 THEN 0
                               ELSE ROUND (a.r_prod_qty / a.run_standard, 2)
                            END)
                     END)
                       Stnd_Production_Work_Hours,
                    a.r_work_hours actual_production_work_hours,
                      ROUND (
                           d.labor_class_rate
                         + (d.labor_class_rate * (d.overhead_fac / 100)),
                         2)
                    * a.r_work_hours
                       Actual_Run_Labor_Cost,
                    (CASE (SELECT run_time_code
                             FROM IFSAPP.routing_operation g
                            WHERE     g.part_no = a.part_no
                                  AND a.op_no = g.operation_no
                                  AND g.phase_in_date =
                                         IFSAPP.phase_in_account_date (
                                            a.part_no,
                                            'MP',
                                            a.account_date)
                                  AND g.alternative_no = '*'
                                  AND g.contract = 'MP'
                                  AND g.bom_type_db <> 'F')
                        WHEN 'Hours/Unit'
                        THEN
                           (CASE a.run_standard
                               WHEN 0
                               THEN
                                  0
                               ELSE
                                    ROUND (a.r_prod_qty * a.run_standard, 2)
                                  * ROUND (
                                         d.labor_class_rate
                                       + (  d.labor_class_rate
                                          * (d.overhead_fac / 100)),
                                       2)
                            END)
                        WHEN 'Hours'
                        THEN
                           (CASE a.run_standard
                            when 0
                            then
                                0
                            else
                                ROUND (
                                    a.run_standard * d.labor_class_rate
                                    + (d.labor_class_rate * (d.overhead_fac / 100)),
                                    2)
                            end)
                        ELSE
                           (CASE a.run_standard
                               WHEN 0
                               THEN
                                  0
                               ELSE
                                    ROUND (a.r_prod_qty / a.run_standard, 2)
                                  * ROUND (
                                         d.labor_class_rate
                                       + (  d.labor_class_rate
                                          * (d.overhead_fac / 100)),
                                       2)
                            END)
                     END)
                       Stnd_Run_Labor_Cost,
                    a.shop_ord_op_crewsize,
                    a.standard_crewsize,
                    a.r_prod_qty Op_Qty_Complete,
                    c.wc_rate Stnd_W_C_Machine_Rate,
                    (CASE (SELECT run_time_code
                             FROM IFSAPP.routing_operation g
                            WHERE     g.part_no = a.part_no
                                  AND a.op_no = g.operation_no
                                  AND g.phase_in_date =
                                         IFSAPP.phase_in_account_date (
                                            a.part_no,
                                            'MP',
                                            a.account_date)
                                  AND g.alternative_no = '*'
                                  AND g.contract = 'MP'
                                  AND g.bom_type_db <> 'F')
                        WHEN 'Hours/Unit'
                        THEN
                           (CASE a.run_standard
                               WHEN 0
                               THEN
                                  0
                               ELSE
                                    ROUND (a.r_prod_qty * a.run_standard, 2)
                                  * c.wc_rate
                            END)
                        WHEN 'Hours'
                        THEN
                           ROUND (a.run_standard * c.wc_rate, 2)
                        ELSE
                           (CASE a.run_standard
                               WHEN 0
                               THEN
                                  0
                               ELSE
                                    ROUND (a.r_prod_qty / a.run_standard, 2)
                                  * c.wc_rate
                            END)
                     END)
                       Stnd_Mach_Run_Cost,
                    ROUND (c.wc_rate * a.r_work_hours, 2)
                       Actual_Machine_Run_Cost,
                    ROUND (c.wc_rate * a.setup_standard, 2)
                       Stnd_Mach_Setup_Cost,
                    ROUND (c.wc_rate * a.s_work_hours, 2)
                       Actual_Machine_Setup_Cost,
                    a.run_standard Standard_P_P_H,
                    (CASE (SELECT run_time_code
                             FROM IFSAPP.shop_order_operation f
                            WHERE     f.order_no = b.order_no
                                  AND a.op_no = f.operation_no)
                        WHEN 'Hours/Unit'
                        THEN
                           (CASE a.r_work_hours
                               WHEN 0 THEN 0
                               ELSE ROUND (r_prod_qty * r_work_hours, 0)
                            END)
                        ELSE
                           (CASE a.r_work_hours
                               WHEN 0 THEN 0
                               ELSE ROUND (r_prod_qty / r_work_hours, 0)
                            END)
                     END)
                       Actual_P_P_H,
                    (SELECT f.run_time_code
                       FROM IFSAPP.shop_order_operation f
                      WHERE     f.order_no = b.order_no
                            AND a.op_no = f.operation_no)
                       shop_ord_run_code,
                    (SELECT g.run_time_code
                       FROM IFSAPP.routing_operation g
                      WHERE     g.part_no = a.part_no
                            AND a.op_no = g.operation_no
                            AND g.phase_in_date =
                                   IFSAPP.phase_in_account_date (
                                      a.part_no,
                                      'MP',
                                      a.account_date)
                            AND g.alternative_no = '*'
                            AND g.contract = 'MP'
                            AND g.bom_type_db <> 'F')
                       routing_run_code,
                    IFSAPP.phase_in_account_date (a.part_no,
                                                  'MP',
                                                  a.account_date)
                       phase_in_date_to_use
               FROM ifsinfo.labor_by_operation_ial a,
                    IFSAPP.shop_ord b,
                    IFSAPP.work_center_cost c,
                    IFSAPP.labor_class_cost d,
                    IFSAPP.part_cost e
                    WHERE     TO_CHAR (account_date, 'yyyymm') BETWEEN '201601'
                              AND '201612'
                    AND b.contract = 'MP'
                    AND c.contract = 'MP'
                    AND d.contract = 'MP'
                    AND e.contract = 'MP'
                    AND a.order_no = b.order_no
                    AND a.work_center_no = c.work_center_no
                    AND c.cost_set = '1'
                    AND a.labor_class_no = d.labor_class_no
                    AND d.cost_set = '1'
                    AND a.part_no = e.part_no
                    AND e.cost_set = '1')
   GROUP BY org_code,
            emp_no,
            emp_name,
            account_date,
            part_no,
            order_no,
            op_no,
            op_id,
            revised_qty_due,
            work_center,
            work_center_description,
            shop_ord_run_code,
            routing_run_code,
            phase_in_date_to_use
   ORDER BY org_code,
            emp_name,
            order_no,
            op_id
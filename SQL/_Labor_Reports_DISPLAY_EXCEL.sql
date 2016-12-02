--Deployed in IFSINFO.PRL_LABOR_BY_OP_PACK_FAB_IAL

     SELECT org_code org,
            emp_name,
            account_date acct_date,
            part_no,
            order_no s_o_no,
            op_no,
            S_O_Qty,
            W_C,
            W_C_Description,
            Stnd_Setup_Hours S_Setup_Hrs,
            (actual_setup_hours) A_Setup_Hrs,
            (Setup_Labor_rate) Setup_Lbr_Rate,
            (Stnd_Op_Setup_Cost) S_Op_Setup_Cost,
            (Actual_Op_Setup_Cost) A_Op_Setup_Cost,
            (stnd_production_work_hours) S_Prod_Wrk_Hrs,
            (actual_production_work_hours) A_Prod_Wrk_Hrs,
            (Setup_Labor_rate) S_Lbr_Rate,
            (Stnd_Run_Labor_Cost) S_Run_Lbr_Cost,
            (actual_run_labor_cost) A_Run_Lbr_Cost,
            (Stnd_Crew_Size) S_CrewSize,
            (S_O_Op_Crew_Size) S_O_CrewSize,
            (op_qty_complete) Op_Qty_Complete,
            (Stnd_Machine_Rate) S_Mach_Rate,
            (Stnd_Mach_Run_Cost) S_Mach_Run_Cost,
            (actual_machine_run_cost) A_Mach_Run_Cost,
            (Stnd_Mach_Setup_Cost) S_Mach_Setup_Cost,
            (actual_machine_setup_cost) A_Mach_Setup_Cost,
            (Stnd_P_P_H) S_P_P_H,
            (Actual_P_P_H) A_P_P_H,
            Difference diff,
            shop_ord_run_code,
            routing_run_code,
            (CASE
                WHEN (Actual_Op_Setup_Cost) > 0
                THEN
                   ( (Stnd_Op_Setup_Cost) / (Actual_Op_Setup_Cost))
                ELSE
                   0
             END)
               PTS_SETUP,
            (CASE
                WHEN (actual_run_labor_cost) > 0
                THEN
                   ( (stnd_run_labor_cost) / (actual_run_labor_cost))
                ELSE
                   0
             END)
               PTS_RUN
       FROM ifsinfo.prl_LAB_ACT_STND_BY_OP_B
      WHERE     account_date >= SYSDATE - 8
            AND org_code IN ('1123')
   ORDER BY org_code, account_date, emp_no, shop_ord_run_code,
            routing_run_code
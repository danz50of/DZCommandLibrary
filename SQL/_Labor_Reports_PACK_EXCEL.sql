--Deployed in IFSINFO.PRL_LABOR_BY_OP_PACK_EXCEL_IAL

     SELECT account_date,
            part_no,
            order_no,
            OP_NO,
            S_O_QTY,
            W_C_DESCRIPTION,
            MAX (STND_SETUP_HOURS) STND_SETUP_HOURS,
            MAX (ACTUAL_SETUP_HOURS) ACTUAL_SETUP_HOURS,
            MAX (SETUP_LABOR_RATE) SETUP_LABOR_RATE,
            MAX (STND_OP_SETUP_COST) STND_OP_SETUP_COST,
            MAX (ACTUAL_OP_SETUP_COST) ACTUAL_OP_SETUP_COST,
            MAX (STND_PRODUCTION_WORK_HOURS) STND_PRODUCTION_WORK_HOURS,
            MAX (ACTUAL_PRODUCTION_WORK_HOURS) ACTUAL_PRODUCTION_WORK_HOURS,
            MAX (STND_LABOR_RATE) STND_LABOR_RATE,
            MAX (STND_RUN_LABOR_COST) STND_RUN_LABOR_COST,
            MAX (ACTUAL_RUN_LABOR_COST) ACTUAL_RUN_LABOR_COSTS,
            MAX (STND_CREW_SIZE) STND_CREW_SIZE,
            MAX (S_O_OP_CREW_SIZE) S_O_OP_CREW_SIZE,
            MAX (OP_QTY_COMPLETE) OP_QTY_COMPLETE,
            MAX (STND_P_P_H) STND_P_P_H,
            MAX (ACTUAL_P_P_H) ACTUAL_P_P_H,
            MAX (DIDDERENCE) DIFFERENCE,
            (CASE
                WHEN MAX (Actual_Op_Setup_Cost) > 0
                THEN
                   (MAX (Stnd_Op_Setup_Cost) / MAX (Actual_Op_Setup_Cost))
                ELSE
                   0
             END)
               PTS_SETUP,
            (CASE
                WHEN MAX (actual_run_labor_cost) > 0
                THEN
                   (MAX (stnd_run_labor_cost) / MAX (actual_run_labor_cost))
                ELSE
                   0
             END)
               PTS_RUN,
            org_code dept_num
       FROM ifsinfo.PRL_LAB_ACT_STND_BY_OP_B
      WHERE     org_code IN ('1122', '1141')
            AND account_date >= TRUNC (SYSDATE - 7, 'dd')
   GROUP BY ACCOUNT_DATE,
            PART_NO,
            ORDER_NO,
            OP_NO,
            S_O_QTY,
            W_C_DESCRIPTION,
            ORG_CODE
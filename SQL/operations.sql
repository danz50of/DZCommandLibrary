   SELECT a.work_center_no, ifsapp.work_center_api.Get_Average_Capacity('MP',A.WORK_CENTER_NO) * 20.5 "MONTHLY_CAPACITY_AT_20.5_DAYS",
          a.order_no, a.part_no, a.operation_no,
          a.labor_run_factor,
          a.labor_setup_time SETUP_HOURS,
          (case a.labor_run_factor
          when 0 then 0
          when null then 0
          else IFSAPP.PRL_CONVERT_100MINUTES(ROUND((a.revised_qty_due/(a.labor_run_factor)),2))
          end) STANDARD_HOURS, 
          (CASE A.LABOR_RUN_FACTOR
          WHEN 0 THEN 0
          WHEN NULL THEN 0
          ELSE A.LABOR_SETUP_TIME + IFSAPP.PRL_CONVERT_100MINUTES(ROUND((a.revised_qty_due/(a.labor_run_factor)),2))
          END) TOTAL_HOURS,
          (CASE A.LABOR_RUN_FACTOR
          WHEN 0 THEN 0
          WHEN NULL THEN 0
          ELSE (A.LABOR_SETUP_TIME+IFSAPP.PRL_CONVERT_100MINUTES(a.revised_qty_due/(a.labor_run_factor)))/((ifsapp.work_center_api.Get_Average_Capacity('MP',A.WORK_CENTER_NO)*20.5))
          END) PERCENTAGE_USED,
          a.op_start_date, a.op_finish_date,
          a.revised_qty_due, a.qty_complete, b.real_start, b.real_finished,
          TO_CHAR (b.real_start, 'MM') start_month,
          TO_CHAR (b.real_start, 'YYYY') start_year,
          ifsapp.work_center_api.get_description
                                 ('MP',
                                  a.work_center_no
                                 ) AS work_center_description
     FROM ifsapp.shop_order_operation a JOIN ifsapp.shop_order_statistic b
          ON a.order_no = b.order_no
        AND a.release_no = b.release_no
        AND a.sequence_no = b.sequence_no
    WHERE oper_status_code = 'Closed'
      AND a.contract = 'MP'
      AND TRUNC (b.real_start, 'YYYY') > TRUNC(SYSDATE,'YYYY') - 366
      
      
      
      SELECT TRUNC(SYSDATE,'YYYY') FROM DUAL
      
      
      
      
      
SELECT MOD(64,60)/100, MOD(34,60) FROM DUAL

      
      
      
SELECT IFSAPP.PRL_ADD_MINUTES(2.3,.35) FROM DUAL




SELECT * FROM IFSINFO.PRL_CAPACITY_REPORT ORDER BY REAL_START DESC




SELECT IFSAPP.PRL_CONVERT_100MINUTES(2.30) FROM DUAL
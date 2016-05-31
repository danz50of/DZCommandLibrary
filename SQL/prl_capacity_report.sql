   SELECT a.work_center_no,
            ifsapp.work_center_api.get_average_capacity
                            ('MP',
                             a.work_center_no
                            )
          * 20.5 "MONTHLY_CAPACITY_AT_20.5_DAYS",
          a.order_no, a.part_no, a.operation_no, a.labor_run_factor,
          a.labor_setup_time setup_hours,
          (CASE a.labor_run_factor
              WHEN 0
                 THEN 0
              WHEN NULL
                 THEN 0
              ELSE ifsapp.prl_convert_100minutes (ROUND ((  a.revised_qty_due
                                                          / (a.labor_run_factor
                                                            )
                                                         ),
                                                         2
                                                        )
                                                 )
           END
          ) standard_hours,
          (CASE a.labor_run_factor
              WHEN 0
                 THEN 0
              WHEN NULL
                 THEN 0
              ELSE   a.labor_setup_time
                   + ifsapp.prl_convert_100minutes
                                                 (ROUND ((  a.revised_qty_due
                                                          / (a.labor_run_factor
                                                            )
                                                         ),
                                                         2
                                                        )
                                                 )
           END
          ) total_hours,
          (CASE a.labor_run_factor
              WHEN 0
                 THEN 0
              WHEN NULL
                 THEN 0
              ELSE (CASE ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              a.work_center_no
                                                             )
                       WHEN 0
                          THEN 0
                       WHEN NULL
                          THEN 0
                       ELSE   (  a.labor_setup_time
                               + ifsapp.prl_convert_100minutes
                                                          (  a.revised_qty_due
                                                           / (a.labor_run_factor
                                                             )
                                                          )
                              )
                            / ((  ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              a.work_center_no
                                                             )
                                * 20.5
                               )
                              )
                    END
                   )
           END
          ) percentage_used,
          a.op_start_date, a.op_finish_date, a.revised_qty_due,
          a.qty_complete, b.real_start, b.real_finished,
          TO_CHAR (b.real_start, 'MM') start_month,
          TO_CHAR (b.real_start, 'YYYY') start_year,
          TO_CHAR (b.real_finished, 'MM') finished_month,
          TO_CHAR (b.real_finished, 'YYYY') finished_year,
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
      AND TRUNC (b.real_start, 'YYYY') > TRUNC (SYSDATE - 1366, 'YYYY')
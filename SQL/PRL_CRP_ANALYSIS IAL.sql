   SELECT NVL (mac_op.order_no, 'REQ') ORDER_NO,
          so.part_no,
          so.revised_qty_due,
          mac_op.operation_no,
          TRUNC (mac_op.work_day, 'iw') WORK_WEEK,
          mac_op.work_day,
          (CASE
              WHEN mac_op.work_day < TRUNC (SYSDATE) THEN TRUNC (SYSDATE)
              ELSE mac_op.work_day
           END)
             CONS_WORK_DAY,
          (CASE
              WHEN mac_op.work_day < TRUNC (SYSDATE)
              THEN
                 TRUNC (SYSDATE, 'iw')
              ELSE
                 TRUNC (mac_op.work_day, 'iw')
           END)
             CONS_WORK_WEEK,
          mac_op.work_center_no,
          IFSAPP.work_center_api.get_description ('MP',
                                                  mac_op.work_center_no)
             WC_DESCRIPTION,
          IFSAPP.work_center_api.get_average_capacity ('MP',
                                                       mac_op.work_center_no)
             WC_AVG_CAPACITY,
          (  IFSAPP.work_center_api.get_average_capacity (
                'MP',
                mac_op.work_center_no)
           * 5)
             WC_WEEKLY_CAPACITY,
          mac_op.resource_id,
          mac_op.Hours_loaded,
          (  mac_op.hours_loaded
           / IFSAPP.WORK_CENTER_API.get_average_capacity (
                'MP',
                mac_op.work_center_no))
             PERCENT_USED,
          (  mac_op.hours_loaded
           / (  IFSAPP.WORK_CENTER_API.get_average_capacity (
                   'MP',
                   mac_op.work_center_no)
              * 5))
             WEEKLY_PERCENT_USED,
          so.STATE,
          ifsapp.work_center_api.get_department_no ('MP',
                                                    CAP_ROUT.WORK_CENTER_NO)
             department,
          ifsapp.shop_order_operation_api.get_remaining_qty (
             so.order_no,
             so.release_no,
             SO.SEQUENCE_NO,
             cap_rout.operation_no)
             qty_remainning
     FROM IFSAPP.mach_operation_load_tab mac_op,
          IFSAPP.shop_ord so,
          IFSINFO.prl_capacity_routing cap_rout
    WHERE     so.order_no = mac_op.order_no
          AND cap_rout.part_no = so.part_no
          AND cap_rout.operation_no = mac_op.operation_no
          AND cap_rout.contract = 'MP'
          AND so.contract = 'MP'
          AND mac_op.contract = 'MP'
          AND so.state != 'Closed'
          AND TRUNC (op_start_date, 'dd') >
                 TO_DATE ('1/1/2011', 'mm/dd/yyyy')
   UNION
   SELECT NVL (order_no, 'REQ') ORDER_NO,
          part_no,
          revised_qty_due,
          NULL,
          TRUNC (op_start_date, 'iw') WORK_WEEK,
          TRUNC (op_start_date) WORK_DAY,
          (CASE
              WHEN TRUNC (op_start_date) < TRUNC (SYSDATE)
              THEN
                 TRUNC (SYSDATE)
              ELSE
                 op_start_date
           END)
             CONS_WORK_DAY,
          (CASE
              WHEN op_start_date < TRUNC (SYSDATE) THEN TRUNC (SYSDATE, 'iw')
              ELSE TRUNC (op_start_date, 'iw')
           END)
             CONS_WORK_WEEK,
          work_center_no,
          IFSAPP.work_center_api.get_description ('MP', work_center_no)
             WC_DESCRIPTION,
          IFSAPP.work_center_api.get_average_capacity ('MP', work_center_no)
             WC_AVG_CAPACITY,
          (  IFSAPP.work_center_api.get_average_capacity ('MP',
                                                          work_center_no)
           * 5)
             WC_WEEKLY_CAPACITY,
          NULL,
          (CASE
              WHEN (ABS (op_finish_time - op_start_time) < .02) THEN .02
              ELSE ABS (op_finish_time - op_start_time)
           END)
             HOURS,
          (CASE
              WHEN (ABS (op_finish_time - op_start_time) < .02)
              THEN
                   .02
                 / IFSAPP.WORK_CENTER_API.get_average_capacity (
                      'MP',
                      work_center_no)
              ELSE
                 (  ABS (op_finish_time - op_start_time)
                  / IFSAPP.WORK_CENTER_API.get_average_capacity (
                       'MP',
                       work_center_no))
           END)
             PERCENT_USED,
          (CASE
              WHEN (ABS (op_finish_time - op_start_time) < .02)
              THEN
                   .02
                 / IFSAPP.WORK_CENTER_API.get_average_capacity (
                      'MP',
                      work_center_no)
              ELSE
                 (  ABS (op_finish_time - op_start_time)
                  / IFSAPP.WORK_CENTER_API.get_average_capacity (
                       'MP',
                       work_center_no)
                  * 5)
           END)
             WEEKLY_PERCENT_USED,
          NULL,
          ifsapp.crp_mach_operation2.department dept,
          NULL
     FROM IFSAPP.crp_mach_operation2
    WHERE     order_no IS NULL
          AND TRUNC (op_start_date, 'dd') >
                 TO_DATE ('1/1/2011', 'mm/dd/yyyy')
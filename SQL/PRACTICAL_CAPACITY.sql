   SELECT a.order_no, a.part_no, dated, TRUNC (dated, 'MM') date_by_month,
          TO_CHAR (dated, 'YYYY') YEAR, quantity, transaction_id,
          b.work_center_no, crew_size, labor_class_no, operation_description,
          ifsapp.inventory_part_planning_api.get_std_order_size
                                                      ('MP',
                                                       a.part_no
                                                      ) std_lot_size,
          ifsapp.work_center_api.get_description
                                 ('MP',
                                  b.work_center_no
                                 ) AS work_center_description,
          ifsapp.work_center_api.get_average_capacity
                             ('MP',
                              b.work_center_no
                             ) work_center_daily_avg_capacity,
            ifsapp.work_center_api.get_average_capacity
                                    ('MP',
                                     b.work_center_no
                                    )
          * 20.5 wc_monthly_avg_capacity,
          b.operation_no, b.labor_run_factor, b.labor_setup_time,
          b.mach_run_factor, b.mach_setup_time,
          (CASE b.labor_run_factor
              WHEN 0
                 THEN 0
              WHEN NULL
                 THEN 0
              ELSE (ROUND ((quantity / (b.labor_run_factor)), 2))
           END
          ) labor_run_hours_at_standard,
          (CASE b.labor_run_factor
              WHEN 0
                 THEN b.labor_run_factor + b.labor_setup_time
              WHEN NULL
                 THEN b.labor_run_factor + b.labor_setup_time
              ELSE   b.labor_setup_time
                   + (ROUND ((quantity / (b.labor_run_factor)), 2))
           END
          ) total_labor_hours_at_standard,
            (CASE b.labor_run_factor
                WHEN 0
                   THEN 0
                WHEN NULL
                   THEN 0
                ELSE (CASE ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              b.work_center_no
                                                             )
                         WHEN 0
                            THEN 0
                         WHEN NULL
                            THEN 0
                         ELSE   ((quantity / (b.labor_run_factor)))
                              / ((  ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              b.work_center_no
                                                             )
                                  * 20.5
                                 )
                                )
                      END
                     )
             END
            )
          + (CASE b.labor_setup_time
                WHEN 0
                   THEN 0
                WHEN NULL
                   THEN 0
                ELSE (CASE ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              b.work_center_no
                                                             )
                         WHEN 0
                            THEN 0
                         WHEN NULL
                            THEN 0
                         ELSE (  b.labor_setup_time
                               / ((  ifsapp.work_center_api.get_average_capacity
                                                             ('MP',
                                                              b.work_center_no
                                                             )
                                   * 20.5
                                  )
                                 )
                              )
                      END
                     )
             END
            ) percentage_lbr_at_standard
     FROM ifsapp.inventory_transaction_hist2 a,
          IFSINFO.PRL_CAPACITY_ROUTING B
    WHERE A.part_no = B.part_no AND A.PART_NO = 'ST632'
      AND A.contract = B.contract
      AND b.contract = 'MP'
      --JOIN ifsapp.shop_order_operation b ON a.order_no = b.order_no
      AND A.transaction_code = 'OOREC'




SELECT * FROM IFSINFO.PRL_CAPACITY_ROUTING WHERE PART_NO = 'ST632'



select B.PART_NO, B.CONTRACT, B.ROUTING_REVISION, B.ALTERNATIVE_NO, 
B.CREATE_DATE, B.OBJSTATE, OPERATION_NO, OPERATION_DESCRIPTION, PHASE_IN_DATE,
PHASE_OUT_DATE, EFFICIENCY_FACTOR, MACH_RUN_FACTOR, MACH_SETUP_TIME, LABOR_RUN_FACTOR,
LABOR_SETUP_TIME, CREW_SIZE, WORK_CENTER_NO, LABOR_CLASS_NO
from routing_alternate b, routing_operation c where 
b.part_no = c.part_no and b.contract = c.contract and
B.ALTERNATIVE_NO = C.ALTERNATIVE_NO AND B.ROUTING_REVISION = C.ROUTING_REVISION
AND b.contract = 'MP' 
AND B.ALTERNATIVE_NO = '*'
and B.ROUTING_REVISION = (select (D.ROUTING_REVISION) from routing_alternate d 
where b.part_no = d.part_no and b.contract = d.contract AND D.objstate = 'Buildable' )
AND
AND B.PART_NO = 'ST632'





   SELECT b.part_no,
          b.contract,
          b.routing_revision,
          b.alternative_no,
          b.create_date,
          b.objstate,
          operation_no,
          operation_description,
          phase_in_date,
          phase_out_date,
          efficiency_factor,
          mach_run_factor,
          mach_setup_time,
          labor_run_factor,
          labor_setup_time,
          crew_size,
          work_center_no,
          labor_class_no
   FROM &AO..routing_operation c, &AO..routing_alternate b
   WHERE     c.contract = 'MP'
         AND c.alternative_no = '*'
         AND C.PART_NO = 'ST632'
         AND b.part_no = c.part_no
         AND b.contract = c.contract
         AND b.routing_revision = c.routing_revision
         AND b.alternative_no = c.alternative_no
         AND b.bom_type = 'Manufacturing'
         AND b.create_date =
               (SELECT MAX (d.create_date)
                FROM ifsapp.routing_alternate d
                WHERE     d.part_no = b.part_no
                      AND d.contract = b.contract
                      AND D.ROUTING_REVISION = B.ROUTING_REVISION 
                      AND D.ALTERNATIVE_NO = '*'
                      AND d.bom_type = 'Manufacturing'
                      AND d.objstate = 'Buildable')
        AND PHASE_IN_DATE <= SYSDATE AND (PHASE_OUT_DATE >= SYSDATE OR PHASE_OUT_DATE IS NULL)
        
        
        
        
        
        
        SELECT * FROM IFSINFO.PRL_CAPACITY_ROUTING
        
        
        
        
        
        
        
        select * from ifsinfo.prl_capacity_oorecstd
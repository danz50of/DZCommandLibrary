   SELECT   b.part_no,
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
     FROM   IFSAPP.routing_operation c, IFSAPP.routing_alternate b
    WHERE       c.contract = 'MP'
            AND c.alternative_no = '*'
            AND b.part_no = c.part_no
            AND B.PART_NO IN ('095-0663-2',
'630-0019',
'046-0129',
'640-0017',
'580-0227',
'095-0595',
'095-0597',
'630-0018',
'095-0594',
'640-0005',
'095-0576',
'095-0570',
'095-0660-2',
'095-0664',
'095-0583-1',
'095-0583-2',
'640-0015',
'640-0016',
'630-0020',
'580-0231',
'095-0582',
'095-0593',
'095-0596',
'095-0660-1',
'095-0661',
'095-0663-1',
'580-0230',
'580-1231',
'580-0229',
'580-0332',
'630-0021',
'640-0001',
'046-0230',
'095-0322',
'095-0979',
'130-0421',
'154-0115',
'200-0721',
'200-0828',
'200-0861',
'201-0074',
'201-0078',
'201-0109',
'201-0589',
'201-0600',
'201-0743')
            AND b.contract = c.contract
            AND b.routing_revision = c.routing_revision
            AND b.alternative_no = c.alternative_no
            AND b.bom_type = 'Manufacturing'
            AND b.create_date =
                  (SELECT   MAX (d.create_date)
                     FROM   IFSAPP.routing_alternate d
                    WHERE       d.part_no = b.part_no
                            AND d.contract = b.contract
                            AND D.ROUTING_REVISION = B.ROUTING_REVISION
                            AND D.ALTERNATIVE_NO = '*'
                            AND d.bom_type = 'Manufacturing'
                            AND d.objstate = 'Buildable')
            AND PHASE_IN_DATE <= SYSDATE
            AND (PHASE_OUT_DATE >= SYSDATE OR PHASE_OUT_DATE IS NULL)
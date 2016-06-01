   SELECT   b.part_no,
            b.order_no,
            b.state,
            (SELECT   SUM (g.qty_onhand - g.qty_reserved)
               FROM   ifsapp.inventory_part_in_stock g
              WHERE       b.part_no = g.part_no
                      AND b.contract = g.contract
                      AND g.availability_control_id IS NULL
                      AND g.location_no NOT IN
                               (SELECT   location_no
                                  FROM   ifsinfo.return_locations))
               tot_avail,
            b.revised_qty_due,
            b.qty_complete,
            c.safety_stock,
            ROUND (
               (  a.mon_31
                + a.mon_32
                + a.mon_33
                + a.mon_34
                + a.mon_35
                + a.mon_36)
               / 6,
               2
            )
               Mth_Avg,
            e.type_designation,
            (case when f.alt_lbr_run is not null then f.alt_lbr_run
                  else f.pri_lbr_run
             end) labor_run,
            (case when f.alt_crew_size is not null then f.alt_crew_size
                  else f.pri_crew_size
             end) crew_size,
            f.phase_out_date,
            (SELECT   SUM (h.actual_demand)
               FROM   ifsapp.level_1_forecast h
              WHERE       h.part_no = b.part_no
                      AND h.contract = b.contract
                      AND MS_DATE <= (sysdate + 14)
                      AND ms_set = 1)
               ACTUAL_DEMAND,
            b.note_text
     FROM   ifsapp.shop_ord b,
            ifsapp.inventory_part_planning c,
            ifsinfo.run_rate_3year a,
            ifsapp.inventory_part e,
            IFSINFO.PRL_ROUTING_OP_ALT_IAL f
    WHERE       a.contract = c.contract
            AND b.contract = 'MP'
            AND a.contract = 'MP'
            AND c.contract = 'MP'
            AND e.contract = 'MP'
            AND f.contract = 'MP'
            AND UPPER (b.STATE) <> UPPER ('CLOSED')
            AND b.part_no = c.part_no
            AND b.part_no = a.part_no
            AND b.part_no = e.part_no
            AND b.part_no = f.part_no
            AND f.phase_out_date IS NULL
   SELECT a.order_no, a.part_no, dated, TRUNC (dated, 'MM') date_by_month,
          TO_CHAR (dated, 'YYYY') YEAR, quantity, transaction_id,
          b.work_center_no, crew_size, labor_class_no, operation_description, 
          B.LABOR_RUN_FACTOR, B.LABOR_SETUP_TIME
     FROM ifsapp.inventory_transaction_hist2 a,
          ifsinfo.PRL_CAPACITY_ROUTING_IAL B
    WHERE a.contract = 'MP'
      and A.transaction = 'OOREC'
      and trunc(a.dated) > to_date('12/31/2008','MM/DD/YYYY') 
      and b.part_no = a.part_no
      and b.contract = a.contract

select
'Open'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.active_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No') and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('Material') 
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
  union all
  select
  'Open'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.active_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No')  and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('External') 
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
  union all
  select
  'Open'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.active_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No')  and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('Personnel') and b.amount > 0
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
union all
select
  'Closed'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.historical_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No') and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('Material') 
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
  union all
  select
  'Closed'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.historical_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No') and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('External') 
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
  union all
  select
  'Closed'  report_type,
  a.err_descr E_C_N_No,
  A.WO_NO WO_Number,
  b.work_order_cost_type,
  sum(b.amount) Amount
  from
  ifsapp.historical_separate a,
  ifsapp.work_order_coding b
  where
  a.wo_no = b.wo_no(+)
  and upper(a.err_descr) = upper('&Enter_E_C_N_No') and a.wo_no like ('&Enter_W_O_No') and upper(b.WORK_ORDER_COST_TYPE) = upper('Personnel') and b.amount > 0  
  group by
  a.err_descr,
  A.WO_NO,
  b.work_order_cost_type 
SELECT PART_NO, PART_DESCRIPTION, OP_NO, OP_DESCRIPTION, total_qty_completed, total_hours_worked, actual_run, standard_run, run_variance 
from(
SELECT
a.part_no,
b.description part_description,
a.op_no,
c.description op_description,
sum(A.QTY_COMPLETED) Total_Qty_Completed,
sum(A.WORK_HOURS) Total_Hours_Worked,
round(sum(a.qty_completed) / sum(a.work_hours)) Actual_Run,
A.STANDARD_RUN,
round(sum(a.qty_completed) / sum(a.work_hours) / a.standard_run *100 ) Run_Variance
FROM IFSINFO.LABOR_TOTALS_BY_PART_IAL A,
  ifsapp.inventory_part b,
  ifsapp.work_center c
WHERE  b.contract = 'MP' and c.contract = 'MP' and a.part_no = b.part_no and a.work_center_no = c.work_center_no and c.department_no = '&Enter_Department' and TRUNC(a.ACCOUNT_DATE,'DD') BETWEEN
TO_DATE('&FROM_DATE','MM/DD/YYYY') AND
TO_DATE('&TO_DATE','MM/DD/YYYY') AND a.PART_NO <> 'INTERRUPT' 
group by
  a.part_no,
  b.description,
  a.op_no,
  c.description,
  a.standard_run)
where nvl(run_variance,0) < 90





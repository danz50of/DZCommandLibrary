SELECT a.emp_no
               employee_id,
           IFSAPP.COMPANY_PERS_API.GET_NAME ('11', A.EMP_NO)
               NAME,
           a.account_date,
           TO_CHAR (a.account_date, 'DAY')
               day,
           IFSAPP.COMPANY_ORG_API.Get_Org_Name ('11', a.department)
               Department,
           a.department
               Code,
           a.clock_hours,
           NVL (b.OPERATION_HOURS, 0)
               operation_hours,
           NVL (a.clock_hours - b.OPERATION_HOURS, 0)
               difference,
           CASE
               WHEN c.job_id = 'DIRECT'
               THEN
                   NVL (c.job_grade, .90) * a.clock_hours
               WHEN c.job_id = 'IN-DIRECT'
               THEN
                   0
               ELSE
                   a.clock_hours * .90
           END
               goal,
           CASE
               WHEN c.job_id = 'DIRECT'
               THEN
                   ROUND (
                         NVL (b.OPERATION_HOURS, 0)
                       / (NVL (c.job_grade, .90) * a.clock_hours),
                       2)
               WHEN c.job_id = 'IN-DIRECT'
               THEN
                   0
               ELSE
                   ROUND (
                         NVL (b.OPERATION_HOURS, 0)
                       / (NVL (c.job_grade, .90) * a.clock_hours+.001),
                       2)
           END
               wip,
           NVL (c.job_id, 'No Job Rec')
               job_id
      FROM ifsinfo.clock_hrs_emp  a,
           ifsinfo.op_hrs_emp     b,
           IFSAPP.emp_job_assign  c
     WHERE     a.emp_no = b.emp_no(+)
           AND a.account_date = b.account_date(+)
           AND a.emp_no = c.emp_no(+)
           AND c.valid_to(+) > TRUNC (SYSDATE)
           AND TO_CHAR (a.account_date, 'YYYY') >= '2015'
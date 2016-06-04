select 'BUDGET' T_TYPE, COMPANY, BUDGET_YEAR, BUDGET_VERSION, BUDGET_PERIOD, ACCOUNT, IFSAPP.ACCOUNT_API.GET_DESCRIPTION(COMPANY, ACCOUNT, 'EN') ACCOUNT_DESCRIPTION, CODE_B, IFSAPP.CODE_B_API.GET_DESCRIPTION(COMPANY, CODE_B, 'EN') DEPARTMENT_NAME, CODE_C PROD_LINE,AMOUNT
from ifsapp.budget_period_amount1 where budget_VERSION = 'FORCAST'
UNION
select 'ACTUAL' T_TYPE, COMPANY, ACCOUNTING_YEAR, NULL BUDGET_VERSION, ACCOUNTING_PERIOD, ACCOUNT,  IFSAPP.ACCOUNT_API.GET_DESCRIPTION(COMPANY, ACCOUNT, 'EN') ACCOUNT_DESCRIPTION, CODE_B, IFSAPP.CODE_B_API.GET_DESCRIPTION(COMPANY, CODE_B, 'EN') DEPARTMENT_NAME, CODE_C PROD_LINE, AMOUNT_BALANCE AMOUNT
from ifsapp.accounting_balance_auth where accounting_year = 2013



select 'ACTUAL' T_TYPE, COMPANY, ACCOUNTING_YEAR, NULL BUDGET_VERSION, ACCOUNTING_PERIOD, ACCOUNT,  IFSAPP.ACCOUNT_API.GET_DESCRIPTION(COMPANY, ACCOUNT, 'EN') ACCOUNT_DESCRIPTION, CODE_B, IFSAPP.CODE_B_API.GET_DESCRIPTION(COMPANY, CODE_B, 'EN') DEPARTMENT_NAME, CODE_C PROD_LINE, AMOUNT_BALANCE AMOUNT
from IFSAPP.ACCOUNTING_BALANCE_HOLD
where accounting_year = 2013




select * from xdc.xtms_task_detail





select a.order_no,
       a.pick_list_no,
       c.create_date,
       c.source created_by,
       nvl(to_char(b.xttd_task_id),'NO RADLEY TASK') Radley_Task_Id,
       b.xttd_task_type Task_Type,
       b.xttd_serial Part,
       b.xttd_descriptive_text Task_desc,
       nvl(b.xttd_status,'NO RADLEY TASK') Status,
       b.xttd_last_status_date status_date,
       b.xttd_update_user Radley_Admin,
       b.xttd_earliest_start earliest_start
       from ifsinfo.no_report_picked_distinct a, xdc.xtms_task_detail b, 
       customer_order_pick_list c
        where  a.contract = 'MP' and 
              a.order_no || '-' || a.pick_list_no  =    b.xttd_reference(+)  and a.order_no = c.order_no and a.pick_list_no = c.pick_list_no
              --and trunc(B.XTTD_EARLIEST_START, 'dd') <= trunc(sysdate, 'dd')
              order by a.order_no,a.pick_list_no,b.xttd_task_id, b.xttd_last_status_date
              
              
              
       
              
              select trunc(create_date,'hh24') from customer_order_pick_list
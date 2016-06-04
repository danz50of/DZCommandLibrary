CREATE OR REPLACE FUNCTION Get_Labor_Run_Factor (part_no_ in varchar2, contract_ in varchar2,
op_no_ in varchar2, order_no_ in varchar2, account_date_ in date)
return number
IS
standard number(9,4);
CURSOR Get_labor_factor IS
select labor_run_factor from ifsapp.routing_operation c where c.part_no = part_no_
and c.contract = contract_ and c.operation_no = op_no_ 
and phase_in_date <= trunc(account_date_, 'DD')
and nvl(phase_out_date, trunc(sysdate, 'DD')) >= trunc(account_date_, 'DD')
and c.alternative_no = (select so.routing_alternative from ifsapp.shop_ord so
where so.order_no = order_no_);
BEGIN
OPEN Get_labor_factor;
FETCH Get_labor_factor into standard;
CLOSE Get_labor_factor;
RETURN standard;
END;


--grant execute on Get_Labor_Run_Factor to REQUESTIONER;
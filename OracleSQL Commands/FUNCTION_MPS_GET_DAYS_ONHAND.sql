CREATE OR REPLACE FUNCTION MPS_GET_DAYS_ONHAND( 
part_no_ in varchar2) return number
is 
on_hand_ number;
avg_daily_usage_ number;
CURSOR Get_Days is 
select on_hand 
from IFSINFO.PRL_MPS_ONHAND_ANALYSIS
WHERE PART_NO = part_no_;
CURSOR Get_Avg_Daily_Usage is
select avg_daily_usage
from IFSINFO.PRL_MPS_ONHAND_ANALYSIS
Where part_no = Part_no_;
Begin
open Get_Days;
fetch Get_Days into on_hand_;
close Get_Days;
open Get_Avg_Daily_Usage;
fetch Get_Avg_Daily_Usage into avg_daily_usage_;
close Get_Avg_Daily_Usage;
return (on_hand_ / avg_daily_usage_);
end; 

grant execute on MPS_GET_DAYS_ONHAND to requisitioner;
CREATE OR REPLACE FUNCTION IFSAPP.MPS_GET_PROJ_AVAIL(
part_no_ in varchar2, ms_date_ in date) return number
is
on_hand_ number;
CURSOR Get_proj_avail is
select proj_avail
from ifsapp.level_1_forecast
where part_no = part_no_
and ms_date = ms_date_
and ms_set = 1;
Begin
open Get_proj_avail;
fetch Get_proj_avail into on_hand_;
close Get_proj_avail;
return (on_hand_);
end;
 

grant execute on ifsapp.MPS_GET_PROJ_avail to ifsinfo with grant option;



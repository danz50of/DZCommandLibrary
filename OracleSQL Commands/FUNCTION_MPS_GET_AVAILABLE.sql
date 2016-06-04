CREATE OR REPLACE FUNCTION MPS_GET_AVAILABLE( 
part_no_ in varchar2) return number
is 
on_hand_ number;
CURSOR Get_Available is 
select on_hand 
from IFSINFO.PRL_MPS_ONHAND_ANALYSIS
WHERE PART_NO = part_no_;
Begin
open Get_Available;
fetch Get_Available into on_hand_;
close Get_Available;
return (on_hand_);
end; 

grant execute on MPS_GET_AVAILABLE to REQUESTIONER;

select * from ifsinfo.prl_mps_onhand_analysis where part_no = 'CMJ500'
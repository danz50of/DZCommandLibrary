CREATE OR REPLACE FUNCTION IFSAPP.GET_INV_CHAR(
part_no_ in varchar2, contract_ in varchar2, code_ in VARCHAR2) return varchar2
is
attr_value_ varchar2(60);
CURSOR Get_attr_value is
select attr_value
from ifsapp.inventory_part_char_all
where part_no = part_no_
and contract = contract_
and characteristic_code = code_;
Begin
open Get_attr_value;
fetch Get_attr_value into attr_value_;
close Get_attr_value;
return (attr_value_);
end;
 

grant execute on ifsapp.get_inv_char_upc to requestioner;



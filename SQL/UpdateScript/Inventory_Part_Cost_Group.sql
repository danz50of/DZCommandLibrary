--As of 9/3/2010
--Run first pass for everything, setting the value to COMP
--Run Second pass for = FG, setting the value to SUAT

declare

  Cursor GetPart is
  SELECT part_no ,
         part_status,
         part_cost_group_id,
          objid,
         objversion     
  FROM    inventory_part   where contract = 'MP' and part_status <> 'O' 
  AND accounting_group like 'FG%'--  and PART_NO = 'PM20'
  ;
  


   ErrMess_          varchar2(200);
   result_         varchar2(2000);
   attr_           varchar2(2000);
   part_cost_group_id_            varchar2(20);
   part_no_              varchar2(35);
   
    

    begin
    For rec in GetPart   LOOP

    --                                        --
    begin

        result_ := NULL;
        attr_   := NULL;
        part_no_ := rec.part_no;
        part_cost_group_id_   := 'SUAT';
        
        Client_SYS.Add_To_Attr('PART_COST_GROUP_ID',part_cost_group_id_,attr_);
        

    INVENTORY_PART_API.MODIFY__(
      result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
    commit;
    exception
    when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
    dbms_output.put_line('Part:' ||'  ' || part_no_ ||'Error Message:'  || ErrMess_);
    end;
        END LOOP;
      commit;  
end;



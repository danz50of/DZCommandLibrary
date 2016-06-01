--1/28/2015
--Update MPS Level1 Part field: shop_order_proposal_flag_db
--Set Value to 'H', to create reqs for entire horizon

declare

  Cursor level1 is
    select part_no, 
           contract,
           shop_order_proposal_flag_db,
           ms_active_flag,
           objid,
           objversion
    from ifsapp.level_1_part
    where contract = 'MP'
    and MS_Active_flag_db = 'A'
  ;
  Cursor i_planning is
      select part_no, 
           contract,
           MRP_ORDER_CODE,
           objid,
           objversion
    from ifsapp.inventory_part_planning
    where contract = 'MP'
    and MRP_ORDER_CODE = 'P'
  ;
   ErrMess_        varchar2(200);
   result_         varchar2(2000);
   attr_           varchar2(2000);
   shop_order_proposal_flag_            varchar2(1);
   part_no_              varchar2(35);
   mrp_order_code_      varchar2(1);
    

    begin
    For rec in level1   LOOP

    --                                        --
    begin

        result_ := NULL;
        attr_   := NULL;
        part_no_ := rec.part_no;
        shop_order_proposal_flag_ := 'H';
        
        Client_SYS.Add_To_Attr('SHOP_ORDER_PROPOSAL_FLAG_DB',shop_order_proposal_flag_,attr_);
        

    LEVEL_1_PART_API.MODIFY__(
      result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
    commit;
    dbms_output.put_line('Part:' ||'  ' || part_no_ ||'Error Message:'  || ErrMess_);
    exception
    when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
    dbms_output.put_line('Part:' ||'  ' || part_no_ ||'Error Message:'  || ErrMess_);
    end;
        END LOOP;
      commit;  
    For rec in i_planning     loop
    
    begin
    
    result_ := null;
    attr_ := null;
    part_no_ := rec.part_no;
    mrp_order_code_ := 'A';
        Client_SYS.Add_To_Attr('MRP_ORDER_CODE','A',attr_);
        

    inventory_part_planning_api.MODIFY__(
      result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
    commit;
    dbms_output.put_line('Part:' ||'  ' || part_no_ ||'Error Message:'  || ErrMess_);
    exception
    when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
    dbms_output.put_line('Part:' ||'  ' || part_no_ ||'Error Message:'  || ErrMess_);
    end;
        END LOOP;
      commit;  
end;



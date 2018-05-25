declare
  Cursor cm_update is
      select identity, 
           company,
           credit_analyst_code,
           objid,
           objversion
    from ifsapp.customer_credit_info_cust
    where company = 31
  ;
   ErrMess_        varchar2(200);
   result_         varchar2(2000);
   attr_           varchar2(2000);
   identity_            varchar2(20 byte);
   credit_analyst_code_ varchar2(20 byte);
begin
    For rec in cm_update     loop
    
    begin
    
    result_ := null;
    attr_ := null;
    identity_ := rec.identity;
    credit_analyst_code_ := 'UKCM2';
        Client_SYS.Add_To_Attr('CREDIT_ANALYST_CODE','UKCM2',attr_);
        

    customer_credit_info_api.MODIFY__(
      result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
    commit;
    dbms_output.put_line('identity:' ||'  ' || identity_ ||'Error Message:'  || ErrMess_);
    exception
    when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
    dbms_output.put_line('Identity:' ||'  ' || identity_ ||'Error Message:'  || ErrMess_);
    end;
        END LOOP;
      commit;  
end;
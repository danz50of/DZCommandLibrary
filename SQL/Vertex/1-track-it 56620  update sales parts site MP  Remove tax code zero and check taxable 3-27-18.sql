-- set serveroutput   off  --
-- set serveroutput on size 1000000  --
--                                        --   
-- 
--   

declare

  Cursor GetSalesPart is
  SELECT CATALOG_NO,
         FEE_CODE,
         TAXABLE_DB,
         inventory_part_api.get_part_status(contract,part_no) ip_status,
         activeind  sp_status,
         OBJID,
       OBJVERSION  
  FROM SALES_part where    contract = 'MP';

  ErrMess_        varchar2(200);
  result_     varchar2(2000);
  attr_       varchar2(2000);
  part_val_             varchar2(100);
  ip_status_             varchar2(10);
  sp_status_             varchar2(100);
  fee_code_             varchar2(2000);
  taxable_db_           varchar2(2000);  

  begin
  For rec in GetSalesPart LOOP

  --   --
  begin

        result_ := NULL;
        attr_   := NULL;
        fee_code_ := null;
        taxable_db_ := 'Use sales tax';
        part_val_   := rec.catalog_no;
        ip_status_  := rec.ip_status;
        sp_status_  := rec.sp_status;
       
        
        Client_SYS.Add_To_Attr('FEE_CODE',fee_code_,attr_);
        Client_SYS.Add_To_Attr('TAXABLE_DB',taxable_db_,attr_);

  SALES_PART_API.MODIFY__(
    result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
  commit;
  exception
  when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
        dbms_output.enable(1000000);
        dbms_output.put_line('Part: ' ||   part_val_ || '|' ||'IP-Status: ' ||   ip_status_ || '|' || 'SP-Status:  ' || sp_status_ || '|'  || 'Error Message:'  || ErrMess_);
  end;
        END LOOP;
end;


--     --
--     --
--  set documents to approved using package DOC_ISSUE_API.Promote_To_Approved
--  this code will update all revisions of a document.
--	 

declare

  Cursor GetDocument is
  SELECT doc_no,
	OBJID,
	   DOC_CLASS,
       OBJVERSION,
	   DOC_REV,
	   REV_NO
  from doc_issue_reference 
  where
--  doc_no = 'ASY009-9002'
  objstate = 'Preliminary'; 
  --and objstate in ('Preliminary','Approval In Progress');

  ErrMess_      	varchar2(200);
  result_ 		varchar2(2000);
  attr_   		varchar2(2000);
  doc_val              varchar2(2000);  

	begin
	For rec in GetDocument LOOP

	--  update documents to approved --
	begin

        result_ := NULL;
        attr_   := NULL;
       
        
        doc_val       := rec.doc_no;
--		DOC_ISSUE_API.Set_Group_Access__(
--		rec.doc_no
--		, rec.DOC_CLASS
--		, rec.DOC_REV
--		, rec.REV_NO);		
        DOC_ISSUE_API.Promote_To_Approved__(
	  result_
        , rec.objid
        , rec.objversion
        , attr_
        , 'DO');
	commit;
	exception
	when others then
        ErrMess_ := SUBSTR(sqlerrm,1,150);
	dbms_output.put_line('Document:|' || doc_val ||'|Error Message:'  || ErrMess_);
	end;
        END LOOP;
end;



--CREATE OR REPLACE PROCEDURE INVENTORY_FIXINVENTORYPART
DECLARE
	outfile UTL_FILE.file_type;	 
	so_in_part_no varchar2(25);	
	so_location varchar2(35);	
	ws_inventory_reserved number(10);
	ws_shop_order_assign number(10);
	ws_customer_order_assign number(10);
	ws_order_total number(10);
	ws_adjust_total number(10);
	stats timestamp;
	CURSOR INVENTORY_ADJUST IS
	    SELECT INVENTORY_PART_NUMBER, PART_LOCATION, SET_RESERVED_TO
		FROM IFSINFO.PRL_INV_ADJ
		WHERE ADJUST = 'Y';  		   
	 v_prl  INVENTORY_ADJUST%rowtype;
BEGIN
	 outfile := UTL_FILE.fopen('C:\EDI\PLSQL\','PLSQLREP.TXT','w',32699);
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
	 UTL_FILE.PUT(OUTFILE, 'START TIME: ' || stats || '|');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
	 UTL_FILE.PUT(outfile, 'Part Number|Location Corrected|Amount Adjusted');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
	 OPEN INVENTORY_ADJUST;
	 LOOP                   -- Read each item from inventory table 
	 	 FETCH INVENTORY_ADJUST INTO v_prl;
		 	   exit when INVENTORY_ADJUST%notfound;
		 so_in_part_no := v_prl.INVENTORY_PART_NUMBER;
		 so_location := v_prl.PART_LOCATION;
		 UPDATE IFSAPP.INVENTORY_PART_IN_STOCK_TAB
		 		SET QTY_RESERVED = v_prl.SET_RESERVED_TO
			    WHERE PART_NO = v_prl.INVENTORY_PART_NUMBER 
				AND LOCATION_NO = v_prl.PART_LOCATION;
		 UPDATE IFSINFO.PRL_PART_REVIEW
		 		SET CORRECTED = 'Y', DATE_CORRECTED = SYSTIMESTAMP
		 WHERE INVENTORY_PART_NUMBER = v_prl.INVENTORY_PART_NUMBER
		       AND IGNORED = 'N' AND CORRECTED = 'N';
	 	 UTL_FILE.PUT(outfile, v_prl.INVENTORY_PART_NUMBER || '|' || v_prl.PART_LOCATION || '|' ||v_prl.SET_RESERVED_TO);
		 UTL_FILE.NEW_LINE(OUTFILE,1);
	 END LOOP;
	 close INVENTORY_ADJUST;
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
 	 UTL_FILE.PUT(OUTFILE, 'END TIME: ' || stats);
	 UTL_FILE.fclose(outfile);
--	 COMMIT;
ROLLBACK;
END;
--END; 

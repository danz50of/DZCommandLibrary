--CREATE OR REPLACE PROCEDURE INVENTORY_FIXINVENTORYPART
DECLARE
	outfile UTL_FILE.file_type;	 
	so_in_part_no varchar2(25);	
	so_in_contract varchar2(5);	
	ws_inventory_reserved number(10);
	ws_shop_order_assign number(10);
	ws_customer_order_assign number(10);
	ws_order_total number(10);
	ws_adjust_total number(10);
	stats timestamp;
	CURSOR PRL_PART_REVIEW_CRS IS
	   	   SELECT USERNAME AS C_UNAME, RUN_DATE_TIME AS C_RUN_DATE, INVENTORY_PART_NUMBER AS C_PART_NO, 
		   NUMBER_RESERVED AS C_NUM_RESERVED, SHOP_ORD_RESERVED AS C_SHOP_RESERVED, CUST_ORD_RESERVED AS C_CUST_RESERVED 
		   		  FROM IFSINFO.PRL_PART_REVIEW 
				  WHERE (IGNORED = 'N' AND CORRECTED = 'N');
    CURSOR INVENTORY_CORRECTION IS
	       SELECT PART_NO AS I_PART_NO, LOCATION_NO AS I_LOC_NO, QTY_RESERVED AS I_RESERVED
		   FROM INVENTORY_PART_IN_STOCK_TAB
		   WHERE PART_NO = so_in_part_no
		   AND CONTRACT = 'MP'
		   AND QTY_RESERVED > 0;  		   
	v_prl  PRL_PART_REVIEW_CRS%rowtype;
	v_icor INVENTORY_CORRECTION%rowtype;
BEGIN
	 outfile := UTL_FILE.fopen('C:\EDI\PLSQL\','PLSQLREP.TXT','w',32699);
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
	 UTL_FILE.PUT(OUTFILE, 'START TIME: ' || stats || '|');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
	 UTL_FILE.PUT(outfile, 'Part Number|Location Corrected|Amount Adjusted');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
	 OPEN PRL_PART_REVIEW_CRS;
	 LOOP                   -- Read each item from inventory table 
	 	 FETCH PRL_PART_REVIEW_CRS INTO v_prl;
		 	   exit when PRL_PART_REVIEW_CRS%notfound;
		 so_in_part_no := v_prl.C_PART_NO;
		 ws_inventory_reserved := v_prl.C_NUM_RESERVED;
		 ws_shop_order_assign := v_prl.C_SHOP_RESERVED;
		 ws_customer_order_assign := v_prl.C_CUST_RESERVED;
		 ws_order_total := 0;
         ws_order_total := ws_inventory_reserved - ws_shop_order_assign - ws_customer_order_assign;
		 OPEN INVENTORY_CORRECTION;
		 LOOP
		 	 FETCH INVENTORY_CORRECTION INTO v_icor;
		 	 	   exit when INVENTORY_CORRECTION%notfound;
		     IF v_icor.I_RESERVED >= ws_order_total THEN
			 	UPDATE INVENTORY_PART_IN_STOCK_TAB SET QTY_RESERVED = (QTY_RESERVED - ws_order_total)
					   where PART_NO = v_icor.I_PART_NO and LOCATION_NO = v_icor.I_LOC_NO;
			    UTL_FILE.PUT(outfile, so_in_part_no || '|' || v_icor.I_LOC_NO || '|' || ws_order_total);
				UTL_FILE.NEW_LINE(OUTFILE,1);
			 ELSE
					   ws_adjust_total := ws_order_total - v_icor.I_RESERVED;
					   UPDATE INVENTORY_PART_IN_STOCK_TAB SET QTY_RESERVED = (0)
					   		  where PART_NO = v_icor.I_PART_NO and LOCATION_NO = v_icor.I_LOC_NO;
			    	   		  UTL_FILE.PUT(outfile, so_in_part_no || '|' || v_icor.I_LOC_NO || '|' || v_icor.I_RESERVED || '|ELSE');
				       ws_order_total := ws_adjust_total;
					   UTL_FILE.NEW_LINE(OUTFILE,1);
			 END IF;
		 END LOOP;
		 CLOSE INVENTORY_CORRECTION;
    	 UPDATE IFSINFO.PRL_PART_REVIEW SET CORRECTED = 'Y', DATE_CORRECTED = SYSTIMESTAMP
		 		WHERE INVENTORY_PART_NUMBER = v_icor.I_PART_NO;
	 END LOOP;
	 close PRL_PART_REVIEW_CRS;
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
 	 UTL_FILE.PUT(OUTFILE, 'END TIME: ' || stats);
	 UTL_FILE.fclose(outfile);
	 COMMIT;
--ROLLBACK;
END;
--END; 

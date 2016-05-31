--create or replace procedure INVENTORY_FINDINVENTORYPART as
--begin
DECLARE
	outfile UTL_FILE.file_type;
	so_in_part_no varchar2(25);
	so_in_contract varchar2(5);
	ws_inventory_reserved number(10);
	ws_shop_order_assign number(10);
	ws_customer_order_assign number(10);
	ws_order_total number(10);
	stats timestamp;
	CURSOR IPIS_INVENTORY IS
		   SELECT IP.PART_NO as C_PART_NO, IP.CONTRACT AS C_CONTRACT, SUM(IPIS.QTY_RESERVED) AS C_RESERVED 
		   		  FROM inventory_part_tab IP
		   		  JOIN INVENTORY_PART_IN_STOCK_TAB IPIS 
	 	   		  ON IP.PART_NO = IPIS.PART_NO AND IP.CONTRACT = IPIS.CONTRACT
		   where IP.contract = 'MP'
--   		   AND IP.ASSET_CLASS = 'R' 
--		   AND IP.ASSET_CLASS = 'R'
--   		   AND IP.PART_STATUS IN ('U','A','E') 
		   AND IPIS.QTY_RESERVED > 0
		   AND ip.PART_NO in ('095-8184-1') 
		   GROUP BY IP.PART_NO, IP.CONTRACT
		   ;
	CURSOR SO_SHOP_ORDER IS
		   SELECT SO.QTY_ASSIGNED as D_QTY_ASSIGNED FROM SHOP_MATERIAL_ALLOC_TAB SO 
    	   WHERE SO.PART_NO = so_in_part_no AND
		   SO.CONTRACT = so_in_contract AND
		   SO.ROWSTATE = 'Reserved'
		   ;
	CURSOR CO_CUSTOMER_ORDER IS
		   SELECT OL.QTY_ASSIGNED AS E_QTY_ASSIGNED FROM CUSTOMER_ORDER_LINE_TAB OL
    	   WHERE OL.PART_NO = so_in_part_no
		   and OL.CATALOG_NO = so_in_part_no
		   AND OL.CONTRACT = so_in_contract
--		   AND OL.QTY_ASSIGNED > 0
		   ;
	CURSOR PRL_PART_UPDATE IS
	       SELECT INVENTORY_PART_NUMBER, CORRECTED, IGNORED, DATE_IGNORED
		   FROM IFSINFO.PRL_PART_REVIEW
		   WHERE CORRECTED = 'N' AND IGNORED = 'N'
		   for update of ignored, date_ignored;
	v_prl_part PRL_PART_UPDATE%rowtype;   	   
	v_ipis ipis_inventory%rowtype;
	v_so   so_shop_order%rowtype;
	v_co   co_customer_order%rowtype;
-- 
-- Begin Procedure Define
--  
	PROCEDURE INVENTORY_REPORTLOCATIONS IS 
	BEGIN
		 DECLARE
		     in_part_no varchar2(25);
			 	CURSOR PRL_PART_UPDATE IS
					   SELECT INVENTORY_PART_NUMBER
					   FROM IFSINFO.PRL_PART_REVIEW
		   			   WHERE CORRECTED = 'N' AND IGNORED = 'N';
    			CURSOR INV_LOCATION IS
	 	   			   SELECT LOCATION_NO, QTY_RESERVED
		   			   FROM IFSAPP.INVENTORY_PART_IN_STOCK_TAB
		   			   WHERE PART_NO = in_part_no;
			 v_prl_part PRL_PART_UPDATE%rowtype; 
			 v_inv_location INV_LOCATION%rowtype;  	   
		BEGIN
     		 DELETE FROM IFSINFO.PRL_INV_ADJ;
     		 OPEN PRL_PART_UPDATE;
	 	LOOP
	 	FETCH PRL_PART_UPDATE into v_prl_part;
		 	   exit when PRL_PART_UPDATE%notfound;
	     in_part_no := v_prl_part.INVENTORY_PART_NUMBER;
		 OPEN INV_LOCATION;
		 LOOP
		 	 FETCH INV_LOCATION INTO v_inv_location;
			   exit when INV_LOCATION%notfound;
			   INSERT INTO IFSINFO.PRL_INV_ADJ(INVENTORY_PART_NUMBER, PART_LOCATION, QTY_RESERVED, ADJUST, USERNAME)
		 		VALUES(v_prl_part.INVENTORY_PART_NUMBER, v_inv_location.LOCATION_NO, v_inv_location.QTY_RESERVED ,'N',USER);
		 END LOOP;
	 	 CLOSE INV_LOCATION; 
	 END LOOP;
	 CLOSE PRL_PART_UPDATE;
	 COMMIT;
	END;
	END;
--  begin body of logic 
BEGIN
     OPEN PRL_PART_UPDATE;
	 LOOP
	 	 FETCH PRL_PART_UPDATE into v_prl_part;
		 	   exit when PRL_PART_UPDATE%notfound;
		 --FINISH CODE FOR UPDATE OF TABLE 
		 update ifsinfo.prl_part_review
		 set ignored = 'Y', DATE_IGNORED = SYSTIMESTAMP
		 where INVENTORY_PART_NUMBER = v_prl_part.INVENTORY_PART_NUMBER;
	 END LOOP;
	 CLOSE PRL_PART_UPDATE;
	 COMMIT;
	 outfile := UTL_FILE.fopen('C:\EDI\PLSQL\','PLSQLOUT.TXT','w',32699);
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
	 UTL_FILE.PUT(OUTFILE, 'START TIME: ' || stats || '|');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
     UTL_FILE.PUT(outfile, 'Inventory_Part_NO|Inventory|Shop Order|CO|Difference');
	 UTL_FILE.NEW_LINE(OUTFILE,1);
	 OPEN IPIS_INVENTORY;
	 LOOP                   -- Read each item from inventory table 
	 	 FETCH IPIS_INVENTORY INTO v_ipis;
		 	   exit when IPIS_INVENTORY%notfound;
		 so_in_part_no := v_ipis.C_PART_NO;
		 so_in_contract := v_ipis.C_CONTRACT;
		 ws_inventory_reserved := v_ipis.C_RESERVED;
		 ws_shop_order_assign := 0;
		 ws_customer_order_assign := 0;
		 ws_order_total := 0;
		 OPEN SO_SHOP_ORDER;
		 LOOP               -- Match inventory item to shop orders 
		 	 FETCH SO_SHOP_ORDER INTO v_so;
			 	   EXIT WHEN SO_SHOP_ORDER%NOTFOUND;
			 ws_shop_order_assign := ws_shop_order_assign + v_so.D_QTY_ASSIGNED;
         END LOOP;
   		 CLOSE SO_SHOP_ORDER;
		 OPEN CO_CUSTOMER_ORDER;
		 LOOP               -- Match inventory item to customer orders
		 	 FETCH CO_CUSTOMER_ORDER INTO v_co;
			 	   exit when CO_CUSTOMER_ORDER%NOTFOUND;
			 ws_customer_order_assign := ws_customer_order_assign + v_co.E_QTY_ASSIGNED;
		 END LOOP;
		 CLOSE CO_CUSTOMER_ORDER;
--		 if ws_customer_order_assign + ws_shop_order_assign != ws_inventory_reserved then
		    ws_order_total := ws_inventory_reserved - ws_shop_order_assign - ws_customer_order_assign;
		 	UTL_FILE.PUT(outfile, v_ipis.C_PART_NO || '|' ||v_ipis.C_RESERVED || '|' || 
		 	ws_shop_order_assign || '|' || ws_customer_order_assign || '|'|| ws_order_total);
 		 UTL_FILE.NEW_LINE(OUTFILE,1);
--		 INSERT INTO IFSINFO.PRL_PART_REVIEW (USERNAME, RUN_DATE_TIME, INVENTORY_PART_NUMBER, NUMBER_RESERVED, SHOP_ORD_RESERVED,
--		                                   CUST_ORD_RESERVED) 
--										   VALUES (USER,CURRENT_DATE, v_ipis.C_PART_NO, v_ipis.C_RESERVED, ws_shop_order_assign, ws_customer_order_assign);
--		 end if;
	 END LOOP;
	 close IPIS_INVENTORY;
	 stats := CAST(SYSTIMESTAMP AS TIMESTAMP);
 	 UTL_FILE.PUT(OUTFILE, 'END TIME: ' || stats);
	 UTL_FILE.fclose(outfile);
	 COMMIT;
	 INVENTORY_REPORTLOCATIONS;
END;
--end;

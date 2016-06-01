DECLARE

   info_         VARCHAR2(200);
   part_no_      VARCHAR2(25);
   part_range_   VARCHAR2(25);
   count_        NUMBER;
   lu_name_      CONSTANT VARCHAR2(25) := 'SparePartForecast';
   key_             VARCHAR2(2000);
CURSOR get_parts IS
	   SELECT PART_NO FROM ifsapp.INVENTORY_PART
	   where part_no like ('%');
CURSOR get_forecast (part_no_ VARCHAR2) IS
      SELECT rowid, t.*
      FROM SPARE_PART_FORECAST_TAB t
      WHERE part_no = part_no_;
CURSOR get_spares (part_no_ VARCHAR2) IS
      SELECT rowid, t.*
      FROM SPARE_PART_TAB t
      WHERE part_no = part_no_;
rec get_parts%rowtype;
status_  integer;
BEGIN
   count_ := 0;
   open get_parts;   
   part_range_ := '%';
	  loop
	  fetch get_parts into rec;
	  		exit when get_parts%notfound;
	  part_no_ := rec.part_no;
      FOR remrec_ IN get_forecast (part_no_) LOOP
         Spare_Part_Forecast_Util_API.Check_Conflicting_Job_Running ( remrec_.contract,
                                         remrec_.part_no,
                                         NULL,
                                         lu_name_,
                                         'ALL^' );
         key_ := remrec_.contract || '^' || remrec_.part_no || '^' || remrec_.counter || '^' || Record_Type_API.Decode(remrec_.record_type) || '^';
         Reference_SYS.Check_Restricted_Delete(lu_name_, key_);
         
         SPARE_PART_FORECAST_API.Remove (
            remrec_.contract,
            remrec_.part_no,
            remrec_.record_type,
            remrec_.counter);
         
         INSERT
            INTO peer_spare_part_forecast_tab (
               contract,
               part_no,
               counter,
               record_type,
               forecast_date,
               forecast_qty,
               actual_demand,
               consumed_forecast,
               note_text,
               planned_demand,
               xxx_orig_fcst_qty,
               rowversion)
            VALUES (
               remrec_.contract,
               remrec_.part_no,
               remrec_.counter,
               remrec_.record_type,
               remrec_.forecast_date,
               remrec_.forecast_qty,
               remrec_.actual_demand,
               remrec_.consumed_forecast,
               remrec_.note_text,
               remrec_.planned_demand,
               remrec_.xxx_orig_fcst_qty,
               remrec_.rowversion);      
      END LOOP;

      FOR newrec_ IN get_spares (part_no_) LOOP
         SPARE_PART_API.Remove__ (
            info_,
            newrec_.rowid,
            ltrim(lpad(to_char(newrec_.rowversion,'YYYYMMDDHH24MISS'),2000)),
            'CHECK' );
         SPARE_PART_API.Remove__ (
            info_,
            newrec_.rowid,
            ltrim(lpad(to_char(newrec_.rowversion,'YYYYMMDDHH24MISS'),2000)),
            'DO' );

--         UPDATE inventory_part_tab
--            SET forecast_consumption_flag = 'NOFORECAST',
--                note_text = 'Unchecked Online Consumption flag on ' || SYSDATE || ' using G470902_DeleteSpareParts.sql script.',
--                rowversion = sysdate
--            WHERE contract = newrec_.contract
--            AND   part_no = newrec_.part_no
--            AND   forecast_consumption_flag = 'FORECAST';

      
         INSERT
            INTO peer_spare_part_tab (
               contract,
               part_no,
               qty_per,
               overage,
               roll_flag,
               family_code,
               consumption_window,
               rowversion)
            VALUES (
               newrec_.contract,
               newrec_.part_no,
               newrec_.qty_per,
               newrec_.overage,
               newrec_.roll_flag,
               newrec_.family_code,
               newrec_.consumption_window,
               newrec_.rowversion);
   
         count_ := count_ + 1;      
      END LOOP;
   END LOOP;   
--   dbms_output.put_line(count_ || ' spare parts deleted.');
   close get_parts;   
   COMMIT;
END;
/
SET SERVEROUT OFF
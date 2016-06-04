SET SERVEROUT ON
SET VERIFY OFF

PROMPT Deleted data will be stored in PEER_SPARE_PART_FORECAST_TAB and PEER_SPARE_PART_TAB
BEGIN
   IF NOT (Database_SYS.Table_Exist('PEER_SPARE_PART_FORECAST_TAB')) THEN
      EXECUTE IMMEDIATE 'CREATE TABLE PEER_SPARE_PART_FORECAST_TAB
         AS (SELECT * FROM SPARE_PART_FORECAST_TAB
               WHERE CONTRACT = ''XX'' AND PART_NO = ''XX'')';
   END IF;
   IF NOT (Database_SYS.Table_Exist('PEER_SPARE_PART_TAB')) THEN
      EXECUTE IMMEDIATE 'CREATE TABLE PEER_SPARE_PART_TAB
         AS (SELECT * FROM SPARE_PART_TAB
               WHERE CONTRACT = ''XX'' AND PART_NO = ''XX'')';
   END IF;
END;
/
PROMPT Enter Spare Part_no to be deleted:
DECLARE

   info_         VARCHAR2(200);
   part_no_      VARCHAR2(25);
   count_        NUMBER;
   lu_name_      CONSTANT VARCHAR2(25) := 'SparePartForecast';
   key_             VARCHAR2(2000);
   
CURSOR get_forecast (part_no_ VARCHAR2) IS
      SELECT rowid, t.*
      FROM SPARE_PART_FORECAST_TAB t
      WHERE part_no = part_no_;

CURSOR get_spares (part_no_ VARCHAR2) IS
      SELECT rowid, t.*
      FROM SPARE_PART_TAB t
      WHERE part_no = part_no_;
status_  integer;
BEGIN
-- dbms_output.put_line('Enter Spare Part_no to be Deleted, Enter X to exit: ');
   
   count_ := 0;   
--   while ( part_no_ != 'X') LOOP
      part_no_ := UPPER('&part_no');
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
--   END LOOP;   
   dbms_output.put_line(count_ || ' spare parts deleted.');   
   COMMIT;
END;
/
SET SERVEROUT OFF
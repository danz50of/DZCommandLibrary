create or replace FUNCTION MPS_GET_NEXT_PLN_DATE (
   ms_set_          IN NUMBER,
   part_no_         IN VARCHAR2 ) RETURN DATE
IS
   date_  DATE;
BEGIN
   SELECT MIN(MS_DATE)
   INTO   date_
   FROM   IFSAPP.LEVEL_1_FORECAST_TAB
   WHERE  contract = 'MP'
   AND    part_no  = part_no_
   AND    ms_set   = ms_set_
   AND    ms_date >= IFSAPP.LEVEL_1_PART_API.Get_Planning_Tf_Date('MP', part_no_, ms_set_);
   RETURN date_;
END;
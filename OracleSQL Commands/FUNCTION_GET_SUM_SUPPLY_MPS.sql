create or replace FUNCTION Mps_Get_Sum_Supply (
   contract_        IN VARCHAR2,
   part_no_         IN VARCHAR2,
   ms_set_          IN NUMBER,
   begin_counter_   IN NUMBER,
   end_counter_     IN NUMBER ) RETURN NUMBER
IS
   sum_   NUMBER;
BEGIN
   SELECT SUM(NVL(supply, 0))
   INTO   sum_
   FROM   LEVEL_1_FORECAST_TAB
   WHERE  contract = contract_
   AND    part_no  = part_no_
   AND    ms_set   = ms_set_
   AND    counter BETWEEN begin_counter_ AND end_counter_;
   RETURN sum_;
END;
CREATE OR REPLACE FUNCTION Tube_Cell_Get_Sum_Qty_Demand (
   contract_         IN VARCHAR2,
   part_no_          IN VARCHAR2 )  RETURN NUMBER
   IS
   qty_demand_   NUMBER;
   
   CURSOR getrec IS
   SELECT nvl(sum(qty_demand),0)
   FROM ORDER_SUPPLY_DEMAND
   WHERE contract = contract_
   AND part_no = part_no_
   AND date_required < trunc(sysdate) + 14;
BEGIN
   OPEN getrec;
   FETCH getrec INTO qty_demand_;
   IF (getrec%NOTFOUND) THEN
      qty_demand_ := 0;
   END IF;
   CLOSE getrec;
   RETURN qty_demand_;
END Tube_Cell_Get_Sum_Qty_Demand;
CREATE OR REPLACE FUNCTION MPS_EVALUATE_FLAG(
weighted_demand_ in number, on_hand_ in number, avail_ in number, safety_stock_ in number, forecast_ in number,
DAYS in number) return varchar2
is
flags_ varchar2(10);
begin
   flags_:=null;
   IF (safety_stock_ < (weighted_demand_ * .25)) THEN
      flags_ := flags_ || 'S ';
   END IF;
   IF (safety_stock_ > (weighted_demand_ * .75)) THEN
      flags_ := flags_ || 'T ';
   END IF;
   IF (DAYS < 5) THEN
   	  flags_ := flags_ || 'U ';
   END IF;
   IF (on_hand_ > (weighted_demand_ *.7)) THEN
      flags_ := flags_ || 'V ';
   END IF;
   IF (on_hand_ < (safety_stock_ * .50)) THEN
   	  flags_ := flags_ || 'W ';
   END IF;
   IF (forecast_ < (weighted_demand_ * .75)) then
      flags_ := flags_ || 'X ';
   END IF;
   IF (forecast_ > (weighted_demand_ * 1.25)) then
   	  flags_ := flags_ || 'Y '; 
   END IF;
   IF (on_hand_ < (weighted_demand_ * .3)) then
   	  flags_ := flags_ || 'Z ';
   END IF;
   return (flags_);
END;
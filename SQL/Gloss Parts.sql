select a.part_no,b.description Descr,nvl(ifsapp.get_qty_onhand_all_loc(a.contract,a.part_no),0) On_Hand,
round(ifsapp.get_part_cost(a.contract,a.part_no),4)Std_Cost,
a.mon_01 + a.mon_02 + a.mon_03 + a.mon_04 + a.mon_05 + a.mon_06 + a.mon_07 + a.mon_08 + a.mon_09
+ a.mon_10 + a.mon_11 + a.mon_12 + a.mon_13 + a.mon_14 + a.mon_15 + a.mon_16 + a.mon_17 + a.mon_18 + a.mon_19 + a.mon_20 
+ a.mon_21 + a.mon_22 + a.mon_23 + a.mon_24 + a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 
+ a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36 Qty_Usage,
round((a.mon_01 + a.mon_02 + a.mon_03 + a.mon_04 + a.mon_05 + a.mon_06 + a.mon_07 + a.mon_08 + a.mon_09
+ a.mon_10 + a.mon_11 + a.mon_12 + a.mon_13 + a.mon_14 + a.mon_15 + a.mon_16 + a.mon_17 + a.mon_18 + a.mon_19 + a.mon_20 
+ a.mon_21 + a.mon_22 + a.mon_23 + a.mon_24 + a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 
+ a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36 ) / 36,2) Avrg_Usage,
a.mon_01,a.mon_02,a.mon_03,a.mon_04,a.mon_05,a.mon_06,a.mon_07,a.mon_08,a.mon_09,a.mon_10,a.mon_11,a.mon_12,a.mon_13, 
a.mon_14,a.mon_15,a.mon_16,a.mon_17,a.mon_18,a.mon_19,a.mon_20,a.mon_21,a.mon_22,a.mon_23,a.mon_24,a.mon_25,a.mon_26, 
a.mon_27,a.mon_28,a.mon_29,a.mon_30,a.mon_31,a.mon_32,a.mon_33,a.mon_34,a.mon_35,a.mon_36 
from ifsinfo.run_rate_3year a, ifsapp.inventory_part b, ifsapp.sales_part c where
a.part_no like '___-P1___' OR A.PART_NO LIKE '___-C4___'




select * from ifsinfo.run_rate_3year where part_no like '___-P1___' OR PART_NO LIKE '___-C4___'
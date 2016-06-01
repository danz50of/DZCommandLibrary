SELECT b.PART_NO, b.DESCRIPTION,
IFSAPP.INVENTORY_PART_API.GET_PLANNER_BUYER('MP',b.PART_NO) PLANNER, ROUND(IFSAPP.INVENTORY_PART_COST_API.Get_Part_Cost(b.contract, b.part_no), 2) COST_PER_UNIT,
IFSAPP.ORDER_SUPPLY_DEMAND_API.GET_SUM_QTY_DEMAND('MP',b.PART_NO, '*') DEMAND,
IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand(b.CONTRACT,b.PART_NO,NULL) ON_HAND,
IFSAPP.INVENTORY_PART_PLANNING_API.Get_safety_stock(b.CONTRACT, b.PART_NO) SAFETY_STOCK, 
a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 + a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36  Qty_Usage, round((a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 + a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36) / 12,2)  Avrg_Usage,
c.qty_per_kanban, c.number_of_kanbans, c.qty_per_kanban * c.number_of_kanbans Total_Kanban_Level, CASE WHEN  
a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 + a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36 = 0 THEN 0 ELSE
IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand(b.CONTRACT,b.PART_NO,NULL)/  round((a.mon_25 + a.mon_26 + a.mon_27 + a.mon_28 + a.mon_29 + a.mon_30 + a.mon_31 + a.mon_32 + a.mon_33 + a.mon_34 + a.mon_35 + a.mon_36) / 12,2)
END LABEL1, IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand(b.CONTRACT,b.PART_NO,NULL)/  (c.qty_per_kanban * c.number_of_kanbans) LABEL2, 
d.state
FROM IFSAPP.INVENTORY_PART b, ifsinfo.run_rate_3year a, ifsapp.kanban_circuit c, ifsapp.purchase_order_line_part d                                                                
WHERE b.CONTRACT = 'MP' and a.contract = 'MP' and c.contract = d.contract and c.part_no = d.part_no and b.part_no = a.part_no and a.part_no = c.part_no(+) and b.planner_buyer in 'KBC2' 
and d.state(+) not in ('Closed','Cancelled','Received') and b.PART_STATUS IN 'A'

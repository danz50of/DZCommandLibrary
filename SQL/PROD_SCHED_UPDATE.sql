SELECT contract, 
part_no, 
order_no, 
line_no, 
substr(IFSAPP.inventory_part_api.get_description(contract, part_no),1,40) Description, 
       date_required, 
 qty_demand, 
order_supply_demand_type, 
 substr(IFSAPP.manuf_part_attribute_api.Get_Process_Type(contract, part_no),1,20) Process_Type, 
       IFSAPP.Inventory_Part_Location_API.Get_Plannable_Qty_Onhand(Contract, Part_No) Qty_Onhand 
FROM IFSAPP.ORDER_SUPPLY_DEMAND_SCHED 
WHERE IFSAPP.manuf_part_attribute_api.Get_Process_Type(contract, part_no) IS NOT NULL 
AND  order_supply_demand_type != 'Spare part forecast' 
AND IFSAPP.INVENTORY_PART_API.get_planner_buyer(contract, part_no) not in('MPS','CNC/PUNCH','FAB','WELD','LASER') 
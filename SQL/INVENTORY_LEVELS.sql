SELECT PART_NO, IFSAPP.INVENTORY_PART_API.GET_PLANNER_BUYER PLANNER, 
SAFETY_STOCK, MAX_ORDER_QTY, MIN_ORDER_QTY, MUL_ORDER_QTY  FROM INVENTORY_PART_PLANNING 
WHERE IFSAPP.INVENTORY_PART_API.get_planner_buyer(contract, part_no) in ('WELD','CNC/LASER','FAB')
SELECT PART_NO, DESCR, CREATED, ON_HAND, ACCT_GRP, STATUS, PART_TYPE,
SALES_GRP, PROD_CODE, PROD_FAM, STD_COST, QTY_USAGE, AVRG_USAGE,
MON_10, MON_11, MON_12,
NVL(OPEN_CUSTOMER_ORDER,0) OPEN_CUSTOMER_ORDER,
NVL(QTY_ON_HAND,0) QTY_ON_HAND,
NVL(QTY_AVAILABLE,0) QTY_AVAILABLE,
NVL((CASE 
 WHEN (OPEN_CUSTOMER_ORDER - QTY_AVAILABLE) <= 0 THEN 
 0
 ELSE
 (OPEN_CUSTOMER_ORDER - QTY_AVAILABLE)
 END),0) BACKORDER_QTY,
NVL(OPEN_SUPPLIER_QTY, 0) OPEN_PO_QTY,
((QTY_AVAILABLE - NVL(OPEN_CUSTOMER_ORDER,0))) / (AVRG_USAGE + .0000000000001) MO_ONHAND_AVERAGE,
((QTY_AVAILABLE - NVL(OPEN_CUSTOMER_ORDER,0)) + NVL(OPEN_SUPPLIER_QTY,0)) / (AVRG_USAGE + .000000000001)MO_ONHAND_WITH_CURRENT_ORDERS
FROM
(select a.part_no,
       b.description Descr,
       to_char(b.create_date,'mm/dd/yy') Created,
       nvl(ifsapp.get_qty_onhand_all_loc(a.contract,a.part_no),0) On_Hand,
       b.accounting_group Acct_Grp,
       b.part_status Status,
       b.type_code Part_Type,
       c.catalog_group Sales_Grp,
       b.part_product_code Prod_Code,
       b.part_product_family Prod_Fam,
       round(ifsapp.get_part_cost(a.contract,a.part_no),4) Std_Cost,
       a.mon_34 + a.mon_35 + a.mon_36  Qty_Usage,
      round((a.mon_34 + a.mon_35 + a.mon_36) / 3,2)  Avrg_Usage,
       a.mon_34 mon_10, a.mon_35 mon_11, a.mon_36 mon_12,
            (SELECT SUM(QTY_DEMAND)
              FROM IFSAPP.ORDER_SUPPLY_DEMAND_EXT SUP_EXT
              WHERE SUP_EXT.PART_NO = A.PART_NO
              AND SUP_EXT.CONTRACT = B.CONTRACT) OPEN_CUSTOMER_ORDER,
       IFSAPP.INVENTORY_PART_IN_STOCK_API.Get_Inventory_Qty_Onhand('BBG',A.PART_NO,'*') QTY_ON_HAND,
       IFSAPP.MPS_GET_AVAILABLE_UK(A.PART_NO) QTY_AVAILABLE,
       NULL BACKORDER_QTY,
             (SELECT SUM(QTY_SUPPLY)
              FROM IFSAPP.ORDER_SUPPLY_DEMAND_EXT SUP_EXT
              WHERE SUP_EXT.PART_NO = A.PART_NO
              AND SUP_EXT.CONTRACT = B.CONTRACT) OPEN_SUPPLIER_QTY,
       --NULL QTY_RESERVED,
       NULL MO_ONHAND_AVERAGE,
       NULL MO_ONHAND_WITH_CURRENT_ORDERS
      from ifsinfo.run_rate_3year a, ifsapp.inventory_part b, ifsapp.sales_part c
      where a.contract = 'BBG' and
         a.part_no = b.part_no and a.contract = b.contract and a.part_no = c.catalog_no(+)  and a.contract = 
         c.contract(+))
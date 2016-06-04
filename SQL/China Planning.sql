--Query for Part "Header" Information AND FORECAST INFORMATION


select INVENTORY_PART.PART_NO, INVENTORY_PART.DESCRIPTION, INVENTORY_PART.CONTRACT, PLANNER_BUYER
, IFSAPP.INVENTORY_PART_PLANNING_API.GET_SAFETY_STOCK('MP', INVENTORY_PART.PART_NO) SAFTEY_STOCK
, IFSAPP.LEVEL_1_PART_API.GET_DEMAND_TF_DATE('MP', INVENTORY_PART.PART_NO, 1) DEMAND_TF
, IFSAPP.LEVEL_1_PART_API.GET_PLANNING_TF_DATE('MP', INVENTORY_PART.PART_NO, 1) PLANNING_TF
, IFSINFO.PRL_FGCHINA_FORECAST_IAL.MS_SET, IFSINFO.PRL_FGCHINA_FORECAST_IAL.MS_DATE, FORECAST_LEV1, SYSGEN_FLAG
from IFSAPP.inventory_part LEFT JOIN IFSINFO.PRL_FGCHINA_FORECAST_IAL ON IFSINFO.PRL_FGCHINA_FORECAST_IAL.PART_NO = IFSAPP.INVENTORY_PART.PART_NO
where planner_buyer = 'FG_CHINA'
--AND FORECAST_LEV1 > 0



--Query to evaluate forecast information

--SELECT *
select CONTRACT, PART_NO, MS_SET, MS_DATE, FORECAST_LEV1, SYSGEN_FLAG,
UNCONSUMED_FORECAST
from ifsapp.level_1_forecast 
where ifsapp.inventory_part_api.get_planner_buyer('MP', PART_NO) = 'FG_CHINA'
AND FORECAST_LEV1 > 0
ORDER BY PART_NO, MS_DATE





--Query for Purchase Orders and Requisitions

   SELECT 'Purch Req' rec_type, contract site,
          ifsapp.inventory_part_api.get_planner_buyer (contract,
                                                       part_no
                                                      ) planner,
          ifsapp.manuf_part_attribute_api.get_process_type
                                                      (contract,
                                                       part_no
                                                      ) process_type,
          requisition_no order_or_req, part_no, description,
          latest_order_date start_date_or_proposed,
          wanted_delivery_date need_or_due_date, state,
          original_qty lot_size_or_qty, qty_on_order qty_complete,
          qty_balance remaining_qty--, NULL product_state, NULL material_state
     FROM ifsapp.purchase_req_line_all
    WHERE state IN
             ('Released', 'Planned', 'Authorized', 'Request Created',
              'Partially Authorized')
      AND ifsapp.inventory_part_api.get_planner_buyer (contract, part_no) IN
             ('FG_CHINA')
   UNION
   SELECT 'Purch Order' rec_type, contract site,
          ifsapp.inventory_part_api.get_planner_buyer (contract,
                                                       part_no
                                                      ) planner,
          ifsapp.manuf_part_attribute_api.get_process_type
                                                      (contract,
                                                       part_no
                                                      ) process_type,
          order_no order_or_req, part_no, description,
          planned_delivery_date start_date_or_proposed,
          wanted_delivery_date need_or_due_date, state,
          buy_qty_due lot_size_or_qty, NULL qty_complete, NULL remaining_qty
          --,NULL product_state, NULL material_state
     FROM ifsapp.purchase_order_line_all
    WHERE ifsapp.inventory_part_api.get_planner_buyer (contract, part_no) IN
             ('FG_CHINA')
      AND state IN ('Arrived', 'Confirmed', 'Received', 'Released')
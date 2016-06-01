/* Query to see if tracking numbers are in the staging table
   This would indicate end of day on UPS machine has finished 
   But the IFS procedure did not run to populate tracking numbers
*/  
select * from ifsinfo.ups_export_tracking_tab

/* Query to see if the data for the day in question made it to the
   history table 
*/
select * from ifsinfo.ups_export_history_tab
--select * from ifsinfo.ups_export_tracking_tab
--where trunc(to_date (pickup_date,'yyyymmddhh24miss'),'dd') > to_date('20101201', 'yyyymmdd')--and order_num LIKE 'A263861'
--where order_num in ('A256349')
--order by pickup_date desc


select distinct shipment_id TRACKING_NUM, ORDER_NUM, pickup_date
--select * 
             from ifsinfo.ups_export_history_tab 
--             where order_num like 'A350049'
--             where trunc(to_date (pickup_date,'yyyymmddhh24miss')) = to_date('20081223', 'yyyymmdd') --and order_num LIKE 'C614963'
order by pickup_date desc			 
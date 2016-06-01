select part_no, sum(forecast_qty), sum(consumed_forecast), sum(actual_demand)
from spare_part_forecast_tab
where contract = 'MP'
group by part_no
having sum (forecast_qty) < sum(consumed_forecast)  
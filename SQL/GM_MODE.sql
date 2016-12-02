SELECT PART, DESCRIPTION, STATS_MODE(MARGIN) MARGIN_MODE, AVG(MARGIN) AVERAGE_MARGIN, MEDIAN(MARGIN) MEDIAN_MARGIN FROM(
select part, description, qty, customer, Cust_name, order_num, ext_part_cost, sale_amt, 
(case sale_amt
when 0 then 0
else
round ((sale_amt - ext_part_cost) / sale_amt,3)
end) MARGIN
from IFSINFO.GROSS_PROFIT_2015_2016
where year >= 2016
order by
part, customer, order_num)
GROUP BY PART, DESCRIPTION
ORDER BY PART


select * from IFSINFO.GROSS_PROFIT_2015_2016





select part, description, qty, customer, Cust_name, order_num, ext_part_cost, sale_amt, 
(case sale_amt
when 0 then 0
else
round ((sale_amt - ext_part_cost) / sale_amt,3)
end) MARGIN
from IFSINFO.GROSS_PROFIT_2015_2016
where year >= 2016
order by
part, customer, order_num
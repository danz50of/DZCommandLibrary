select catalog_no Part_no, contract site, catalog_desc descr, list_price,
(case when contract = 'MP' then 'USD'
      when contract = 'BBG' then 'GBP'
      when contract = 'MX' then 'MXN'
 end) local_currency
from sales_part
where
activeind_db = 'Y'
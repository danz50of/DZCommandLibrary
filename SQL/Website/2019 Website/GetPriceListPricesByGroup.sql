--in ('CORE','ACORE','ET','AET','KIOSK','AKIOSK','E-TAIL', 'DS','ADS','HOSP')
select SALES_PRICE_GROUP_ID, CATALOG_NO AS SALES_PART, CATALOG_DESC AS DESCRIPTION, DEALER, PARTNER, DISTRIBUTOR, SPECIAL
FROM(
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'COREDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'COREPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'COREDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'CORESPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'CORE'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ACOREDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ACOREPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ACOREDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ACORESPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'ACORE'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'ET'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AETDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AETPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AETDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AETSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'AET'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'DSDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'DSPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'DSDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'DSSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'DS'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ADSDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ADSPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ADSDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ADSSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'ADS'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'KISKDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'KISKPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'KISKDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'KISKSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'KIOSK'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AKISKDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AKISKPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AKISKDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'AKISKSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'AKIOSK'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETAILDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETAILPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETAILDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'ETAILSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'E-TAIL'
UNION
select SALES_PRICE_GROUP_ID, catalog_no, catalog_desc, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'HOSPDEAL') AS DEALER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'HOSPPART') AS PARTNER, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'HOSPDIST') DISTRIBUTOR, 
    IFSAPP.plist_part_price ('MP', catalog_no, 'HOSPSPEC') SPECIAL
from sales_part
where SALES_PRICE_GROUP_ID = 'HOSP')
WHERE (DEALER > 0 OR PARTNER > 0 OR DISTRIBUTOR > 0 OR SPECIAL > 0) 
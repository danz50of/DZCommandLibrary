SELECT CATALOG_NO, CATALOG_DESC, SALES_PRICE_GROUP_ID, ACTIVEIND_DB, IFSAPP.plist_part_price ('BBG', CATALOG_NO, 'P4-025K') 
FROM SALES_PART WHERE CONTRACT = 'BBG'
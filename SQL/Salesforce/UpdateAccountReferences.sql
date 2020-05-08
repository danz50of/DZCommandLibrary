select * from ifsinfo.PIVOT_ROLLING_YR_OVER_YR_IAL
where identity in ('036751')



update IFSINFO.POS_TAB set cust_number = '036751' 
where CUST_NUMBER = 'POS365'

commit;
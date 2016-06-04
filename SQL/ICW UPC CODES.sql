select
  a.contract,
  a.catalog_no,
  b.catalog_desc,
  a.attr_value,
  (SELECT C.attr_value FROM ifsapp.inv_part_indiscrete_char c
  WHERE A.CONTRACT = C.CONTRACT AND A.CATALOG_NO = C.PART_NO 
  AND C.CONTRACT = 'MP'
  AND C.CHARACTERISTIC_CODE = 'UPC') UPC
from
  ifsapp.sales_part_characteristic a,
  ifsapp.sales_part b
where
  a.catalog_no = b.Catalog_no and a.contract = 'MP' and
  a.attr_value in 'ICW'
  
  
  
  
  SELECT * FROM IFSAPP.INV_PART_INDISCRETE_CHAR WHERE PART_NO = 'GX150'
  AND CH
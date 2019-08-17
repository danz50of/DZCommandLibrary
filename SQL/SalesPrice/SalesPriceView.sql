    SELECT a.part_no             Sales_Part,
           a.catalog_desc        Description,
           A.SALES_PRICE_GROUP_ID   PRICE_GROUP,
           a.activeind_db        active,
           F.PRICE_LIST_NO       price_list,
           f.valid_from_date,
           g.valid_to_date,
           f.min_quantity,
           a.sales_unit_meas     Unit_Of_Measure,
           f.base_price,
           f.sales_price,
           F.CATALOG_NO PRICE_LIST_PART,
           g.currency_code       Currency
      FROM IFSAPP.sales_part             a,
           IFSAPP.sales_price_list_part  f,
           IFSAPP.sales_price_list       g
     WHERE     a.contract = 'MP'
           AND a.catalog_no = f.catalog_no
           AND A.SALES_PRICE_GROUP_ID IN ('AET','ET')
           AND (f.price_list_no IN ('ETDEAL','ETDIST','ETPART','ETSPEC','AETSPEC','AETDEAL','AETDIST','AETPART'))
           AND a.contract = f.base_price_site
           AND f.price_list_no = g.price_list_no
           AND f.valid_from_date =
               (SELECT MAX (x.valid_from_date)
                  FROM IFSAPP.sales_price_list_part x
                 WHERE     x.catalog_no = f.catalog_no
                       AND f.price_list_no = x.price_list_no
                       AND f.min_quantity = x.min_quantity)
           AND (G.VALID_TO_DATE >= SYSDATE OR G.VALID_TO_DATE IS NULL)
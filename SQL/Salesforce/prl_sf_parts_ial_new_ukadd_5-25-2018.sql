     SELECT PART_NO,
            MAX (DESCR) AS US_DESCR,
            MAX (LIST_PRICE) LIST_PRICE,
            MAX (PRL_FAMILY) PRL_FAMILY,
            MAX (CATALOG_GROUP) CATALOG_GROUP,
            MAX (MX_DESCRIPTION) MX_DESCRITPION,
            MAX (MX_LIST_PRICE) MX_LIST_PRICE,
            MAX (UK_DESCRIPTION) UK_DESCRIPTION,
            MAX (UK_LIST_PRICE) UK_LIST_PRICE,
            NAMEPLUSSITE
       FROM (SELECT SALES_PART.CATALOG_NO AS PART_NO,
                    SALES_PART.CONTRACT AS SITE,
                    SALES_PART.CATALOG_DESC AS DESCR,
                    SALES_PART.LIST_PRICE,
                    CASE
                       WHEN contract = 'MP' THEN 'USD'
                       WHEN contract = 'BBG' THEN 'GBP'
                       WHEN contract = 'MX' THEN 'MXN'
                    END
                       AS LOCAL_CURRENCY,
                    CASE
                       WHEN catalog_group = 'CIIL'
                       THEN
                          'Outdoor Displays'
                       WHEN catalog_group = 'FPSS'
                       THEN
                          CASE
                             WHEN catalog_no LIKE 'DS-%'
                             THEN
                                'Digital Signage'
                             WHEN CATALOG_NO IN ('FPZ-600',
                                                 'LCFS-100',
                                                 'LCFS-100S',
                                                 'SR542-KAPP',
                                                 'SR555M',
                                                 'SR560M',
                                                 'SR560M-AB',
                                                 'SR575E',
                                                 'SR575M',
                                                 'SR598',
                                                 'SR598-HUB',
                                                 'SS560F',
                                                 'SS560G',
                                                 'SS560M',
                                                 'SS575K')
                             THEN
                                'Carts and Stands'
                             ELSE
                                'Display Mounts'
                          END
                       WHEN catalog_group = 'KIOS'
                       THEN
                          'Kiosks and Enclosures'
                       WHEN catalog_group = 'PSS'
                       THEN
                          'Projector Mounts'
                       WHEN catalog_group = 'WIRE'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'INTT'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'RACK'
                       THEN
                          'ET - Wireless'
                       WHEN CATALOG_GROUP = 'APNS'
                       THEN
                          'Accessories - Piece Parts'
                       ELSE
                          'OTHER'
                    END
                       AS PRL_FAMILY,
                    SALES_PART.CATALOG_GROUP,
                    NULL AS MX_DESCRIPTION,
                    NULL AS MX_LIST_PRICE,
                    NULL AS UK_DESCRIPTION,
                    NULL AS UK_LIST_PRICE,
                    SALES_PART.CATALOG_NO || 'MP' NAMEPLUSSITE
               FROM IFSAPP.SALES_PART SALES_PART
              WHERE     (SALES_PART.CONTRACT = 'MP')
                    AND (SALES_PART.ACTIVEIND_DB = 'Y')
             UNION
             SELECT SALES_PART.CATALOG_NO AS PART_NO,
                    SALES_PART.CONTRACT AS SITE,
                    SALES_PART.CATALOG_DESC AS DESCR,
                    SALES_PART.LIST_PRICE AS LIST_PRICE,
                    CASE
                       WHEN contract = 'MP' THEN 'USD'
                       WHEN contract = 'BBG' THEN 'GBP'
                       WHEN contract = 'MX' THEN 'MXN'
                    END
                       AS LOCAL_CURRENCY,
                    CASE
                       WHEN catalog_group = 'CIIL'
                       THEN
                          'Outdoor Displays'
                       WHEN catalog_group = 'FPSS'
                       THEN
                          CASE
                             WHEN catalog_no LIKE 'DS-%'
                             THEN
                                'Digital Signage'
                             WHEN CATALOG_NO IN ('FPZ-600',
                                                 'LCFS-100',
                                                 'LCFS-100S',
                                                 'SR542-KAPP',
                                                 'SR555M',
                                                 'SR560M',
                                                 'SR560M-AB',
                                                 'SR575E',
                                                 'SR575M',
                                                 'SR598',
                                                 'SR598-HUB',
                                                 'SS560F',
                                                 'SS560G',
                                                 'SS560M',
                                                 'SS575K')
                             THEN
                                'Carts and Stands'
                             ELSE
                                'Display Mounts'
                          END
                       WHEN catalog_group = 'KIOS'
                       THEN
                          'Kiosks and Enclosures'
                       WHEN catalog_group = 'PSS'
                       THEN
                          'Projector Mounts'
                       WHEN catalog_group = 'WIRE'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'INTT'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'RACK'
                       THEN
                          'ET - Wireless'
                       WHEN CATALOG_GROUP = 'APNS'
                       THEN
                          'Accessories - Piece Parts'
                       ELSE
                          'OTHER'
                    END
                       AS PRL_FAMILY,
                    SALES_PART.CATALOG_GROUP,
                    NULL AS MX_DESCRIPTION,
                    NULL AS MX_LIST_PRICE,
                    SALES_PART.CATALOG_DESC AS UK_DESCRIPTION,
                    SALES_PART.LIST_PRICE AS UK_LIST_PRICE,
                    SALES_PART.CATALOG_NO || 'BBG' AS NAMEPLUSSITE                    
               FROM IFSAPP.SALES_PART SALES_PART
              WHERE     (SALES_PART.CONTRACT = 'BBG')
                    AND (SALES_PART.ACTIVEIND_DB = 'Y')
             UNION
             SELECT SALES_PART.CATALOG_NO AS PART_NO,
                    SALES_PART.CONTRACT AS SITE,
                    SALES_PART.CATALOG_DESC AS DESCR,
                    SALES_PART.LIST_PRICE AS LIST_PRICE,
                    CASE
                       WHEN contract = 'MP' THEN 'USD'
                       WHEN contract = 'BBG' THEN 'GBP'
                       WHEN contract = 'MX' THEN 'MXN'
                    END
                       AS LOCAL_CURRENCY,
                    CASE
                       WHEN catalog_group = 'CIIL'
                       THEN
                          'Outdoor Displays'
                       WHEN catalog_group = 'FPSS'
                       THEN
                          CASE
                             WHEN catalog_no LIKE 'DS-%'
                             THEN
                                'Digital Signage'
                             WHEN CATALOG_NO IN ('FPZ-600',
                                                 'LCFS-100',
                                                 'LCFS-100S',
                                                 'SR542-KAPP',
                                                 'SR555M',
                                                 'SR560M',
                                                 'SR560M-AB',
                                                 'SR575E',
                                                 'SR575M',
                                                 'SR598',
                                                 'SR598-HUB',
                                                 'SS560F',
                                                 'SS560G',
                                                 'SS560M',
                                                 'SS575K')
                             THEN
                                'Carts and Stands'
                             ELSE
                                'Display Mounts'
                          END
                       WHEN catalog_group = 'KIOS'
                       THEN
                          'Kiosks and Enclosures'
                       WHEN catalog_group = 'PSS'
                       THEN
                          'Projector Mounts'
                       WHEN catalog_group = 'WIRE'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'INTT'
                       THEN
                          'ET - Wireless'
                       WHEN catalog_group = 'RACK'
                       THEN
                          'ET - Wireless'
                       WHEN CATALOG_GROUP = 'APNS'
                       THEN
                          'Accessories - Piece Parts'
                       ELSE
                          'OTHER'
                    END
                       AS PRL_FAMILY,
                    SALES_PART.CATALOG_GROUP,
                    SALES_PART.CATALOG_DESC AS MX_DESCRIPTION,
                    SALES_PART.LIST_PRICE AS MX_LIST_PRICE,
                    NULL AS UK_DESCRIPTION,
                    NULL AS UK_LIST_PRICE,
                    SALES_PART.CATALOG_NO || 'MX' AS NAMEPLUSSITE
               FROM IFSAPP.SALES_PART SALES_PART
              WHERE     (SALES_PART.CONTRACT = 'MX')
                    AND (SALES_PART.ACTIVEIND_DB = 'Y'))
       WHERE PART_NO LIKE 'DS-VW7%'
   GROUP BY PART_NO, NAMEPLUSSITE
   ORDER BY PART_NO, NAMEPLUSSITE
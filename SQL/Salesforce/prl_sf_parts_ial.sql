--prl_sf_parts_ial

    SELECT catalog_no   Part_no,
           contract     site,
           catalog_desc descr,
           list_price,
           (CASE
                WHEN contract = 'MP' THEN 'USD'
                WHEN contract = 'BBG' THEN 'GBP'
                WHEN contract = 'MX' THEN 'MXN'
            END)
               local_currency,
           (CASE
                WHEN catalog_group = 'CIIL'
                THEN
                    'Outdoor Displays'
                WHEN catalog_group = 'FPSS'
                THEN
                    (CASE
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
                     END)
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
            END)
               PRL_FAMILY,
           CATALOG_GROUP
      FROM IFSAPP.sales_part
     WHERE activeind_db = 'Y' AND contract IN ('MP')
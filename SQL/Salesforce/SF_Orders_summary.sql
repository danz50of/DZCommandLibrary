--pivot_rolling_yr_over_yr_ial

    SELECT IDENTITY,
           COMPANY,
           INVOICE_DATE,
           CATALOG_NO,
           INVOICED_QTY,
           EXTENDED_SALE,
           UNIQUE_KEY,
           USD_EXT_AMOUNT,
           'DIRECT SALES' AS SALES_TYPE
      FROM (  SELECT IFSAPP.CUSTOMER_ORDER_INV_HEAD.IDENTITY,
                     IFSAPP.CUSTOMER_ORDER_INV_HEAD.COMPANY,
                     TRUNC (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE)
                         AS INVOICE_DATE,
                     CUSTOMER_ORDER_INV_ITEM.CATALOG_NO,
                     SUM (CUSTOMER_ORDER_INV_ITEM.INVOICED_QTY) AS INVOICED_QTY,
                     SUM (CUSTOMER_ORDER_INV_ITEM.NET_DOM_AMOUNT)
                         AS EXTENDED_SALE,
                        TO_CHAR (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE,
                                 'YYYYMMDD')
                     || CUSTOMER_ORDER_INV_HEAD.IDENTITY
                     || CUSTOMER_ORDER_INV_ITEM.CATALOG_NO
                         AS "UNIQUE_KEY",
                     SUM (
                         ROUND (
                               CUSTOMER_ORDER_INV_ITEM.NET_DOM_AMOUNT
                             / IFSINFO.get_eff_exch_rate (
                                   CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE,
                                   DECODE (CUSTOMER_ORDER_INV_HEAD.COMPANY,
                                           '11', 'USD',
                                           '21', 'MXN',
                                           '31', 'GBP')),
                             2))
                         AS USD_EXT_AMOUNT,
                     'DIRECT SALES'                           AS SALES_TYPE
                FROM IFSAPP.CUSTOMER_ORDER_INV_HEAD CUSTOMER_ORDER_INV_HEAD
                     LEFT OUTER JOIN
                     IFSAPP.CUSTOMER_ORDER_INV_ITEM CUSTOMER_ORDER_INV_ITEM
                         ON (CUSTOMER_ORDER_INV_HEAD.INVOICE_ID =
                                 CUSTOMER_ORDER_INV_ITEM.INVOICE_ID)
               WHERE     (CUSTOMER_ORDER_INV_HEAD.COMPANY IN ('11', '21', '31'))
                     AND (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE >=
                              TO_DATE (
                                     '1/1/'
                                  || TO_CHAR (EXTRACT (YEAR FROM SYSDATE) - 1),
                                  'mm/dd/yyyy'))
                     AND (CUSTOMER_ORDER_INV_HEAD.OBJSTATE != 'Preliminary')
                     AND (TRIM (
                              SUBSTR (
                                  IFSAPP.get_ledger (
                                      CUSTOMER_ORDER_INV_HEAD.INVOICE_ID,
                                      CUSTOMER_ORDER_INV_ITEM.ITEM_ID),
                                  1,
                                  10)) IN
                              ('5000', '5025', '5027'))
            GROUP BY CUSTOMER_ORDER_INV_HEAD.COMPANY,
                     CUSTOMER_ORDER_INV_HEAD.IDENTITY,
                     TRUNC (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE),
                     CUSTOMER_ORDER_INV_ITEM.CATALOG_NO,
                        TO_CHAR (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE,
                                 'YYYYMMDD')
                     || CUSTOMER_ORDER_INV_HEAD.IDENTITY
                     || CUSTOMER_ORDER_INV_ITEM.CATALOG_NO
            ORDER BY    TO_CHAR (CUSTOMER_ORDER_INV_HEAD.INVOICE_DATE,
                                 'YYYYMMDD')
                     || CUSTOMER_ORDER_INV_HEAD.IDENTITY
                     || CUSTOMER_ORDER_INV_ITEM.CATALOG_NO)
    UNION
    SELECT IDENTITY,
           TO_CHAR (COMPANY),
           TO_DATE (INVOICE_DATE, 'MM/DD/YYYY') INVOICE_DATE,
           CATALOG_NO,
           INVOICED_QTY,
           EXTENDED_SALE,
           UNIQUE_KEY,
           USD_EXT_AMOUNT,
           SALES_TYPE
      FROM IFSINFO.POS_VIEW_IAL
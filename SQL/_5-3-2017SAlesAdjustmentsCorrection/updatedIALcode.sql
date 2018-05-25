   SELECT A.IDENTITY,
          SUBSTRB (
             IFSAPP.Invoice_Library_API.Get_Identity_Name (A.COMPANY,
                                                           A.IDENTITY,
                                                           A.PARTY_TYPE),
             1,
             50)
             Customer_Name,
          INVOICE_NO,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Discounts (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             Discounts,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Adjustments_DZ (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             Adjustments,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.CIIL_Returns (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             CIIL_Returns,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_gross_CIIL (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             gross_CIIL,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Returns (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             Returns,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Gross_Sales (invoice_id, a.invoice_type),
                         1,
                         12),
                0))
             Gross_Sales,
          SUBSTRB (
             IFSAPP.cust_ord_customer_api.Get_Salesman_Code (A.IDENTITY),
             1,
             6)
             sales_man,
          SUBSTRB (IFSAPP.Get_Phone (A.IDENTITY), 1, 12) phone_no,
          SUBSTRB (
             IFSAPP.cust_ord_customer_address_api.Get_Region_Code (
                A.IDENTITY,
                '01'),
             1,
             5)
             region_code,
          SUBSTRB (
             IFSAPP.cust_ord_customer_address_api.Get_district_Code (
                A.IDENTITY,
                '01'),
             1,
             5)
             district,
          c.city,
          c.zip_code zip,
          SUBSTRB (
             IFSAPP.CUSTOMER_ORDER_API.GET_MARKET_CODE (CREATORS_REFERENCE),
             1,
             20)
             Market_Type,
          SUBSTRB (IFSAPP.cust_ord_customer_api.GET_MARKET_CODE (A.IDENTITY),
                   1,
                   10)
             Market_Code,
          SUBSTRB (IFSAPP.cust_ord_customer_api.Get_Cust_Grp (A.IDENTITY),
                   1,
                   10)
             Cust_Grp,
          SUBSTRB (
             IFSAPP.CUSTOMER_ORDER_API.GET_CUSTOMER_PO_NO (
                CREATORS_REFERENCE),
             1,
             15)
             Customer_Po_No,
          SUBSTRB (
             IFSAPP.CUSTOMER_ORDER_API.GET_DATE_ENTERED (CREATORS_REFERENCE),
             1,
             20)
             Date_Entered,
          TO_NUMBER (
             NVL (SUBSTRB (IFSAPP.Get_BadDebt (invoice_id, 'INSTINV'), 1, 7),
                  0))
             BadDebt,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Surcharge (invoice_id, a.invoice_type),
                         1,
                         7),
                0))
             Surcharge,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_Prototype (invoice_id, a.invoice_type),
                         1,
                         7),
                0))
             Prototype,
          TO_NUMBER (
             NVL (
                SUBSTRB (IFSAPP.Get_VolRebates (invoice_id, a.invoice_type),
                         1,
                         7),
                0))
             Vol_Rebates,
          A.VOU_DATE,
          A.INVOICE_DATE,
          A.COMPANY,
          B.CODE Property_Code,
          B.VALUE Property_Code_Value,
          C.STATE,
          CREATORS_REFERENCE Order_No,
          d.pricelist1,
          d.pricelist2,
          d.annualpotential,
          DECODE (d.singleT10,
                  't10.003', 'Azione',
                  't10.004', 'Edge',
                  't10.005', 'Nationwide',
                  't10.001', 'Power House',
                  't10.002', 'USAV')
             BGroup,
          DECODE (d.idcodcca,
                  'cca.010', 'Active Customer',
                  'cca.051', 'Architects and Designers',
                  'cca.061', 'Closed Account',
                  'cca.065', 'Credit Withdrawn',
                  'cca.053', 'Competitor',
                  'cca.052', 'Contractor',
                  'cca.064', 'Design Build/Construction',
                  'cca.062', 'Distribution Customer',
                  'cca.020', 'Expired Customer',
                  'cca.063', 'Manufacturer',
                  'cca.030', 'Prospect',
                  'cca.040', 'School District',
                  'cca.050', 'School CO-OP',
                  'cca.060', 'Delete')
             Status,
          e.all_actvy all_activities,
          e.ytd_actv ytd_activities,
          e.ytd_meetings
     FROM IFSINFO.OUTGOING_INV_QRY_SNAPSHOT A,
          IFSAPP.PARTY_TYPE_ID_PROPERTY B,
          ifsinfo.CUSTOMER_INFO_ADD_SNAPSHOT C,
          IFSINFO.vmo_company_SNAPSHOT d,
          ifsinfo.sm_activity_count e
    WHERE     A.COMPANY = '11'
          and a.invoice_date >= to_date('1/1/2016','mm/dd/yyyy')
          AND A.COMPANY = B.COMPANY(+)
          AND A.IDENTITY = B.IDENTITY(+)
          AND A.IDENTITY = c.customer_id(+)
          AND a.identity = d.custno(+)
          AND a.identity = e.custno(+)
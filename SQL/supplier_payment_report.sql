   SELECT   ledg.identity,
            ledg.name,
            ledg.company,
            ledg.ledger_item_series_id,
            ledg.ledger_item_id INVOICE_NO,
            IFSAPP.MAN_SUPP_INVOICE_API.GET_INVOICE_DATE (LEDG.COMPANY,
                                                          'Supplier',
                                                          LEDG.IDENTITY,
                                                          LEDG.INVOICE_ID)
               INVOICE_DATE,
            (SELECT   INV.VOUCHER_NO
               FROM   IFSAPP.MAN_SUPP_INV_VOUCHER_QRY INV
              WHERE   INV.INVOICE_ID = LEDG.INVOICE_ID
                AND   INV.COMPANY = LEDG.COMPANY
                AND   INV.VOUCHER_TYPE = 'I')
               INVOICE_VOUCHER_NO,
            ledg.pay_date,
            ledg.Invoice_ID,
            ledg.voucher_no payment_voucher_no,
            ledg.payment_amount,
            ledg.payment_id,
            payment_type_code,
            payment_type_code_db,
            (SELECT   chk.ledger_item_id
               FROM   IFSAPP.check_ledger_item chk
              WHERE       chk.payment_id = ledg.payment_id
                      AND CHK.WAY_ID = 'CHK'
                      AND CHK.VOUCHER_TYPE = 'U'
                      AND ledg.company = chk.company
                      AND CHK.PARTY_TYPE_DB = 'SUPPLIER'
                      AND LEDG.IDENTITY = CHK.IDENTITY)
               CHECK_NO,
            (SELECT   chk.STATE
               FROM   IFSAPP.check_ledger_item chk
              WHERE       chk.payment_id = ledg.payment_id
                      AND CHK.WAY_ID = 'CHK'
                      AND CHK.VOUCHER_TYPE = 'U'
                      AND chk.company = ledg.company
                      AND CHK.PARTY_TYPE_DB = 'SUPPLIER'
                      AND chk.IDENTITY = ledg.IDENTITY)
               STATUS,
            (SELECT   chk.CLEAR_DATE
               FROM   IFSAPP.check_ledger_item chk
              WHERE       chk.payment_id = ledg.payment_id
                      AND CHK.WAY_ID = 'CHK'
                      AND CHK.VOUCHER_TYPE = 'U'
                      AND chk.company = ledg.company
                      AND CHK.PARTY_TYPE_DB = 'SUPPLIER'
                      AND chk.IDENTITY = ledg.IDENTITY)
               DATE_CASHED--,
--            (SELECT   chk.VOUCHER_NO
--             FROM   IFSAPP.check_ledger_item chk
--            WHERE       chk.payment_id = ledg.payment_id
--                      AND ledg.company = chk.company
--                      AND CHK.PARTY_TYPE_DB = 'SUPPLIER'
--                      AND LEDG.IDENTITY = CHK.IDENTITY)
--               CASHED_VOUCHER_NUMBER
     FROM   IFSAPP.ledger_transaction_su_qry ledg
    WHERE   ledg.ledger_item_series_id = 'SI' AND LEDG.COMPANY = 11 --and ledg.voucher_date > to_date('1/1/2004','mm/dd/yyyy') --and ledg.payment_id = 35465
    
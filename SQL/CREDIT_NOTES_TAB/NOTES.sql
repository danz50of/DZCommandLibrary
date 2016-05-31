   SELECT c.identity customer_no,
          IFSAPP.Party_Type_Customer_API.Get_Name (c.identity) customer_name,
          c.ar_balance,
          c.last_payment_date,
          c.last_payment_amount,
          c.aging1,
          c.aging2,
          c.aging3,
          c.aging4,
          c.aging5,
          c.aging6,
          DECODE (c.credit_limit, 'Not Defined', 0, c.credit_limit)
             credit_limit,
          SUBSTR (
             IFSAPP.PAYMENT_TERM_API.Get_Description (
                c.company,
                IFSAPP.IDENTITY_INVOICE_INFO_API.Get_Pay_Term_Id (c.company,
                                                                  c.identity,
                                                                  'Customer')),
             1,
             20)
             payment_terms,
          SUBSTR((SELECT TEXT FROM IFSAPP.IDENTITY_NOTE A, IFSAPP.FIN_NOTE_TEXT B
          WHERE A.IDENTITY = C.IDENTITY AND
          A.NOTE_ID = B.NOTE_ID 
          AND B.ROW_NO = 
          (SELECT MAX(C.ROW_NO) FROM IFSAPP.FIN_NOTE_TEXT C
          WHERE B.NOTE_ID = C.NOTE_ID)),0,254) NOTE
          FROM IFSAPP.credit_collection_info c, IFSAPP.identity_invoice_info i
    WHERE     i.company = c.company
          AND i.identity = c.identity
          AND i.party_type = 'Customer'
          AND I.IDENTITY = '131671'
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          SELECT TEXT FROM IDENTITY_NOTE A, FIN_NOTE_TEXT B
          WHERE A.IDENTITY = '000001' AND
          A.NOTE_ID = B.NOTE_ID 
          AND B.ROW_NO = 
          (SELECT MAX(C.ROW_NO) FROM FIN_NOTE_TEXT C, FIN_NOTE_TEXT B
          WHERE B.ROW_NO = C.ROW_NO AND B.NOTE_ID = C.NOTE_ID)
          
          
          
          
          
          
          
          SELECT * FROM IDENTITY_INVOICE_INFO
          
          SELECT * FROM IDENTITY_NOTE WHERE IDENTITY = '000001'
          
          SELECT * FROM FIN_NOTE_TEXT WHERE NOTE_ID = 949291
          
          SELECT FIN_NOTE_TEXT_API.GET_NOTE_TEXT(949291) FROM DUAL
          
          
          SELECT * FROM FIN_NOTE_TEXT --WHERE IDENTITY = '000001'
          
          
          
          
          
          (SELECT * FROM IDENTITY_NOTE A, FIN_NOTE_TEXT B
          WHERE A.IDENTITY = '157356' AND
          A.NOTE_ID = B.NOTE_ID 
          AND B.ROW_NO = 
          (SELECT MAX(C.ROW_NO) FROM FIN_NOTE_TEXT C
          WHERE B.NOTE_ID = C.NOTE_ID))
          
          SELECT MAX(ROW_NO) FROM FIN_NOTE_TEXT WHERE NOTE_ID = 944529
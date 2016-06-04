   SELECT   OP_ID,
            OP_INFO_CODE,
            EMP_NO,
            PART_NO,
            TRUNC (ACCOUNT_DATE, 'DD') AS ACCOUNT_DATE,
            WORK_CENTER_NO,
            MCH_CODE,
            ORDER_NO,
            OP_NO,
            WORK_HOURS,
            (SELECT   SUM (OP_QTY)
               FROM   IFSAPP.OP_QUANTITY B
              WHERE       A.OP_ID = B.OP_ID
                      AND A.EMP_NO = B.EMP_NO
                      AND A.ACCOUNT_DATE = B.ACCOUNT_DATE
                      AND UPPER (A.OP_INFO_CODE) = 'RUN')
               AS QTY_COMPLETED,
            (SELECT   SUM (OP_QTY)
               FROM   IFSAPP.OP_QUANTITY B
              WHERE       A.OP_ID = B.OP_ID
                      AND A.EMP_NO = B.EMP_NO
                      AND A.ACCOUNT_DATE = B.ACCOUNT_DATE
                      AND UPPER (A.OP_INFO_CODE) = 'RUN')
            / WORK_HOURS
               AS UNITS_PER_HOUR,
            (SELECT   LABOR_RUN_FACTOR
               FROM   IFSAPP.ROUTING_OPERATION C
              WHERE       C.PART_NO = A.PART_NO
                      AND CONTRACT = 'MP'
                      AND A.OP_NO = C.OPERATION_NO
                      AND PHASE_IN_DATE <= TRUNC (ACCOUNT_DATE, 'DD')
                      AND NVL (PHASE_OUT_DATE, TRUNC (SYSDATE, 'DD')) >=
                            TRUNC (ACCOUNT_DATE, 'DD')
                      AND UPPER (A.OP_INFO_CODE) = 'RUN'
                      AND C.ALTERNATIVE_NO =
                            (SELECT   SO.ROUTING_ALTERNATIVE
                               FROM   IFSAPP.SHOP_ORD SO
                              WHERE   SO.ORDER_NO = A.ORDER_NO))
               AS STANDARD_RUN,
            (SELECT   LABOR_SETUP_TIME
               FROM   IFSAPP.ROUTING_OPERATION C
              WHERE       C.PART_NO = A.PART_NO
                      AND CONTRACT = 'MP'
                      AND A.OP_NO = C.OPERATION_NO
                      AND PHASE_IN_DATE <= TRUNC (ACCOUNT_DATE, 'DD')
                      AND NVL (PHASE_OUT_DATE, TRUNC (SYSDATE, 'DD')) >=
                            TRUNC (ACCOUNT_DATE, 'DD')
                      AND UPPER (A.OP_INFO_CODE) = 'SETUP'
                      AND C.ALTERNATIVE_NO =
                            (SELECT   SO.ROUTING_ALTERNATIVE
                               FROM   IFSAPP.SHOP_ORD SO
                              WHERE   SO.ORDER_NO = A.ORDER_NO))
               AS STANDARD_SETUP,
            (SELECT   C.LABOR_RUN_FACTOR
               FROM   IFSAPP.ROUTING_OPERATION C
              WHERE       C.PART_NO = A.PART_NO
                      AND CONTRACT = 'MP'
                      AND A.OP_NO = C.OPERATION_NO
                      AND UPPER (A.OP_INFO_CODE) = 'RUN'
                      AND C.ALTERNATIVE_NO = 'LABOR')
               AS ALT_LABOR_RUN,
           (SELECT   C.LABOR_SETUP_TIME
               FROM   IFSAPP.ROUTING_OPERATION C
              WHERE       C.PART_NO = A.PART_NO
                      AND CONTRACT = 'MP'
                      AND A.OP_NO = C.OPERATION_NO
                      AND UPPER (A.OP_INFO_CODE) = 'SETUP'
                      AND C.ALTERNATIVE_NO = 'LABOR')
               AS ALT_LABOR_SETUP,
            OP_STATUS,
            (CASE
                WHEN UPPER (OP_INFO_CODE) = 'SETUP'
                THEN
                   IFSAPP.GET_TOTAL_LABOR_IRUPT (OP_ID,
                                                 'RUN',
                                                 ACCOUNT_DATE,
                                                 'INS',
                                                 emp_no)
                ELSE
                   '0'
             END)
               FIRST_PEACE_INSP,
            (  IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'DAM')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'SUP')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'OPR')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'MAC')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'OBS')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'RET')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'REG')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'RST')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'DES')
             + IFSAPP.Get_Total_Labor_SCRAP_QTY (op_id,
                                                 account_date,
                                                 emp_no,
                                                 'RUN',
                                                 'OPS'))
               TOTAL_SCRAP
     FROM   IFSAPP.OP_RESULT_SUMMARY A where order_no = '697885'
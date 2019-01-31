      SELECT CUSTOMER_NO, MONTH_YEAR,
             ROUND (
                   (  COUNT (ORDER_NO)
                    - SUM (LATE))
                 / COUNT (ORDER_NO)
                 * 100,
                 1)
                 AS ON_TIME,
             ROUND (
                   (  COUNT (ORDER_NO)
                    - SUM (LATE_1X_DAY))
                 / COUNT (ORDER_NO)
                 * 100,
                 1)
                 AS ON_TIME_X1,
             ROUND (
                   (  COUNT (ORDER_NO)
                    - SUM (LATE_5X_DAYS))
                 / COUNT (ORDER_NO)
                 * 100,
                 1)
                 AS ON_TIME_X5,
             COUNT (ORDER_NO) AS COUNT_ORDER_NO
        FROM (
     SELECT CUSTOMER_ORDER_JOIN.CUSTOMER_NO,
             CUSTOMER_ORDER_JOIN.ORDER_NO,
             TRUNC(CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE,'MM') AS MONTH_YEAR,
             MAX (
                 CASE
                     WHEN IFSAPP.prls_function_call.get_days_diff_week (
                              customer_order_join.real_ship_date,
                              customer_order_join.Planned_Ship_Date) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE,
             MAX (
                 CASE
                     WHEN (  IFSAPP.prls_function_call.get_days_diff_week (
                                 customer_order_join.real_ship_date,
                                 customer_order_join.Planned_Ship_Date)
                           - 1) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE_1X_DAY,
             MAX (
                 CASE
                     WHEN (  IFSAPP.prls_function_call.get_days_diff_week (
                                 customer_order_join.real_ship_date,
                                 customer_order_join.Planned_Ship_Date)
                           - 5) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE_5X_DAYS
        FROM IFSAPP.CUSTOMER_ORDER_JOIN CUSTOMER_ORDER_JOIN
       WHERE     ("CUSTOMER_ORDER_JOIN"."DATE_ENTERED" >=
                      TO_DATE ('01/01/2017', 'MM/DD/YYYY'))
             AND (CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE >=
                      TO_DATE ('01/01/2017', 'MM/DD/YYYY'))
    GROUP BY CUSTOMER_ORDER_JOIN.CUSTOMER_NO, CUSTOMER_ORDER_JOIN.ORDER_NO, TRUNC(CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE,'MM')        
    )GROUP BY CUSTOMER_NO, MONTH_YEAR
      HAVING   (  COUNT (ORDER_NO)
                - SUM (LATE))
             / COUNT (ORDER_NO) < 1 
             ORDER BY CUSTOMER_NO


     SELECT CUSTOMER_ORDER_JOIN.CUSTOMER_NO,
             CUSTOMER_ORDER_JOIN.ORDER_NO,
             TRUNC(CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE,'MM'),
             MAX (
                 CASE
                     WHEN IFSAPP.prls_function_call.get_days_diff_week (
                              customer_order_join.real_ship_date,
                              customer_order_join.Planned_Ship_Date) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE,
             MAX (
                 CASE
                     WHEN (  IFSAPP.prls_function_call.get_days_diff_week (
                                 customer_order_join.real_ship_date,
                                 customer_order_join.Planned_Ship_Date)
                           - 1) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE_1X_DAY,
             MAX (
                 CASE
                     WHEN (  IFSAPP.prls_function_call.get_days_diff_week (
                                 customer_order_join.real_ship_date,
                                 customer_order_join.Planned_Ship_Date)
                           - 5) > 0
                     THEN
                         1
                     ELSE
                         0
                 END)
                 AS LATE_5X_DAYS
        FROM IFSAPP.CUSTOMER_ORDER_JOIN CUSTOMER_ORDER_JOIN
       WHERE     ("CUSTOMER_ORDER_JOIN"."DATE_ENTERED" >=
                      TO_DATE ('01/01/2017', 'MM/DD/YYYY'))
             AND (CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE >=
                      TO_DATE ('01/01/2017', 'MM/DD/YYYY'))
    GROUP BY CUSTOMER_ORDER_JOIN.CUSTOMER_NO, CUSTOMER_ORDER_JOIN.ORDER_NO, TRUNC(CUSTOMER_ORDER_JOIN.REAL_SHIP_DATE,'MM')
select note_id from cust_ord_customer_ent where customer_id = '321751'



select DOCUMENT_TEXT_API.GET_NOTE_TEXT(CUST_ORD_CUSTOMER_API.GET_NOTE_ID('321751'),'CBROKER') from DUAL


select  a.address1                    address1,  
        a.address2                    address2, 
        substr(a.city,1,30)        city,  
        a.order_no                        order_num,  
        a.country_code                    country, 
        a.addr_1                          company_name,   
        substr(a.zip_code,1,10)         zip_code,  
        c.date_entered                 entered_date, 
        '1'                               hard_code,    
        substr(a.state,1,5)        state, 
        c.customer_po_no                  po_num,   
        c.ship_via_code                           ship_via,   
        case when substr(IFSAPP.get_e_mail(c.customer_no),1,50) is null then 'N' else 'Y' end notify_opton, 
        'E-MAIL'                          notification_type,  
        substr(IFSAPP.get_e_mail(c.customer_no),1,50)   e_mail_address, 
         c.state                             order_state ,
		 IFSAPP.DOCUMENT_TEXT_API.GET_NOTE_TEXT(IFSAPP.CUST_ORD_CUSTOMER_API.GET_NOTE_ID(A.CUSTOMER_NO),'CBROKER')  BROKER
    from IFSAPP.customer_order_address a,IFSAPP.customer_order c where a.order_no =  c.order_no 
    and (c.state in ('Credit Blocked','Delivered','Partially Delivered','Picked','Released','Reserved') or 
   c.state = 'Invoiced/Closed' and IFSAPP.get_max_real_ship(c.order_no) > sysdate - 7)
   and a.order_no = 'C560717'
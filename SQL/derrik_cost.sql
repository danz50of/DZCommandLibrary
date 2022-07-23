select * from ifsinfo.exploded_part_load_ALL A, IFSAPP.ROUTING_OPERATION B where A.part_in = 'VP-20275' AND B.ROUTING_REVISION =
(SELECT MAX(c.ROUTING_REVISION) FROM IFSAPP.ROUTING_OPERATION c WHERE C.PART_NO = B.PART_NO
                AND C.PHASE_IN_DATE <= SYSDATE) 
                

SELECT * FROM IFSAPP.ROUTING_OPERATION A WHERE A.PART_NO = 'VP-20275' AND
                a.ROUTING_REVISION = 
                
                
                
                SELECT * FROM PART_COST WHERE PART_NO = 'VP-20275' AND COST_SET = '2'
                
                
                SELECT * FROM ifsinfo.exploded_part_load_ALL A, IFSAPP.ROUTING_OPERATION B WHERE A.PART_IN = 'VP-20275' 
                AND B.PART_NO = A.COMPONENT_PART
                AND B.ROUTING_REVISION = (SELECT MAX(C.ROUTING_REVISION) FROM ROUTING_OPERATION C WHERE B.PART_NO = C.PART_NO) 
                ORDER BY A.LEVEL_NO, A.PART_NO, A.LINE_ITEM_NO
                
                
                select * from ifsinfo.exploded_part_load_ALL A, IFSAPP.ROUTING_OPERATION B, PART_COST D where A.part_in = 'VP-20275' AND B.ROUTING_REVISION =
(SELECT MAX(c.ROUTING_REVISION) FROM IFSAPP.ROUTING_OPERATION c WHERE C.PART_NO = B.PART_NO
                AND C.PHASE_IN_DATE <= SYSDATE) 
                AND D.PART_NO = A.PART_NO AND D.COST_SET = '2'

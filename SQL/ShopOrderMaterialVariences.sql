select a.order_no, a.part_no parent_part, a.revised_qty_due so_lot_size, b.part_no component_part, B.qty_per_assembly SO_QTY_PER, C.QTY_PER_ASSEMBLY BOM_QTY, qty_issued, qty_required so_required,
IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', B.PART_NO, '1', '*', '*') COMPONENT_COST_SET_1, ((IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', B.PART_NO, '1', '*', '*') * C.QTY_PER_ASSEMBLY) * A.REVISED_QTY_DUE) BOM_MAT_COST,
(IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', B.PART_NO, '1', '*', '*') * QTY_ISSUED) ISSUED_COST,
(IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', B.PART_NO, '1', '*', '*') * QTY_ISSUED) - ((IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', B.PART_NO, '1', '*', '*') * C.QTY_PER_ASSEMBLY) * A.REVISED_QTY_DUE) AS "ISSUED - BOM"
from ifsapp.shop_ord a, ifsapp.shop_material_alloc b, IFSINFO.DISTINCT_EXPLODED_PART_IAL C
where a.order_no = b.order_no
and a.close_date >= to_date('5/22/2015','mm/dd/yyyy')
AND C.part_IN = A.PART_NO
AND C.COMPONENT_PART = B.PART_NO




select C.PART_NO, C.EFF_PHASE_IN_DATE, C.COMPONENT_PART, C.QTY_PER_ASSEMBLY, C.ENG_CHG_LEVEL from ifsapp.manuf_structure2 C where C.part_no = 'DS-VW765-LAND'
AND C.EFF_PHASE_IN_DATE = (SELECT MAX(D.EFF_PHASE_IN_DATE) FROM IFSAPP.MANUF_STRUCTURE2 D WHERE TRUNC(D.EFF_PHASE_IN_DATE,'DD') <= TRUNC(SYSDATE,'DD') AND C.COMPONENT_PART = D.COMPONENT_PART
AND  C.PART_NO = D.PART_NO)



SELECT IFSAPP.PART_COST_API.Get_Total_Accum_Cost('MP', '520-1255', '1', '*', '*') FROM DUAL
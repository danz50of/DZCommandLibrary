SELECT RMA_NO, LINE_NO, DATE_RETURNED, 
to_char(RETURN_MATERIAL_JOIN.DATE_REQUESTED,'mm') Period,
to_char(RETURN_MATERIAL_JOIN.DATE_REQUESTED,'yyyy') Fiscal_Year,
sale_unit_price, qty_to_return, qty_returned_inv, qty_scrapped, part_no, return_reason_code, inspection_info
FROM RETURN_MATERIAL_JOIN
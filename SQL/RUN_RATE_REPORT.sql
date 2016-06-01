select * from inventory_transaction_hist_tab
where dated > to_date ('06/05/2006','mm/dd/yyyy')

select part_no, sum(qty_onhand) as QTY_ONHAND from inventory_part_in_stock_tab
where part_no = '008-0004'
group by part_no
select 'Shop Order' info_type,
       a.directive,
       a.part_no,
       a.order_no so,
       null wo_no,
       round((select sum(ext_cost) from ifsinfo.ecn_rpt_so_material2 where directive = a.directive and order_no
       = a.order_no),2) so_mat,
       round((select sum(tot_lab_and_oh2) from ifsinfo.ecn_rpt_so_labor2 where directive = a.directive and order_no
       = a.order_no),2) tot_lab_oh,
       null wo_mat,
       null wo_purchased,
       null wo_labor,
       null sga_labor,
       null cos_labor
       from ifsinfo.directive_shop_orders a
       union all
       select 'Shop Order' info_type,
       a.directive,
       a.so_part part_no,
       a.order_no so,
       null wo_no,
       round((select sum(ext_cost) from ifsinfo.ecn_rpt_so_material2 where directive = a.directive and order_no
       = a.order_no),2) so_mat,
       round((select sum(tot_lab_and_oh2) from ifsinfo.ecn_rpt_so_labor2 where directive = a.directive and order_no
       = a.order_no),2) tot_lab_oh,
       null wo_mat,
       null wo_purchased,
       null wo_labor,
       null sga_labor,
       null cos_labor
       from ifsinfo.non_fgcus_shop_ord a
           union all
 select 'Work Order' info_type,
        a.directive,
        null part_no,
        null so,
        a.wo_no,
        null so_mat,
        null tot_lab_oh,
        round((select sum(ext_cost) from ifsinfo.ecn_rpt_wo_material2 where wo_no = a.wo_no),2) wo_mat,
        round((select sum(ext_price) from ifsinfo.ecn_rpt_wo_purchases2 where wo_no = a.wo_no),2) wo_purchased,
        round((select sum(amount) from ifsinfo.ecn_time_report_cos where wo_no = a.wo_no),2) wo_labor,
        round((select sum(sga_amt) from ifsinfo.ecn_time_report_cos where wo_no = a.wo_no),2) sga_labor,
        round((select sum(cos_amt) from ifsinfo.ecn_time_report_cos where wo_no = a.wo_no),2) cos_labor
        from ifsinfo.directive_work_orders a
        order by directive, info_type,so,wo_no) ecn_work,
        (select a.CONTRACT, a.PART_NO, a.CREATE_DATE, a.LAST_ACTIVITY_DATE, a.ESTIMATED_MATERIAL_COST,
round(b.inventory_value,2) Inventory_value, c.comparison_value
from 
ifsapp.inventory_part a, inventory_part_unit_cost_sum b, INVENTORY_VALUE_COMPARATOR c
where a.part_no = b.part_no and a.contract = b.contract
and a.part_no = c.part_no and a.contract = c.contract and c.comparator_type_id = 'ESTIMATED COST'
and a.accounting_group like ('FGCUS')

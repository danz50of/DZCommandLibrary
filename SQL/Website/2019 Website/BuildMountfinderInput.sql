select 'type','value' from d6_prod_ci.displays where 1 = 0
union
SELECT 1, model FROM d6_prod_ci.displays where id >= '37484';
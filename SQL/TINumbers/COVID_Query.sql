select wo_num, task, type, request,reqdate, opendate, priority, modidate, clsdby, clsddate, dept 
from dbo.PRL_TI_REPORTING_A
where modidate >= '2020-03-16 00:03:28.000'
UNION
select wo_num, task, type, request,reqdate, opendate, priority, modidate, clsdby, clsddate, dept 
from dbo.PRL_TI_REPORTING_B
where modidate >= '2020-03-16 00:03:28.000'
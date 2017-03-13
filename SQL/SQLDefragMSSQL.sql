

--SELECT OBJECT_NAME(OBJECT_ID), index_id,index_type_desc,index_level,
--avg_fragmentation_in_percent,avg_page_space_used_in_percent,page_count
SELECT OBJECT_NAME(OBJECT_ID), index_id,index_type_desc,index_level,
avg_fragmentation_in_percent,avg_page_space_used_in_percent,page_count
FROM sys.dm_db_index_physical_stats
(DB_ID(N'TRACKIT_DATA'), NULL, NULL, NULL , 'SAMPLED')
ORDER BY avg_fragmentation_in_percent DESC



SELECT DISTINCT OBJECT_NAME(object_id), object_ID 
FROM master.sys.objects;  
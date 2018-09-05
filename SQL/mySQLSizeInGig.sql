SELECT ((data_length+index_length)/1073741824) tablesize
FROM information_schema.tables
WHERE table_schema='analytics' and table_name='Company_Sales';

/*Command to see how much AWS space is used on a given table*/
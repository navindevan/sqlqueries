--Query to identify long running queries

SELECT TEXT, 
SUBSTRING(st.TEXT, (qs.statement_start_offset/2)+1, 
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(st.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS statement_text,
* FROM sys.dm_exec_requests qs
cross apply sys.dm_exec_sql_text(sql_handle) st
cross apply sys.dm_exec_query_plan(plan_handle);
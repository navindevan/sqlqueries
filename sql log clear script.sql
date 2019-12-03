--================================================================================================
SELECT 
      'USE [' + d.name + N']' + CHAR(13) + CHAR(10) 
    + 'DBCC SHRINKFILE (N''' + mf.name + N''' , 0, TRUNCATEONLY)' 
    + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
FROM 
         sys.master_files mf 
    JOIN sys.databases d 
        ON mf.database_id = d.database_id 
WHERE d.database_id > 4;

set nocount on  
SELECT 
      'USE [' + d.name + N']' + CHAR(13) + CHAR(10) 
    + 'DBCC SHRINKFILE (N''' + mf.name + N''' , 0, TRUNCATEONLY)' 
    + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
FROM 
         sys.master_files mf 
    JOIN sys.databases d 
        ON mf.database_id = d.database_id 
WHERE d.database_id > 4 and mf.type_desc = 'LOG'

--================================================================================================
declare @db varchar(255)
declare c cursor for
select name from sys.databases where is_read_only=0 and state=0
  and name not in ('master','model','tempdb','msdb')
open c
fetch c into @db
while @@fetch_status=0
begin
  exec SP_dboption @db,'trunc. log on chkpt.','true' 
  DBCC shrinkdatabase (@db)
  fetch next from c into @db
end
close c
deallocate c
--================================================================================================

--Find oldest transaction
DBCC OPENTRAN

-- Get input buffer for a SPID
DBCC INPUTBUFFER(115) -- Substitute the SPID number from above

Use [Tempdb]

GO

SELECT name AS 'File Name' , physical_name AS 'Physical Name', size/128 AS 'Total Size in MB', size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS 'Available Space In MB', * FROM sys.database_files;

USE [tempdb]
GO
DBCC SHRINKFILE (N'temp2' , 0, TRUNCATEONLY)
GO

USE [tempdb]
GO
DBCC SHRINKFILE (N'tempdev' , 1024)
GO

USE [tempdb]
GO
CHECKPOINT

use tempdb
GO
SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
GO
DBCC FREEPROCCACHE -- clean cache
DBCC DROPCLEANBUFFERS -- clean buffers
DBCC FREESYSTEMCACHE ('ALL') -- clean system cache
DBCC FREESESSIONCACHE -- clean session cache
DBCC SHRINKDATABASE(tempdb, 10); -- shrink tempdb
dbcc shrinkfile ('tempdev') -- shrink default db file
dbcc shrinkfile ('templog') -- shrink db file tempdev2
dbcc shrinkfile ('temp2') -- shrink db file tempdev3
dbcc shrinkfile ('temp3') -- shrink db file tempdev4
dbcc shrinkfile ('temp4') -- shrink log file
dbcc shrinkfile ('temp5') -- shrink log file
dbcc shrinkfile ('temp6') -- shrink log file
dbcc shrinkfile ('temp7') -- shrink log file
dbcc shrinkfile ('temp8') -- shrink log file
dbcc shrinkfile ('temp9') -- shrink log file
dbcc shrinkfile ('templog1') -- shrink log file
dbcc shrinkfile ('tempdev2') -- shrink log file

GO
--DROP PROCEDURE usp_String_or_binary_data_truncated
--GO
CREATE PROCEDURE usp_String_or_binary_data_truncated
@String VARCHAR(MAX)
AS
 
DECLARE @VARCHAR AS VARCHAR(MAX)
DECLARE @Xml AS XML
DECLARE @TCount AS INT
SET @String= REPLACE(REPLACE(REPLACE(REPLACE(@String,'''','')
             ,'[',''),']',''),CHAR(13) + CHAR(10),'')
SET @Xml = CAST(('<a>'+REPLACE(@String,'(','</a><a>')
           +'</a>') AS XML)
 
SELECT @TCount=COUNT(*)
FROM @Xml.nodes('A') AS FN(A)
 
;WITH CTE AS
     (SELECT
     (CASE
     WHEN (CHARINDEX('INSERT INTO',A.value('.', 'varchar(max)'))>0)
     THEN 1
     WHEN CHARINDEX('VALUES',A.value('.', 'varchar(max)'))>0
     THEN 2
     WHEN (CHARINDEX('INSERT INTO',A.value('.', 'varchar(max)'))=0
     AND CHARINDEX('VALUES',A.value('.', 'varchar(max)'))=0)
     AND @TCount=2  THEN 2
     WHEN (CHARINDEX('INSERT INTO',A.value('.', 'varchar(max)'))=0
     AND CHARINDEX('VALUES',A.value('.', 'varchar(max)'))=0)
     AND @TCount=3  THEN 3
     END) AS[Batch Number],
     REPLACE(REPLACE(A.value('.', 'varchar(max)')
     ,'INSERT INTO',''),'VALUES ','') AS [Column]
     FROM @Xml.nodes('A') AS FN(A))
 
, [CTE2] AS
(
    SELECT
    [Batch Number],
    CAST('' + REPLACE([Column], ',' , '')
    + '' AS XML)
    AS [Column name And Data]
    FROM  [CTE]
)
,[CTE3] AS
(
    SELECT [Batch Number],
    ROW_NUMBER() OVER(PARTITION BY [Batch Number]
    ORDER BY [Batch Number] DESC) AS [Row Number],
    Split.a.value('.', 'VARCHAR(MAX)') AS [Column name And Data]
FROM [CTE2]
CROSS APPLY [Column name And Data].nodes('/M')Split(A))
 
SELECT
 ISNULL(B.[Column name And Data],C.name) AS [Column Name]
,A.[Column name And Data] AS [Column Data]
,C.max_length As [Column Length]
,DATALENGTH(A.[Column name And Data])
AS [Column Data Length]
 
FROM [CTE3] A
LEFT JOIN [CTE3] B
ON A.[Batch Number]=2 AND B.[Batch Number]=3
AND A.[Row Number] =B.[Row Number]
LEFT JOIN sys.columns C
ON C.object_id =(
    SELECT object_ID(LTRIM(RTRIM([Column name And Data])))
    FROM [CTE3] WHERE [Batch Number]=1
)
AND (C.name = B.[Column name And Data]
OR  (C.column_id =A.[Row Number]
And A.[Batch Number]<>1))
WHERE a.[Batch Number] <>1
AND DATALENGTH(A.[Column name And Data]) >C.max_length
AND C.system_type_id IN (167,175,231,239)
AND C.max_length>0
 
GO
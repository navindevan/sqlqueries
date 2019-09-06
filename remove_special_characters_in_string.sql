DECLARE @str AS NVARCHAR(1000)  = 'Navee#@!n K#um@ar@123'
DECLARE @aplval AS VARCHAR(50) = '%[^a-z A-Z 0-9]%'
WHILE PATINDEX(@aplval, @str) > 0
SET @str = Stuff(@str, PatIndex(@aplval, @str), 1, '')
SELECT @str
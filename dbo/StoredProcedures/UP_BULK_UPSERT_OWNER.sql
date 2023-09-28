CREATE PROCEDURE [DBO].[UP_BULK_UPSERT_OWNER]
(
@P__JSON_CONTENT AS NVARCHAR(MAX)
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
----------------------
DECLARE @V__LIST_IDs TABLE(ID INT)

DECLARE @V__OWNER_ID AS INT
DECLARE @V__CODE AS NVARCHAR(50)
DECLARE @V__MAINTENANCE_DUE_DATE AS NVARCHAR(20)
DECLARE @V__DESCRIPTION AS NVARCHAR(200)
DECLARE @V__ENTRY_DATE AS NVARCHAR(40)
----------------------
DECLARE CURSOR_JSON_DATA CURSOR FOR
SELECT
OWNER_ID,
CODE,
MAINTENANCE_DUE_DATE,
DESCRIPTION,
ENTRY_DATE
FROM OPENJSON (@P__JSON_CONTENT)
WITH
(
OWNER_ID INT '$.OWNER_ID',
CODE NVARCHAR(50) '$.CODE',
MAINTENANCE_DUE_DATE NVARCHAR(20) '$.MAINTENANCE_DUE_DATE',
DESCRIPTION NVARCHAR(200) '$.DESCRIPTION',
ENTRY_DATE NVARCHAR(40) '$.ENTRY_DATE'
)
OPEN CURSOR_JSON_DATA
FETCH NEXT FROM CURSOR_JSON_DATA into @V__OWNER_ID, @V__CODE,@V__MAINTENANCE_DUE_DATE,@V__DESCRIPTION,@V__ENTRY_DATE
WHILE @@FETCH_STATUS = 0
BEGIN
EXEC UPG_EDIT_OWNER @V__OWNER_ID OUTPUT, @V__CODE,@V__MAINTENANCE_DUE_DATE,@V__DESCRIPTION,@V__ENTRY_DATE
INSERT INTO @V__LIST_IDs(ID) VALUES(@V__OWNER_ID)
FETCH NEXT FROM CURSOR_JSON_DATA into @V__OWNER_ID, @V__CODE,@V__MAINTENANCE_DUE_DATE,@V__DESCRIPTION,@V__ENTRY_DATE
END
CLOSE CURSOR_JSON_DATA;
DEALLOCATE CURSOR_JSON_DATA

----------------------
DECLARE @V__IDs AS VARCHAR(8000)
SET @V__IDs = ''
SELECT @V__IDs = @V__IDs + CAST(ID AS NVARCHAR(10)) + ','
FROM   @V__LIST_IDs

EXEC UPG_GET_OWNER_BY_OWNER_ID_LIST @V__IDs
----------------------
END

GO

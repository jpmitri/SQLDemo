CREATE FUNCTION [DBO].[UDFG_GET_OWNER_BY_WHERE]
(
@P__OWNER_ID INT,
@P__CODE NVARCHAR(50),
@P__DESCRIPTION NVARCHAR(200)
)
RETURNS @P__TABLE_OWNER TABLE 
(
[OWNER_ID] INT,
[CODE] NVARCHAR(50),
[MAINTENANCE_DUE_DATE] NVARCHAR(20),
[DESCRIPTION] NVARCHAR(200),
[ENTRY_DATE] NVARCHAR(40)
)
AS
BEGIN
---------------------------------

-- DECLARATION SECTION
----------------------------
DECLARE @V__CODE AS NVARCHAR(50)
DECLARE @V__DESCRIPTION AS NVARCHAR(200)
----------------------------

----------------------------

SET @V__CODE = COALESCE(@P__CODE,'')
SET @V__CODE = '%' + @V__CODE + '%'


SET @V__DESCRIPTION = COALESCE(@P__DESCRIPTION,'')
SET @V__DESCRIPTION = '%' + @V__DESCRIPTION + '%';

WITH DATAENTRIES
AS
(
SELECT
[T].*
FROM  [DBO].[TBL_OWNER] [T]  WITH (NOLOCK)
WHERE 
(COALESCE([CODE],'') LIKE @V__CODE) AND 
(COALESCE([DESCRIPTION],'') LIKE @V__DESCRIPTION) 
AND   [OWNER_ID] = @P__OWNER_ID
)
---------------------------------


----------------------------
INSERT INTO @P__TABLE_OWNER
SELECT 	
[OWNER_ID],
[CODE],
CAST([MAINTENANCE_DUE_DATE] AS NVARCHAR) [MAINTENANCE_DUE_DATE],
[DESCRIPTION],
CONVERT(VARCHAR,[ENTRY_DATE], 126) [ENTRY_DATE]
FROM    DATAENTRIES 
----------------------------
RETURN
---------------------------------
---------------------------------
END

GO


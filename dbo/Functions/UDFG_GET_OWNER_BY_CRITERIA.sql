CREATE FUNCTION [DBO].[UDFG_GET_OWNER_BY_CRITERIA]
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



----------------------------
INSERT INTO @P__TABLE_OWNER
SELECT *
FROM [DBO].[UDFG_GET_OWNER_BY_WHERE]
(
@P__OWNER_ID,
@P__CODE,
@P__DESCRIPTION
)
----------------------------

----------------------------
RETURN
---------------------------------
---------------------------------
END

GO


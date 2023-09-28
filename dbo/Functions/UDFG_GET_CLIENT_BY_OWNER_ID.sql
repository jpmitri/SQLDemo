CREATE FUNCTION [DBO].[UDFG_GET_CLIENT_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
RETURNS @P__TABLE_CLIENT TABLE 
(
[CLIENT_ID] BIGINT,
[NAME] NVARCHAR(50),
[FAMILY_NAME] NVARCHAR(50),
[DOB] NVARCHAR(20),
[ENTRY_USER_ID] BIGINT,
[ENTRY_DATE] NVARCHAR(20),
[OWNER_ID] INT
)
AS
BEGIN
-------------------------------
INSERT INTO @P__TABLE_CLIENT 
SELECT
[CLIENT_ID],
[NAME],
[FAMILY_NAME],
CAST([DOB] AS NVARCHAR) [DOB],
[ENTRY_USER_ID],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[OWNER_ID]
FROM [TBL_CLIENT]  WITH (NOLOCK)
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------

-------------------------------
RETURN
-------------------------------
END

GO

CREATE FUNCTION [DBO].[UDFG_GET_UPLOADED_FILE_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
RETURNS @P__TABLE_UPLOADED_FILE TABLE 
(
[UPLOADED_FILE_ID] BIGINT,
[REL_ENTITY] NVARCHAR(50),
[REL_KEY] BIGINT,
[REL_FIELD] NVARCHAR(50),
[SIZE] INT,
[EXTENSION] NVARCHAR(50),
[STAMP] NVARCHAR(100),
[ENTRY_USER_ID] BIGINT,
[ENTRY_DATE] NVARCHAR(20),
[OWNER_ID] INT
)
AS
BEGIN
-------------------------------
INSERT INTO @P__TABLE_UPLOADED_FILE 
SELECT
[UPLOADED_FILE_ID],
[REL_ENTITY],
[REL_KEY],
[REL_FIELD],
[SIZE],
[EXTENSION],
[STAMP],
[ENTRY_USER_ID],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[OWNER_ID]
FROM [TBL_UPLOADED_FILE]  WITH (NOLOCK)
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------

-------------------------------
RETURN
-------------------------------
END

GO

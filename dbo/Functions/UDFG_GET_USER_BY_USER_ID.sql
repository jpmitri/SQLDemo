CREATE FUNCTION [DBO].[UDFG_GET_USER_BY_USER_ID]
(
@P__USER_ID BIGINT
)
RETURNS @P__TABLE_USER TABLE 
(
[USER_ID] BIGINT,
[OWNER_ID] INT,
[USERNAME] NVARCHAR(100),
[PASSWORD] NVARCHAR(1000),
[USER_TYPE_CODE] NVARCHAR(50),
[IS_ACTIVE] BIT,
[ENTRY_DATE] NVARCHAR(20)
)
AS
BEGIN
--------------------------------------
INSERT INTO @P__TABLE_USER
SELECT
[USER_ID],
[OWNER_ID],
[USERNAME],
[PASSWORD],
[USER_TYPE_CODE],
[IS_ACTIVE],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE]
FROM    [TBL_USER] [USER]  WITH (NOLOCK)
WHERE   [USER].[USER_ID] = @P__USER_ID
--------------------------------------

--------------------------------------
RETURN
--------------------------------------
END

GO


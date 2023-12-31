CREATE FUNCTION [DBO].[UDFG_GET_ACCOUNT_BY_OWNER_ID_ADV]
(
@P__OWNER_ID INT
)
RETURNS @P__TABLE_ACCOUNT TABLE 
(
[ACCOUNT_ID] BIGINT,
[CURRENCY] NVARCHAR(50),
[TITLE] NVARCHAR(50),
[AMMOUNT] DECIMAL(18,2),
[ENTRY_USER_ID] BIGINT,
[ENTRY_DATE] NVARCHAR(20),
[OWNER_ID] INT
)
AS
BEGIN
-------------------------------
INSERT INTO @P__TABLE_ACCOUNT 
SELECT
[ACCOUNT].[ACCOUNT_ID],
[ACCOUNT].[CURRENCY],
[ACCOUNT].[TITLE],
[ACCOUNT].[AMMOUNT],
[ACCOUNT].[ENTRY_USER_ID],
CAST([ACCOUNT].[ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[ACCOUNT].[OWNER_ID]
FROM [TBL_ACCOUNT] [ACCOUNT]  WITH (NOLOCK)
WHERE 
[ACCOUNT].OWNER_ID = @P__OWNER_ID
-------------------------------

-------------------------------
RETURN
-------------------------------
END

GO


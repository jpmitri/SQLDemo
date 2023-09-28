CREATE FUNCTION [DBO].[UDFG_GET_CUSTOMER_ACCOUNT_BY_CUSTOMER_ID]
(
@P__CUSTOMER_ID BIGINT
)
RETURNS @P__TABLE_CUSTOMER_ACCOUNT TABLE 
(
[CUSTOMER_ACCOUNT_ID] BIGINT,
[CUSTOMER_ID] BIGINT,
[ACCOUNT_ID] BIGINT,
[ENTRY_USER_ID] BIGINT,
[ENTRY_DATE] NVARCHAR(20),
[OWNER_ID] INT,
[DESCRIPTION] NVARCHAR(MAX)
)
AS
BEGIN
-------------------------------
INSERT INTO @P__TABLE_CUSTOMER_ACCOUNT 
SELECT
[CUSTOMER_ACCOUNT_ID],
[CUSTOMER_ID],
[ACCOUNT_ID],
[ENTRY_USER_ID],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[OWNER_ID],
[DESCRIPTION]
FROM [TBL_CUSTOMER_ACCOUNT]  WITH (NOLOCK)
WHERE 
CUSTOMER_ID = @P__CUSTOMER_ID
-------------------------------

-------------------------------
RETURN
-------------------------------
END

GO


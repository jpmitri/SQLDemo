CREATE FUNCTION [DBO].[UDFG_GET_ACCOUNT_BY_ACCOUNT_ID_LIST]
(
@P__ACCOUNT_ID_LIST VARCHAR(8000)
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
--------------------------------------
INSERT INTO @P__TABLE_ACCOUNT
SELECT
[ACCOUNT_ID],
[CURRENCY],
[TITLE],
[AMMOUNT],
[ENTRY_USER_ID],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[OWNER_ID]
FROM [TBL_ACCOUNT] [ACCOUNT]  WITH (NOLOCK)
WHERE
(
 (
LEN(@P__ACCOUNT_ID_LIST) = 0
 )
 OR 
 (
[ACCOUNT].ACCOUNT_ID IN (SELECT [PART_VALUE] FROM [DBO].[UDF_SPLIT](',',@P__ACCOUNT_ID_LIST))
 )
)
----------------------------

----------------------------
RETURN
----------------------------
END

GO


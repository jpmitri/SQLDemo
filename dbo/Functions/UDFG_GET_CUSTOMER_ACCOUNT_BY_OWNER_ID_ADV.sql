CREATE FUNCTION [DBO].[UDFG_GET_CUSTOMER_ACCOUNT_BY_OWNER_ID_ADV]
(
@P__OWNER_ID INT
)
RETURNS @P__TABLE_CUSTOMER_ACCOUNT TABLE 
(
[CUSTOMER_ACCOUNT_ID] BIGINT,
[CUSTOMER_ID] BIGINT,
[ACCOUNT_ID] BIGINT,
[ENTRY_USER_ID] BIGINT,
[ENTRY_DATE] NVARCHAR(20),
[OWNER_ID] INT,
[DESCRIPTION] NVARCHAR(MAX),
[T_ACCOUNT_ACCOUNT_ID] BIGINT,
[T_ACCOUNT_CURRENCY] NVARCHAR(50),
[T_ACCOUNT_TITLE] NVARCHAR(50),
[T_ACCOUNT_AMMOUNT] DECIMAL(18,2),
[T_ACCOUNT_ENTRY_USER_ID] BIGINT,
[T_ACCOUNT_ENTRY_DATE] NVARCHAR(40),
[T_ACCOUNT_OWNER_ID] INT
)
AS
BEGIN
-------------------------------
INSERT INTO @P__TABLE_CUSTOMER_ACCOUNT 
SELECT
[CUSTOMER_ACCOUNT].[CUSTOMER_ACCOUNT_ID],
[CUSTOMER_ACCOUNT].[CUSTOMER_ID],
[CUSTOMER_ACCOUNT].[ACCOUNT_ID],
[CUSTOMER_ACCOUNT].[ENTRY_USER_ID],
CAST([CUSTOMER_ACCOUNT].[ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE],
[CUSTOMER_ACCOUNT].[OWNER_ID],
[CUSTOMER_ACCOUNT].[DESCRIPTION],
[T_ACCOUNT].[ACCOUNT_ID] [T_ACCOUNT_ACCOUNT_ID] ,
[T_ACCOUNT].[CURRENCY] [T_ACCOUNT_CURRENCY] ,
[T_ACCOUNT].[TITLE] [T_ACCOUNT_TITLE] ,
[T_ACCOUNT].[AMMOUNT] [T_ACCOUNT_AMMOUNT] ,
[T_ACCOUNT].[ENTRY_USER_ID] [T_ACCOUNT_ENTRY_USER_ID] ,
CAST([T_ACCOUNT].[ENTRY_DATE] AS NVARCHAR)  [T_ACCOUNT_ENTRY_DATE] ,
[T_ACCOUNT].[OWNER_ID] [T_ACCOUNT_OWNER_ID] 
FROM [TBL_CUSTOMER_ACCOUNT] [CUSTOMER_ACCOUNT]  WITH (NOLOCK)
OUTER APPLY [DBO].[UDFG_GET_ACCOUNT_BY_ACCOUNT_ID]([CUSTOMER_ACCOUNT].[ACCOUNT_ID])      [T_ACCOUNT]
WHERE 
[CUSTOMER_ACCOUNT].OWNER_ID = @P__OWNER_ID
-------------------------------

-------------------------------
RETURN
-------------------------------
END

GO


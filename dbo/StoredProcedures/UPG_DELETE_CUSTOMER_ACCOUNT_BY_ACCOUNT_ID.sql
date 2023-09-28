CREATE PROCEDURE [DBO].[UPG_DELETE_CUSTOMER_ACCOUNT_BY_ACCOUNT_ID]
(
@P__ACCOUNT_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_CUSTOMER_ACCOUNT]
WHERE 
ACCOUNT_ID = @P__ACCOUNT_ID
-------------------------------
END

GO

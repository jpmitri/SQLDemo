CREATE PROCEDURE [DBO].[UPG_DELETE_ACCOUNT]
(
@P__ACCOUNT_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
DELETE
FROM [TBL_ACCOUNT]
WHERE  ACCOUNT_ID = @P__ACCOUNT_ID 
----------------------------
END

GO


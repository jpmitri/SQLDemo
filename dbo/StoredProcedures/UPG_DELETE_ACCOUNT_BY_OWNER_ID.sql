CREATE PROCEDURE [DBO].[UPG_DELETE_ACCOUNT_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_ACCOUNT]
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------
END

GO


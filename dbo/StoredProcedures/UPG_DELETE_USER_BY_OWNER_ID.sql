CREATE PROCEDURE [DBO].[UPG_DELETE_USER_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_USER]
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------
END

GO


CREATE PROCEDURE [DBO].[UPG_DELETE_CLIENT_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_CLIENT]
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------
END

GO


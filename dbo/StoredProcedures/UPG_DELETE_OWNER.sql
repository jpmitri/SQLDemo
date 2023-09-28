CREATE PROCEDURE [DBO].[UPG_DELETE_OWNER]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
DELETE
FROM [TBL_OWNER]
WHERE  OWNER_ID = @P__OWNER_ID 
----------------------------
END

GO


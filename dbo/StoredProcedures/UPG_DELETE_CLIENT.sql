CREATE PROCEDURE [DBO].[UPG_DELETE_CLIENT]
(
@P__CLIENT_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
DELETE
FROM [TBL_CLIENT]
WHERE  CLIENT_ID = @P__CLIENT_ID 
----------------------------
END

GO


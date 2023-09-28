CREATE PROCEDURE [DBO].[UPG_DELETE_USER]
(
@P__USER_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
DELETE
FROM [TBL_USER]
WHERE  USER_ID = @P__USER_ID 
----------------------------
END

GO


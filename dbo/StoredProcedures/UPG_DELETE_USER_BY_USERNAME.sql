CREATE PROCEDURE [DBO].[UPG_DELETE_USER_BY_USERNAME]
(
@P__USERNAME NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_USER]
WHERE 
USERNAME = @P__USERNAME
-------------------------------
END

GO


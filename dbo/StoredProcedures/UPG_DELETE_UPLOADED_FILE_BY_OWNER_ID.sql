CREATE PROCEDURE [DBO].[UPG_DELETE_UPLOADED_FILE_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_UPLOADED_FILE]
WHERE 
OWNER_ID = @P__OWNER_ID
-------------------------------
END

GO


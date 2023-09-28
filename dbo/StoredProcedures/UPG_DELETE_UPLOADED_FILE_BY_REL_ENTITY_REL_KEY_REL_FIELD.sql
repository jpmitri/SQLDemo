CREATE PROCEDURE [DBO].[UPG_DELETE_UPLOADED_FILE_BY_REL_ENTITY_REL_KEY_REL_FIELD]
(
@P__REL_ENTITY NVARCHAR(100),
@P__REL_KEY BIGINT,
@P__REL_FIELD NVARCHAR(100)
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
DELETE
FROM [TBL_UPLOADED_FILE]
WHERE 
REL_ENTITY = @P__REL_ENTITY AND
REL_KEY = @P__REL_KEY AND
REL_FIELD = @P__REL_FIELD
-------------------------------
END

GO


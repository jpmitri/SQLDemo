CREATE PROCEDURE [DBO].[UPG_EDIT_UPLOADED_FILE]
(
@P__UPLOADED_FILE_ID BIGINT OUTPUT,
@P__REL_ENTITY NVARCHAR(50),
@P__REL_KEY BIGINT,
@P__REL_FIELD NVARCHAR(50),
@P__SIZE INT,
@P__EXTENSION NVARCHAR(50),
@P__STAMP NVARCHAR(100),
@P__ENTRY_USER_ID BIGINT,
@P__ENTRY_DATE NVARCHAR(20),
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
IF (@P__UPLOADED_FILE_ID = -1)
BEGIN
INSERT INTO [TBL_UPLOADED_FILE] 
(
REL_ENTITY,
REL_KEY,
REL_FIELD,
SIZE,
EXTENSION,
STAMP,
ENTRY_USER_ID,
ENTRY_DATE,
OWNER_ID
)
VALUES
(
@P__REL_ENTITY,
@P__REL_KEY,
@P__REL_FIELD,
@P__SIZE,
@P__EXTENSION,
@P__STAMP,
@P__ENTRY_USER_ID,
CAST(@P__ENTRY_DATE AS DATE),
@P__OWNER_ID
)
SET @P__UPLOADED_FILE_ID = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE [TBL_UPLOADED_FILE]
SET
[REL_ENTITY] = @P__REL_ENTITY,
[REL_KEY] = @P__REL_KEY,
[REL_FIELD] = @P__REL_FIELD,
[SIZE] = @P__SIZE,
[EXTENSION] = @P__EXTENSION,
[STAMP] = @P__STAMP,
[ENTRY_USER_ID] = @P__ENTRY_USER_ID,
[ENTRY_DATE] = CAST(@P__ENTRY_DATE AS DATE),
[OWNER_ID] = @P__OWNER_ID
WHERE UPLOADED_FILE_ID = @P__UPLOADED_FILE_ID
END
----------------------------
END

GO


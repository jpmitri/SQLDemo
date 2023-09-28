CREATE PROCEDURE [DBO].[UPG_EDIT_CLIENT]
(
@P__CLIENT_ID BIGINT OUTPUT,
@P__NAME NVARCHAR(50),
@P__FAMILY_NAME NVARCHAR(50),
@P__DOB NVARCHAR(20),
@P__ENTRY_USER_ID BIGINT,
@P__ENTRY_DATE NVARCHAR(20),
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
IF (@P__CLIENT_ID = -1)
BEGIN
INSERT INTO [TBL_CLIENT] 
(
NAME,
FAMILY_NAME,
DOB,
ENTRY_USER_ID,
ENTRY_DATE,
OWNER_ID
)
VALUES
(
@P__NAME,
@P__FAMILY_NAME,
CAST(@P__DOB AS DATE),
@P__ENTRY_USER_ID,
CAST(@P__ENTRY_DATE AS DATE),
@P__OWNER_ID
)
SET @P__CLIENT_ID = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE [TBL_CLIENT]
SET
[NAME] = @P__NAME,
[FAMILY_NAME] = @P__FAMILY_NAME,
[DOB] = CAST(@P__DOB AS DATE),
[ENTRY_USER_ID] = @P__ENTRY_USER_ID,
[ENTRY_DATE] = CAST(@P__ENTRY_DATE AS DATE),
[OWNER_ID] = @P__OWNER_ID
WHERE CLIENT_ID = @P__CLIENT_ID
END
----------------------------
END

GO

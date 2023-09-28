CREATE PROCEDURE [DBO].[UPG_GET_USER_BY_USER_ID_LIST]
(
@P__USER_ID_LIST VARCHAR(8000)
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM [DBO].[UDFG_GET_USER_BY_USER_ID_LIST]
(
@P__USER_ID_LIST
)
----------------------------
END

GO


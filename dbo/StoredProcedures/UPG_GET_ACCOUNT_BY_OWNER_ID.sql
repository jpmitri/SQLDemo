CREATE PROCEDURE [DBO].[UPG_GET_ACCOUNT_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
SELECT *
FROM [DBO].[UDFG_GET_ACCOUNT_BY_OWNER_ID]
(
@P__OWNER_ID
)
-------------------------------
END

GO


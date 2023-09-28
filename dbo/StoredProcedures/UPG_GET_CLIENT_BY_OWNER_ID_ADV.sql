CREATE PROCEDURE [DBO].[UPG_GET_CLIENT_BY_OWNER_ID_ADV]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
SELECT *
FROM [DBO].[UDFG_GET_CLIENT_BY_OWNER_ID_ADV]
(
@P__OWNER_ID
)
-------------------------------
END

GO


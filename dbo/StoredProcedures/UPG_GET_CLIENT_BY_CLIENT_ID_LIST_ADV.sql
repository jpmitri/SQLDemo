CREATE PROCEDURE [DBO].[UPG_GET_CLIENT_BY_CLIENT_ID_LIST_ADV]
(
@P__CLIENT_ID_LIST VARCHAR(8000)
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [DBO].[UDFG_GET_CLIENT_BY_CLIENT_ID_LIST_ADV]
(
@P__CLIENT_ID_LIST
)
----------------------------
END

GO


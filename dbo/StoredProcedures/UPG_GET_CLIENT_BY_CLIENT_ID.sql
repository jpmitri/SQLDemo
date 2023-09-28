CREATE PROCEDURE [DBO].[UPG_GET_CLIENT_BY_CLIENT_ID]
(
@P__CLIENT_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [dbo].[UDFG_GET_CLIENT_BY_CLIENT_ID](@P__CLIENT_ID)
----------------------------
END

GO


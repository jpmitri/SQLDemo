CREATE PROCEDURE [DBO].[UPG_GET_OWNER_BY_OWNER_ID]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [dbo].[UDFG_GET_OWNER_BY_OWNER_ID](@P__OWNER_ID)
----------------------------
END

GO


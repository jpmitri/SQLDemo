CREATE PROCEDURE [DBO].[UPG_GET_USER_BY_USER_ID]
(
@P__USER_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [dbo].[UDFG_GET_USER_BY_USER_ID](@P__USER_ID)
----------------------------
END

GO


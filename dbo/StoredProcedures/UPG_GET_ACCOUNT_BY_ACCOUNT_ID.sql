CREATE PROCEDURE [DBO].[UPG_GET_ACCOUNT_BY_ACCOUNT_ID]
(
@P__ACCOUNT_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [dbo].[UDFG_GET_ACCOUNT_BY_ACCOUNT_ID](@P__ACCOUNT_ID)
----------------------------
END

GO


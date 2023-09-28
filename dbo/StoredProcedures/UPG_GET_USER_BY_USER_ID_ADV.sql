CREATE PROCEDURE [DBO].[UPG_GET_USER_BY_USER_ID_ADV]
(
@P__USER_ID BIGINT
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT * 
FROM [DBO].[UDFG_GET_USER_BY_USER_ID_ADV](@P__USER_ID)
----------------------------
END

GO


CREATE PROCEDURE [DBO].[UPG_GET_USER_BY_USERNAME]
(
@P__USERNAME NVARCHAR(200)
)
AS
BEGIN
SET NOCOUNT ON
-------------------------------
SELECT *
FROM [DBO].[UDFG_GET_USER_BY_USERNAME]
(
@P__USERNAME
)
-------------------------------
END

GO


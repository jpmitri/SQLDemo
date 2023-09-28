CREATE PROCEDURE [dbo].[UP_CHECK_USER_EXISTENCE]
(
 @P__OWNER_ID	INT,
 @P__USERNAME	NVARCHAR(100),
 @P__EXISTS     BIT OUTPUT
)
AS
BEGIN
	-------------------------------
	SELECT @P__EXISTS = COALESCE(COUNT(*),0)
	FROM   [TBL_USER] 
	WHERE  [OWNER_ID] = @P__OWNER_ID 
	AND    [USERNAME]  = @P__USERNAME 	
	-------------------------------
END

GO


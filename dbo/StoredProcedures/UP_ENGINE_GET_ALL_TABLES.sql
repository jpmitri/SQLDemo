CREATE PROCEDURE [DBO].[UP_ENGINE_GET_ALL_TABLES]
AS
BEGIN
	
	---------------------------------
	SELECT 
	      '[' + INFORMATION_SCHEMA.TABLES.TABLE_NAME + ']' [TABLE_NAME]
	FROM  INFORMATION_SCHEMA.TABLES 
	WHERE SUBSTRING([TABLE_NAME],1,4) = 'TBL_'
	AND   [TABLE_NAME] <> 'TBL_SETUP'
	AND   [TABLE_NAME] <> 'TBL_INC'
	---------------------------------
END

GO


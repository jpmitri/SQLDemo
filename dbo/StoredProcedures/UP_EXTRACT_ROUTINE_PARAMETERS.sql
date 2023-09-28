CREATE PROCEDURE UP_EXTRACT_ROUTINE_PARAMETERS
	(
		@P__ROUTINE_NAME AS NVARCHAR(200)
	)
AS
BEGIN

	-----------------------------------------------
	DECLARE @V__FULL_CMD AS  NVARCHAR(MAX)
	DECLARE @V_TABLE_ROUTINE_PARAMETER TABLE 
							  (
								ROUTINE_NAME NVARCHAR(200),
								PARAM_NAME  NVARCHAR(200),
								PARAM_TYPE  NVARCHAR(200),
								IS_OUTPUT   BIT
							  )
	-----------------------------------------------

	-- GET PARAMETERS
	-----------------------------------------------
	INSERT INTO @V_TABLE_ROUTINE_PARAMETER
	SELECT  
		 @P__ROUTINE_NAME 'ROUTINE_NAME',
		'PARAMETER_NAME' = NAME,  
		'TYPE'   = TYPE_NAME(USER_TYPE_ID),
		IS_OUTPUT
	FROM SYS.PARAMETERS WHERE OBJECT_ID = OBJECT_ID(@P__ROUTINE_NAME)
	-----------------------------------------------

	-----------------------------------------------
	SELECT *
	FROM   @V_TABLE_ROUTINE_PARAMETER 
	-----------------------------------------------

END

GO


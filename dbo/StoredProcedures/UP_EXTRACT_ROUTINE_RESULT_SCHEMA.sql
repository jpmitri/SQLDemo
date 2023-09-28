CREATE PROCEDURE UP_EXTRACT_ROUTINE_RESULT_SCHEMA
 (
   @P__ROUTINE_NAME AS NVARCHAR(200)
 )
AS
BEGIN

	-----------------------------------------------	
	DECLARE @V__FULL_CMD AS NVARCHAR(MAX)
	DECLARE @V_TABLE_ROUTINE_RESULT_SCHEMA TABLE 
							  (
								ROUTINE_NAME NVARCHAR(200),
								COLUMN_NAME  NVARCHAR(200),
								COLUMN_TYPE  NVARCHAR(200)
							  )
    SET @V__FULL_CMD = 'EXEC ' + @P__ROUTINE_NAME
	-----------------------------------------------
	-- GET RESULT SCHEMA
	-----------------------			
	-- EXEC sp_describe_first_result_set @tsql = @V__FULL_CMD
	INSERT INTO @V_TABLE_ROUTINE_RESULT_SCHEMA  
	SELECT 
		@P__ROUTINE_NAME 'ROUTINE_NAME',
		REPLACE(NAME,' ','_'), 
		SYSTEM_TYPE_NAME 
	FROM SYS.DM_EXEC_DESCRIBE_FIRST_RESULT_SET(@V__FULL_CMD,NULL,1);
	-----------------------

	-----------------------
	SELECT *
	FROM  @V_TABLE_ROUTINE_RESULT_SCHEMA
	-----------------------
END

GO


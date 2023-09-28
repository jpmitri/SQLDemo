
CREATE FUNCTION [dbo].[UDF_SPLIT]
(
	@P__SEPARATOR CHAR(1),
	@P__RAW_DATA  VARCHAR(MAX)
)
RETURNS @TBL_FIELDS TABLE 
	(
		PART_ORDER	INT ,
		PART_VALUE	VARCHAR(1000)
	)
AS
BEGIN
	
	-- DECLERATION SECTION.
	------------------------------------------------	
	DECLARE @V_PART_ORDER	AS INT
	DECLARE @V_PART_VALUE	AS VARCHAR(1000)

	DECLARE @V_RAW_DATA	AS VARCHAR(MAX)
	DECLARE @V_SEPARATOR	AS CHAR(1)
	------------------------------------------------

	-- INITIALIZATION SECTION.
	------------------------------------------------
	SET @V_PART_ORDER	= 0
	SET @V_PART_VALUE	= ''
	
	SET @V_RAW_DATA	 = @P__RAW_DATA
	SET @V_SEPARATOR = @P__SEPARATOR
	------------------------------------------------
	
	

	WHILE (CHARINDEX(@V_SEPARATOR,@V_RAW_DATA)>0)
	BEGIN
		SET   @V_PART_VALUE   = LTRIM(RTRIM(SUBSTRING(@V_RAW_DATA,1,CHARINDEX(@V_SEPARATOR,@V_RAW_DATA)-1)))
		SET   @V_RAW_DATA     = SUBSTRING(@V_RAW_DATA,CHARINDEX(@V_SEPARATOR,@V_RAW_DATA)+1,LEN(@V_RAW_DATA))
		SET   @V_PART_ORDER   = @V_PART_ORDER + 1
		
		IF (@V_PART_VALUE <> '')
		BEGIN
			INSERT INTO @TBL_FIELDS VALUES (@V_PART_ORDER,@V_PART_VALUE)
		END
			
	END

		SET   @V_PART_ORDER   = @V_PART_ORDER + 1
		
		IF (@V_RAW_DATA <> '')
		BEGIN
			INSERT INTO @TBL_FIELDS VALUES (@V_PART_ORDER,@V_RAW_DATA)	
		END

	RETURN 
END

GO

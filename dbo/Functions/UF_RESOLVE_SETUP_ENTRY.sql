CREATE FUNCTION [dbo].[UF_RESOLVE_SETUP_ENTRY]
(
  @P__OWNER_ID		 INT,
  @P__TBL_NAME		 NVARCHAR(50),
  @P__CODE_NAME		 NVARCHAR(50),
  @P__LANGUAGE_CODE  NVARCHAR(50)
)
RETURNS NVARCHAR(200)
AS
BEGIN

	-- DECLARATION SECTION
	------------------------------
	DECLARE @V__RETURN_VALUE AS NVARCHAR(200)
	SET     @V__RETURN_VALUE = ''
	------------------------------
	
	-- BODY SECTION
	------------------------------
	SELECT 
			@V__RETURN_VALUE = CASE @P__LANGUAGE_CODE
								WHEN '0' THEN [CODE_VALUE_AR]
								WHEN '1' THEN [CODE_VALUE_EN]
								WHEN '2' THEN [CODE_VALUE_FR]
								END						
	FROM	[TBL_SETUP]
	WHERE   [OWNER_ID]	= @P__OWNER_ID
	AND     [TBL_NAME]	= @P__TBL_NAME
	AND     [CODE_NAME]	= @P__CODE_NAME
	------------------------------
	
	------------------------------
	RETURN @V__RETURN_VALUE
	------------------------------
END

GO


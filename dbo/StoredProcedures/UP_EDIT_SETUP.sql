CREATE PROCEDURE [dbo].[UP_EDIT_SETUP]          
	(          
	 @P__OWNER_ID  INT,          
	 @P__TBL_NAME  NVARCHAR(50),          
	 @P__CODE_NAME  NVARCHAR(50),          
	 @P__ISSYSTEM  BIT,          
	 @P__ISDELETEABLE BIT,          
	 @P__ISUPDATEABLE BIT,          
	 @P__ISVISIBLE  BIT,          
	 @P__ISDELETED  BIT,          
	 @P__DISPLAY_ORDER   INT,          
	 @P__CODE_VALUE_EN NVARCHAR(200),          
	 @P__CODE_VALUE_FR NVARCHAR(200),          
	 @P__CODE_VALUE_AR NVARCHAR(200),          
	 @P__ENTRY_DATE  NVARCHAR(20),          
	 @P__ENTRY_USER_ID BIGINT,          
	 @P__NOTES           NVARCHAR(MAX)          
	)          
	AS          
	BEGIN          
           
	 -- DECLARATION SECTION.          
	 --------------------------------------------          
	 DECLARE @V__ISEXISTS AS INT          
	 DECLARE @V__CODE_NAME AS NVARCHAR(50)      
       
	 SET     @V__ISEXISTS = 0          
	 SET     @V__CODE_NAME = '0'     
	 --------------------------------------------          
           
	 -- BODY SECTION          
	 --------------------------------------------          
	 SELECT @V__ISEXISTS = COUNT(*)          
	 FROM   [dbo].[TBL_SETUP]           
	 WHERE  [OWNER_ID]  = @P__OWNER_ID           
	 AND    [TBL_NAME]  = @P__TBL_NAME           
	 AND    [CODE_NAME] = @P__CODE_NAME      
 
           
	 IF (@V__ISEXISTS = 0)          
	 BEGIN          
       
	  ----------------      
	  SELECT       
			@V__CODE_NAME = CAST((MAX(CAST(COALESCE([CODE_NAME],'0') AS INT)) + 1) AS NVARCHAR(50))      
	  FROM  [TBL_SETUP]      
	  WHERE [TBL_NAME] = @P__TBL_NAME       
	  ----------------
     
	  ----------------   
	  IF (@V__CODE_NAME IS NULL)
	  BEGIN
		SET @V__CODE_NAME = '1'
	  END     
	  ----------------
      
	  ----------------    
	  IF (LEN(@V__CODE_NAME) = 1)    
	  BEGIN    
		SET @V__CODE_NAME = '00' + @V__CODE_NAME    
	  END    
	  ----------------      
      
	  ----------------     
	  IF (LEN(@V__CODE_NAME) = 2)    
	  BEGIN    
		SET @V__CODE_NAME = '0' + @V__CODE_NAME    
	  END    
	  ----------------      
       
 
	  ----------------      
	  INSERT INTO [dbo].[TBL_SETUP]           
	  (          
	   OWNER_ID,           
	   TBL_NAME,           
	   [CODE_NAME],           
	   ISSYSTEM,           
	   ISDELETEABLE,          
	   ISUPDATEABLE,          
	   DISPLAY_ORDER,          
	   ISVISIBLE,           
	   ISDELETED,           
	   CODE_VALUE_EN,          
	   CODE_VALUE_FR,          
	   CODE_VALUE_AR,          
	   ENTRY_DATE,          
	   ENTRY_USER_ID,          
	   NOTES             
	  )          
	  VALUES          
	  (          
	   @P__OWNER_ID,           
	   @P__TBL_NAME,           
	   @V__CODE_NAME,           
	   @P__ISSYSTEM,           
	   @P__ISDELETEABLE,          
	   @P__ISUPDATEABLE,          
	   @P__DISPLAY_ORDER,          
	   @P__ISVISIBLE,           
	   @P__ISDELETED,          
	   @P__CODE_VALUE_EN,          
	   @P__CODE_VALUE_FR,          
	   @P__CODE_VALUE_AR,          
	   @P__ENTRY_DATE,           
	   @P__ENTRY_USER_ID,          
	   @P__NOTES             
	  )      
	  ----------------          
	 END          
	 ELSE          
	 BEGIN          
	  UPDATE [dbo].[TBL_SETUP]           
	  SET    [ISSYSTEM]   = @P__ISSYSTEM,          
			 [ISDELETEABLE]  = @P__ISDELETEABLE,          
			 [ISUPDATEABLE]  = @P__ISUPDATEABLE,          
			 [DISPLAY_ORDER]  = @P__DISPLAY_ORDER,          
			 [ISVISIBLE]   = @P__ISVISIBLE,          
			 [ISDELETED]   = @P__ISDELETED,          
			 [CODE_VALUE_EN]  = @P__CODE_VALUE_EN,          
			 [CODE_VALUE_FR]  = @P__CODE_VALUE_FR,          
			 [CODE_VALUE_AR]  = @P__CODE_VALUE_AR,          
			 [ENTRY_DATE]   = CAST(@P__ENTRY_DATE AS DATE),          
			 [ENTRY_USER_ID]  = @P__ENTRY_USER_ID,          
			 [NOTES]    = @P__NOTES                   
	  WHERE  [OWNER_ID]   = @P__OWNER_ID           
	  AND    [TBL_NAME]   = @P__TBL_NAME           
	  AND    [CODE_NAME]   = @P__CODE_NAME     
	 END          
	 --------------------------------------------          
	END

GO


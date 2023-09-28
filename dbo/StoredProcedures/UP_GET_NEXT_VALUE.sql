CREATE PROCEDURE [dbo].[UP_GET_NEXT_VALUE]    
	( 
	  @P__STARTER_CODE NVARCHAR(50),    
	  @P__VALUE        BIGINT  OUTPUT    
	)     
	AS    
	BEGIN    
	 --------------------------------    
	 DECLARE @V__EXISTS   AS INT    
	 DECLARE @V__LAST_VALUE AS BIGINT    
     
     
	 SET     @V__EXISTS   = 0    
	 SET     @V__LAST_VALUE  = 0    
	 SET     @P__VALUE   = 0    
	 --------------------------------    
     
	 --------------------------------------------------------       
	 BEGIN TRANSACTION    
     
	  SELECT @V__EXISTS = COUNT(*)    
	  FROM   [TBL_INC] WITH(TABLOCKX)    
	  WHERE  [STARTER_CODE] = @P__STARTER_CODE
      
       
	  IF (@V__EXISTS = 0)    
	  BEGIN    
	   INSERT INTO [TBL_INC] WITH(TABLOCKX)    
	   (  
		[STARTER_CODE],    
		[LAST_VALUE]    
        
	   )    
	   VALUES    
	   ( 
		@P__STARTER_CODE,    
		1    
	   )    
       
	   SET @P__VALUE = 1    
	  END    
	  ELSE    
	  BEGIN    
        
	   SELECT @V__LAST_VALUE = LAST_VALUE    
	   FROM   [TBL_INC] WITH(TABLOCKX)    
	   WHERE  [STARTER_CODE] = @P__STARTER_CODE
           
	   SET @P__VALUE = @V__LAST_VALUE + 1    
       
	   UPDATE [TBL_INC] WITH(TABLOCKX)    
	   SET    [LAST_VALUE] = @P__VALUE    
	   WHERE  [STARTER_CODE] = @P__STARTER_CODE 
           
	  END      
	 COMMIT    
	 --------------------------------------------------------    
	END

GO


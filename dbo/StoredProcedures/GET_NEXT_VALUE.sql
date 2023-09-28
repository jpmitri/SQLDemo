CREATE PROCEDURE [dbo].[GET_NEXT_VALUE]        
	 (     
	   @P__STARTER_CODE NVARCHAR(50)     
	 )         
	 AS        
	 BEGIN        
	  --------------------------------        
	  DECLARE @V__EXISTS   AS INT        
	  DECLARE @V__LAST_VALUE AS BIGINT        
	  DECLARE @V__VALUE  AS BIGINT
         
	  SET     @V__EXISTS   = 0        
	  SET     @V__LAST_VALUE  = 0        
	  SET     @V__VALUE   = 0        
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
           
		SET @V__VALUE = 1        
	   END        
	   ELSE        
	   BEGIN        
            
		SELECT @V__LAST_VALUE = LAST_VALUE        
		FROM   [TBL_INC] WITH(TABLOCKX)        
		WHERE  [STARTER_CODE] = @P__STARTER_CODE    
               
		SET @V__VALUE = @V__LAST_VALUE + 1        
           
		UPDATE [TBL_INC] WITH(TABLOCKX)        
		SET    [LAST_VALUE] = @V__VALUE        
		WHERE  [STARTER_CODE] = @P__STARTER_CODE     
               
	   END          
	  COMMIT        
	  --------------------------------------------------------        

	  --------------------------------------------------------        
	  SELECT @V__VALUE AS 'LAST_VALUE'
	  --------------------------------------------------------        
	 END

GO


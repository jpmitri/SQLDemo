CREATE PROCEDURE [dbo].[GET_DISTINCT_SETUP_TBL]  
	(  
	  @P__OWNER_ID INT  
	)  
	AS  
	BEGIN  
	 ------------------------------  
	 SELECT DISTINCT [TBL_NAME]  
	 FROM   [TBL_SETUP]   
	 WHERE [OWNER_ID] = @P__OWNER_ID   
	 ------------------------------  
	END

GO


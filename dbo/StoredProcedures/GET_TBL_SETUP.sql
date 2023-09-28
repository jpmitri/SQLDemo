CREATE PROCEDURE [dbo].[GET_TBL_SETUP]  
AS  
BEGIN   
   SELECT [OWNER_ID]  
      ,[TBL_NAME]  
      ,[CODE_NAME]  
      ,[ISSYSTEM]  
      ,[ISDELETEABLE]  
      ,[ISUPDATEABLE]  
      ,[ISDELETED]  
      ,[ISVISIBLE]  
      ,[DISPLAY_ORDER]  
      ,[CODE_VALUE_EN]  
      ,[CODE_VALUE_FR]  
      ,[CODE_VALUE_AR]  
      ,[NOTES]  
      ,[ENTRY_DATE]  
      ,[ENTRY_USER_ID]  
  FROM [dbo].[TBL_SETUP]  
END

GO


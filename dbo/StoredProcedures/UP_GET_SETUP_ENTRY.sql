CREATE PROCEDURE [dbo].[UP_GET_SETUP_ENTRY]  
(  
 @P__OWNER_ID INT,  
 @P__TBL_NAME NVARCHAR(50),  
 @P__CODE_NAME  NVARCHAR(50)  
)  
AS  
BEGIN  
 -----------------------------  
 SELECT   
   OWNER_ID,   
   TBL_NAME,   
   CODE_NAME,   
   ISSYSTEM,   
   ISDELETEABLE,  
   ISUPDATEABLE,  
   DISPLAY_ORDER,  
   ISVISIBLE,   
   ISDELETED,   
   CODE_VALUE_EN,  
   CODE_VALUE_FR,  
   CODE_VALUE_AR,  
   [NOTES],  
   CAST(ENTRY_DATE AS NVARCHAR(20)) [ENTRY_DATE],  
   ENTRY_USER_ID         
 FROM    [TBL_SETUP]   
 WHERE   [OWNER_ID] = @P__OWNER_ID  
 AND     [TBL_NAME] = @P__TBL_NAME  
 AND     [CODE_NAME] = @P__CODE_NAME  
 -----------------------------  
END

GO


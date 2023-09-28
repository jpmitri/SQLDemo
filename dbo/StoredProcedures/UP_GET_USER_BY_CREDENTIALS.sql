CREATE PROCEDURE [dbo].[UP_GET_USER_BY_CREDENTIALS]  
(  
 @P__OWNER_ID  INT,  
 @P__USERNAME  NVARCHAR(100),  
 @P__PASSWORD NVARCHAR(1000)  
)  
AS  
BEGIN  
 ----------------------------  
 SELECT   
        [USER_ID],  
        OWNER_ID,  
        USERNAME,  
        [PASSWORD],          
        CAST(ENTRY_DATE AS DATE) AS [ENTRY_DATE]  
 FROM   [TBL_USER]   
 WHERE  [OWNER_ID] = @P__OWNER_ID  
 AND    [USERNAME] = @P__USERNAME   
 --AND    [PASSWORD] = @P__PASSWORD   
 ----------------------------  
END

GO


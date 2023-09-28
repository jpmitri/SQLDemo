CREATE FUNCTION [dbo].[UDF_GET_STARTUP_DATA_SIGNATURE]                                                
(                                                
  @P__OWNER_ID AS INT,                                            
  @P__USER_ID  AS BIGINT                                            
)                                                
RETURNS BIGINT                                                
AS                                                
BEGIN                                                
                                                
 ------------------                                                
 DECLARE @V__CHECK_SUM AS BIGINT                                                
 SET     @V__CHECK_SUM = 0                                                
 ------------------                                                
                                                
 -- TBL_SETUP                                                
 ------------------                                                
 SET     @V__CHECK_SUM = 0                                                
 SELECT  @V__CHECK_SUM = @V__CHECK_SUM + CHECKSUM(*)                                                
 FROM    [TBL_SETUP]                                                
 WHERE   [OWNER_ID] = @P__OWNER_ID                                                
 ------------------              
                                                 
                                     
 -- RETURN SECTION                                                
 ------------------                                                
 RETURN @V__CHECK_SUM                                                
 ------------------                                                
                                                
END

GO


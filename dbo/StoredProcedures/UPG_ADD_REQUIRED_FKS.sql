CREATE PROCEDURE UPG_ADD_REQUIRED_FKS 
AS  
BEGIN     
    
 ------------------------------------  
 DECLARE @V__TABLE_NAME  AS NVARCHAR(200)  
 DECLARE @V__COLUMN_NAME AS NVARCHAR(200)  
 DECLARE @V__STATEMENT   AS NVARCHAR(4000)  
 DECLARE @V__IS_FK  AS INT  
   
 SET  @V__TABLE_NAME        = ''  
 SET  @V__COLUMN_NAME       = ''  
 SET  @V__STATEMENT         = ''  
 SET  @V__IS_FK     = 0  
 ------------------------------------  
  
 ------------------------------------  
 DECLARE TABLE_CURSOR CURSOR FOR  
 SELECT   
     [TABLE_NAME]   
 FROM   INFORMATION_SCHEMA.TABLES  
 WHERE  [TABLE_NAME] NOT IN  
   (  
      'TBL_USER',  
      'TBL_OWNER',  
      'TBL_SETUP',  
      'TBL_INC',
	  'TBL_USER_MENU' 
   )  
 AND    [TABLE_NAME] LIKE 'TBL_%' 
 AND    [TABLE_NAME] NOT LIKE '%_AUD%'	  
 OPEN TABLE_CURSOR  
 FETCH NEXT FROM TABLE_CURSOR INTO @V__TABLE_NAME  
 WHILE @@FETCH_STATUS = 0  
 BEGIN  
   
   
  -- LOOP OVER CORRESPONDING FIELDS  
  ------------   
  DECLARE COLUMN_CURSOR CURSOR FOR  
  SELECT   
         [COLUMN_NAME]  
  FROM   INFORMATION_SCHEMA.COLUMNS  
  WHERE  [TABLE_NAME]  = @V__TABLE_NAME  
  AND    UPPER([COLUMN_NAME]) LIKE '%[_]ID' 
  AND    ('TBL_' +  [COLUMN_NAME]) <> @V__TABLE_NAME + '_ID' -- To ByPass table Primary key itself
    
  OPEN COLUMN_CURSOR  
  FETCH NEXT FROM COLUMN_CURSOR INTO @V__COLUMN_NAME  
  WHILE @@FETCH_STATUS = 0  
  BEGIN  
    
   -- CHECK IF FIELD HAS FK
   ------------   
   SELECT  @V__IS_FK = COUNT(*)  
   FROM    DBO.UDF_GET_TABLE_FKS(@V__TABLE_NAME)  
   WHERE   [COLUMN_NAME] = @V__COLUMN_NAME  
   ------------  
     
   ------------  
   IF (@V__IS_FK = 0)  
   BEGIN  
     BEGIN TRY 
	   IF (DBO.UDF_GET_TABLE_BY_PK(@V__COLUMN_NAME) <> '')
	   BEGIN
		   SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD CONSTRAINT FK_' + @V__TABLE_NAME + '_' + DBO.UDF_GET_TABLE_BY_PK(@V__COLUMN_NAME) + ' FOREIGN KEY (' + @V__COLUMN_NAME + ') REFERENCES [' + DBO.UDF_GET_TABLE_BY_PK(@V__COLUMN_NAME) + ']('+ @V__COLUMN_NAME + ')'  
		   PRINT @V__STATEMENT  
		   EXEC SP_EXECUTESQL @V__STATEMENT  
       END       
     END TRY  
     BEGIN CATCH        
     END CATCH  
   END  
   ------------  
     
   ------------  
   FETCH NEXT FROM COLUMN_CURSOR INTO @V__COLUMN_NAME  
   ------------  
     
  END  
  CLOSE COLUMN_CURSOR  
  DEALLOCATE COLUMN_CURSOR  
  ------------  
    
  ------------  
     FETCH NEXT FROM TABLE_CURSOR INTO @V__TABLE_NAME  
     ------------       
 END  
 CLOSE TABLE_CURSOR  
 DEALLOCATE TABLE_CURSOR  
 ------------------------------------  
  
END

GO


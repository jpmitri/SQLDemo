
CREATE PROCEDURE UPG_ADD_REQUIRED_FIELDS
AS
BEGIN

------------------------------------
DECLARE @V__TBL_USER_EXISTS  AS INT
DECLARE @V__TBL_OWNER_EXISTS AS INT

DECLARE @V__HAS_ENTRY_USER_ID   AS INT
DECLARE @V__HAS_ENTRY_DATE      AS INT
DECLARE @V__HAS_OWNER_ID        AS INT
DECLARE @V__HAS_CHARACTER_FIELD AS INT
DECLARE @V__HAS_DESCRIPTION_FIELD AS INT

DECLARE @V__TABLE_NAME AS NVARCHAR(200)
DECLARE @V__STATEMENT  AS NVARCHAR(4000)

SET  @V__TBL_USER_EXISTS   = 0
SET  @V__TBL_OWNER_EXISTS  = 0

SET  @V__HAS_ENTRY_USER_ID   = 0
SET  @V__HAS_ENTRY_DATE      = 0
SET  @V__HAS_OWNER_ID        = 0
SET  @V__HAS_CHARACTER_FIELD = 0

SET  @V__TABLE_NAME        = ''
SET  @V__STATEMENT         = ''
------------------------------------

-- Check TBL_USER existence
------------------------------------
SELECT @V__TBL_USER_EXISTS = COUNT(*)
FROM   INFORMATION_SCHEMA.TABLES
WHERE  [TABLE_NAME] = 'TBL_USER'
------------------------------------


-- Check TBL_OWNER existence
------------------------------------
SELECT @V__TBL_OWNER_EXISTS = COUNT(*)
FROM   INFORMATION_SCHEMA.TABLES
WHERE  [TABLE_NAME] = 'TBL_OWNER'
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
 

   -- ENTRY_USER_ID
   ----------------------------------------
   IF (@V__TBL_USER_EXISTS  > 0)
   BEGIN
	   SELECT @V__HAS_ENTRY_USER_ID = COUNT(*)
	   FROM   INFORMATION_SCHEMA.COLUMNS
	   WHERE  [TABLE_NAME]  = @V__TABLE_NAME
	   AND    [COLUMN_NAME] = 'ENTRY_USER_ID'
   
	   IF (@V__HAS_ENTRY_USER_ID = 0)
	   BEGIN
     
		 BEGIN TRY
     
			 SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD [ENTRY_USER_ID] BIGINT NOT NULL'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
	        
			 SET @V__STATEMENT = 'CREATE INDEX ' + 'IX_ENTRY_USER_ID' + ' ON ' + @V__TABLE_NAME + ' ([ENTRY_USER_ID])'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
		 
			 SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD CONSTRAINT FK_' + @V__TABLE_NAME + '_TBL_USER' + ' FOREIGN KEY (ENTRY_USER_ID) REFERENCES [TBL_USER](USER_ID)'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
	 
		 END TRY
		 BEGIN CATCH
			PRINT @V__TABLE_NAME + 'EID: .'				
		 END CATCH
	 
	   END
   END
   ----------------------------------------
   
   -- ENTRY_DATE
   ----------------------------------------
   IF (@V__TBL_USER_EXISTS  > 0)
   BEGIN
	   SELECT @V__HAS_ENTRY_DATE = COUNT(*)
	   FROM   INFORMATION_SCHEMA.COLUMNS
	   WHERE  [TABLE_NAME]  = @V__TABLE_NAME
	   AND    [COLUMN_NAME] = 'ENTRY_DATE'
   
	   IF (@V__HAS_ENTRY_DATE = 0)
	   BEGIN
   
		 BEGIN TRY
   
			 SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD [ENTRY_DATE] DATE NOT NULL'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
      
		 END TRY
		 BEGIN CATCH
			PRINT @V__TABLE_NAME + 'EDATE: .'				
		 END CATCH
	  
	   END
   END
   ----------------------------------------
   
      
   -- OWNER_ID
   ----------------------------------------
   IF (@V__TBL_OWNER_EXISTS > 0)
   BEGIN
	   SELECT @V__HAS_OWNER_ID = COUNT(*)
	   FROM   INFORMATION_SCHEMA.COLUMNS
	   WHERE  [TABLE_NAME]  = @V__TABLE_NAME
	   AND    [COLUMN_NAME] = 'OWNER_ID'
   
	   IF (@V__HAS_OWNER_ID = 0)
	   BEGIN
   
		 BEGIN TRY
	 
			 SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD [OWNER_ID] INT NOT NULL'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
	   
			 SET @V__STATEMENT = 'CREATE INDEX ' + 'IX_OWNER_ID' + ' ON ' + @V__TABLE_NAME + ' ([OWNER_ID])'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
		 
			 SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD CONSTRAINT FK_' + @V__TABLE_NAME + '_TBL_OWNER' + ' FOREIGN KEY (OWNER_ID) REFERENCES [TBL_OWNER](OWNER_ID)'
			 EXEC SP_EXECUTESQL @V__STATEMENT 
     
		 END TRY
		 BEGIN CATCH
			PRINT @V__TABLE_NAME + 'OWNER: .'				
		 END CATCH
   
	   END
   END
   ----------------------------------------

    -- DESCRIPTION
   ----------------------------------------
   IF (@V__TBL_OWNER_EXISTS > 0)
   BEGIN
	   SELECT @V__HAS_CHARACTER_FIELD = COUNT(*)
	   FROM   INFORMATION_SCHEMA.COLUMNS
	   WHERE  [TABLE_NAME]  = @V__TABLE_NAME
	   AND    UPPER([DATA_TYPE]) IN ('VARCHAR','NVARCHAR')
	   AND    UPPER([COLUMN_NAME]) NOT IN ('NOTES','FTS')
   
	   IF (@V__HAS_CHARACTER_FIELD = 0)
	   BEGIN
	
		 BEGIN TRY
	 
		  SELECT @V__HAS_DESCRIPTION_FIELD = COUNT(*)
		  FROM   INFORMATION_SCHEMA.COLUMNS
		  WHERE  [TABLE_NAME]  = @V__TABLE_NAME
		  AND    UPPER([COLUMN_NAME]) = 'DESCRIPTION'
	 
		  IF (@V__HAS_DESCRIPTION_FIELD = 0)
		  BEGIN	 
			  SET @V__STATEMENT = 'ALTER TABLE ' + @V__TABLE_NAME + ' ADD [DESCRIPTION] NVARCHAR(MAX) NULL DEFAULT '''' '
			  EXEC SP_EXECUTESQL @V__STATEMENT 
		  END
		 END TRY
		 BEGIN CATCH
			PRINT @V__TABLE_NAME + 'DESC: .'				
		 END CATCH
	   END
   END
   ----------------------------------------
   

   ----------------------------------------
   FETCH NEXT FROM TABLE_CURSOR INTO @V__TABLE_NAME
   ----------------------------------------
   
END
CLOSE TABLE_CURSOR
DEALLOCATE TABLE_CURSOR
------------------------------------

END

GO




CREATE PROCEDURE [DBO].[UP_ENGINE_GET_FIELDS]
(
	@P__TABLE_NAME  	SYSNAME
)
AS
BEGIN
	-- DECLERATION SECTION.
	---------------------------------------------------------
	---------------------------------------------------------


	-- INITIALIZATION SECTION.
	---------------------------------------------------------	
	---------------------------------------------------------

		SET @P__TABLE_NAME = REPLACE(@P__TABLE_NAME,'[','')
		SET @P__TABLE_NAME = REPLACE(@P__TABLE_NAME,']','')
		
		---------------------------------------------------------			
		SELECT
			 INFORMATION_SCHEMA.COLUMNS.*,
			 (
				SELECT COALESCE(COLUMNPROPERTY(OBJECT_ID(@P__TABLE_NAME), INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME, 'ISCOMPUTED'),0)
			 ) AS ISCOMPUTED,
			(
				SELECT COALESCE(COL_LENGTH(@P__TABLE_NAME, INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME),0)
			) AS COLUMNLENGTH,
			(
				SELECT COALESCE(COLUMNPROPERTY(OBJECT_ID(@P__TABLE_NAME), INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME, 'ISIDENTITY'),0)
			) AS ISIDENTITY,
			(
				SELECT COALESCE(COLUMNPROPERTY(OBJECT_ID(@P__TABLE_NAME), INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME, 'ISROWGUIDCOL'),0)
			) AS ISROWGUIDCOLUMN,
			(
				COALESCE
				(
				ISNULL(	
				(
					SELECT TOP 1 CASE INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE
								WHEN 'PRIMARY KEY' THEN 1
							END
					FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE INNER JOIN 
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS ON 
						INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME=
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME
					WHERE INFORMATION_SCHEMA.KEY_COLUMN_USAGE.TABLE_NAME = @P__TABLE_NAME
						AND INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME = 
						INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME
						AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'PRIMARY KEY'
				), 0)
				,
				0
				)
			) AS ISPRIMARYKEY,
			(
				COALESCE
				(
				ISNULL(	
				(	
					SELECT TOP 1 CASE INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE
								WHEN 'FOREIGN KEY' THEN 1
							END
					FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE INNER JOIN 
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS ON 
						INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME=
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME
					WHERE INFORMATION_SCHEMA.KEY_COLUMN_USAGE.TABLE_NAME = @P__TABLE_NAME
						AND INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME = 
						INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME
						AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY'
				), 0)
				,
				0
				)
			) AS ISFOREIGNKEY, 
			(
				COALESCE
				(
				ISNULL(	
				(	
					SELECT TOP 1 CASE INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE
								WHEN 'UNIQUE' THEN 1
							END
					FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE INNER JOIN 
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS ON 
						INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME=
						INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME
					WHERE INFORMATION_SCHEMA.KEY_COLUMN_USAGE.TABLE_NAME = @P__TABLE_NAME
						AND INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME = 
						INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME
						AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'UNIQUE'
				), 0)
				,
				0
				)
			) AS HASUNIQUECONSTRAINT  
		FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = @P__TABLE_NAME
	
		
	END
	---------------------------------------------------------	

GO


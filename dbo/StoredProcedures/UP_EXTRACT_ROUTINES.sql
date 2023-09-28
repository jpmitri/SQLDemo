CREATE PROCEDURE UP_EXTRACT_ROUTINES
AS
BEGIN

	-----------------------------------------------
	DECLARE @V_TABLE_ROUTINE TABLE 
							  (
								ROUTINE_NAME NVARCHAR(200)
							  )
	-----------------------------------------------


	-- GET ALL CUSTOM ROUTINES
	-----------------------------------------------
  		SELECT SPECIFIC_NAME
		FROM
			INFORMATION_SCHEMA.ROUTINES AS ISR
		WHERE
			ISR.ROUTINE_TYPE = 'PROCEDURE' 
			AND  CHARINDEX('UPG_', SPECIFIC_NAME) = 0	
			AND  SPECIFIC_NAME NOT IN 
					(
						'UP_ENGINE_GET_ALL_TABLES',
						'UP_ENGINE_GET_FIELDS',
						'UP_ENGINE_GET_INDEXES',
						'UP_ENGINE_GET_ALL_FKS',
						'UP_EXTRACT_ROUTINES'
					)	
			AND 
			OBJECTPROPERTY (OBJECT_ID (ISR.ROUTINE_NAME), 'ISMSSHIPPED') = 0 AND
			(
				SELECT 
					MAJOR_ID 
				FROM 
					SYS.EXTENDED_PROPERTIES 
				WHERE 
					MAJOR_ID = OBJECT_ID(ISR.ROUTINE_NAME) AND 
					MINOR_ID = 0 AND 
					CLASS = 1 AND 
					NAME = N'MICROSOFT_DATABASE_TOOLS_SUPPORT'
			) IS NULL
		ORDER BY
			ISR.ROUTINE_CATALOG,
			ISR.ROUTINE_SCHEMA,
			ISR.ROUTINE_NAME
		-----------------------------------------------


END

GO


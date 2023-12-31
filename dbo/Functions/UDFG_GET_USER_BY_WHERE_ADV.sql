CREATE FUNCTION [DBO].[UDFG_GET_USER_BY_WHERE_ADV]
(
@P__OWNER_ID INT,
@P__USERNAME NVARCHAR(100),
@P__PASSWORD NVARCHAR(1000),
@P__USER_TYPE_CODE NVARCHAR(50)
)
RETURNS @P__TABLE_USER TABLE 
(
[USER_ID] BIGINT,
[OWNER_ID] INT,
[USERNAME] NVARCHAR(100),
[PASSWORD] NVARCHAR(1000),
[USER_TYPE_CODE] NVARCHAR(50),
[IS_ACTIVE] BIT,
[ENTRY_DATE] NVARCHAR(20)
)
AS
BEGIN
---------------------------------

-- DECLARATION SECTION
----------------------------
DECLARE @V__USERNAME AS NVARCHAR(100)
DECLARE @V__PASSWORD AS NVARCHAR(1000)
DECLARE @V__USER_TYPE_CODE AS NVARCHAR(50)
----------------------------

----------------------------

SET @V__USERNAME = COALESCE(@P__USERNAME,'')
SET @V__USERNAME = '%' + @V__USERNAME + '%'


SET @V__PASSWORD = COALESCE(@P__PASSWORD,'')
SET @V__PASSWORD = '%' + @V__PASSWORD + '%'


SET @V__USER_TYPE_CODE = COALESCE(@P__USER_TYPE_CODE,'')
SET @V__USER_TYPE_CODE = '%' + @V__USER_TYPE_CODE + '%';

WITH DATAENTRIES
AS
(
SELECT
[USER].[USER_ID],
[USER].[OWNER_ID],
[USER].[USERNAME],
[USER].[PASSWORD],
[USER].[USER_TYPE_CODE],
[USER].[IS_ACTIVE],
CAST([USER].[ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE]
FROM  [DBO].[TBL_USER] [USER]  WITH (NOLOCK)
WHERE 
(COALESCE([USER].[USERNAME],'') LIKE @V__USERNAME) AND 
(COALESCE([USER].[PASSWORD],'') LIKE @V__PASSWORD) AND 
(COALESCE([USER].[USER_TYPE_CODE],'') LIKE @V__USER_TYPE_CODE) 
AND   [USER].[OWNER_ID] = @P__OWNER_ID
)
----------------------------


----------------------------
INSERT INTO @P__TABLE_USER
SELECT 	
[USER_ID],
[OWNER_ID],
[USERNAME],
[PASSWORD],
[USER_TYPE_CODE],
[IS_ACTIVE],
CAST([ENTRY_DATE] AS NVARCHAR) [ENTRY_DATE]
FROM    DATAENTRIES 
----------------------------

----------------------------
RETURN
----------------------------
END

GO


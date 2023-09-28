CREATE FUNCTION [DBO].[UDFG_GET_USER_BY_CRITERIA_ADV]
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



----------------------------
INSERT INTO @P__TABLE_USER
SELECT *
FROM [DBO].[UDFG_GET_USER_BY_WHERE_ADV]
(
@P__OWNER_ID,
@P__USERNAME,
@P__PASSWORD,
@P__USER_TYPE_CODE
)
----------------------------

----------------------------
RETURN
---------------------------------
---------------------------------
END

GO


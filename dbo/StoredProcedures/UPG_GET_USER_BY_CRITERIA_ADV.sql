CREATE PROCEDURE [DBO].[UPG_GET_USER_BY_CRITERIA_ADV]
(
@P__OWNER_ID INT,
@P__USERNAME NVARCHAR(100),
@P__PASSWORD NVARCHAR(1000),
@P__USER_TYPE_CODE NVARCHAR(50),
@P__START_ROW	BIGINT,
@P__END_ROW	BIGINT,
@P__TOTAL_COUNT BIGINT OUTPUT
)
AS
BEGIN
SET NOCOUNT ON
---------------------------------

---------------------------------
SET @P__START_ROW = @P__START_ROW + 1;
---------------------------------

---------------------------------
WITH DATAENTRIES
AS
(
SELECT
ROW_NUMBER() OVER (ORDER BY [USER].[USER_ID] DESC) AS ROW,
[USER].*
FROM [DBO].[UDFG_GET_USER_BY_CRITERIA_ADV]
(
@P__OWNER_ID,
@P__USERNAME,
@P__PASSWORD,
@P__USER_TYPE_CODE
) [USER]
---------------------------------
)


---------------------------------
SELECT 	*
FROM    DATAENTRIES 
WHERE   ROW BETWEEN (@P__START_ROW) AND (@P__END_ROW)
---------------------------------


---------------------------------
SELECT @P__TOTAL_COUNT = COUNT(*)
FROM [DBO].[UDFG_GET_USER_BY_CRITERIA_ADV]
(
@P__OWNER_ID,
@P__USERNAME,
@P__PASSWORD,
@P__USER_TYPE_CODE
) [USER]
---------------------------------

END

GO


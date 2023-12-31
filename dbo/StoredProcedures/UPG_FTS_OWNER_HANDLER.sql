CREATE PROCEDURE [DBO].[UPG_FTS_OWNER_HANDLER]
(
@P__OWNER_ID INT
)
AS
BEGIN
SET NOCOUNT ON
--------------------------------
UPDATE  [TBL_OWNER]
SET [FTS] = 'CODE_' + COALESCE([CODE],'') + '|' + 'R_CODE_' + REVERSE(COALESCE([CODE],'')) + '|' + 'MAINTENANCE_DUE_DATE_' + COALESCE(CONVERT(NVARCHAR(10), [MAINTENANCE_DUE_DATE], 120),'') + '|' + 'R_MAINTENANCE_DUE_DATE_' + REVERSE(COALESCE(CONVERT(NVARCHAR(10), [MAINTENANCE_DUE_DATE], 120),'')) + '|' + 'DESCRIPTION_' + COALESCE([DESCRIPTION],'') + '|' + 'R_DESCRIPTION_' + REVERSE(COALESCE([DESCRIPTION],'')) 
WHERE OWNER_ID = @P__OWNER_ID
--------------------------------
END

GO


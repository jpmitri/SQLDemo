CREATE PROCEDURE [DBO].[UPG_GET_CUSTOMER_ACCOUNT_BY_CUSTOMER_ACCOUNT_ID_LIST_ADV]
(
@P__CUSTOMER_ACCOUNT_ID_LIST VARCHAR(8000)
)
AS
BEGIN
SET NOCOUNT ON
----------------------------
SELECT *
FROM  [DBO].[UDFG_GET_CUSTOMER_ACCOUNT_BY_CUSTOMER_ACCOUNT_ID_LIST_ADV]
(
@P__CUSTOMER_ACCOUNT_ID_LIST
)
----------------------------
END

GO


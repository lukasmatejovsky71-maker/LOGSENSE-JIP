CREATE VIEW [dsa].[v_Supplier]
AS

WITH suppliermasterdata
AS
(
	SELECT
	[IČO]
	,[K jméno]
	,[K město]
	,ROW_NUMBER() OVER (PARTITION BY [IČO] ORDER BY [IČO]) AS [rn]
	FROM [dsa].[MaterialMovementMasterData]
	FULL OUTER JOIN [DimSupplier] 
		ON [MaterialMovementMasterData].[IČO] = [DimSupplier].[SupplierICO]
	WHERE 
		[MaterialMovementMasterData].[Divize] <> N'Celkový součet'
),
suppliermasterdataunique AS
(
	SELECT
		[IČO]
		,[K jméno]
		,[K město]
	FROM [suppliermasterdata]
	WHERE rn = 1
),
supplierreceipt AS
(
	SELECT
	[IČO]
	,N'' AS [K jméno]
	,N'' AS [K město]
	,ROW_NUMBER() OVER (PARTITION BY [IČO] ORDER BY [IČO]) AS [rn]
	FROM [dsa].[MaterialMovementReceipt]
	WHERE 
		[MaterialMovementReceipt].[Divize] <> N'Celkový součet'
	GROUP BY [IČO]
)
SELECT 
	ISNULL(suppliermasterdataunique.[IČO], supplierreceipt.[IČO]) AS [IČO]
	,ISNULL(suppliermasterdataunique.[K jméno], supplierreceipt.[K jméno]) AS [K jméno]
	,ISNULL(suppliermasterdataunique.[K město], supplierreceipt.[K město]) AS [K město]
	,IIF( ISNULL( suppliermasterdataunique.[IČO], supplierreceipt.[IČO]) LIKE '27464822%', 1, 0) AS [SupplierIsJIP]
FROM suppliermasterdataunique
FULL OUTER JOIN supplierreceipt ON suppliermasterdataunique.[IČO] = supplierreceipt.[IČO]

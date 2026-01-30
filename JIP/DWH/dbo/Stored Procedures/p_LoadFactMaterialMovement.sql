CREATE PROCEDURE [dbo].[p_LoadFactMaterialMovement]
AS

INSERT INTO FactMaterialMovement
(
	 [MaterialMovement_DateId]
	,[MaterialMovement_DivisionId]
	,[MaterialMovement_BranchId]
	,[MaterialMovement_DocumentId]
	,[MaterialMovement_ProductId]
	,[MaterialMovement_SupplierId]
	,[MaterialMovementTurnoverUoM]
	,[MaterialMovementTurnoverPalletes]
)
SELECT 
 d.[DateId] AS [MaterialMovement_DateId]
,div.[DivisionId] AS [MaterialMovement_DivisionId]
,b.[BranchId] AS [MaterialMovement_BranchId]
,doc.[DocumentId] AS [MaterialMovement_DocumentId]
,p.[ProductId] AS [MaterialMovement_ProductId]
,s.[SupplierId] AS [MaterialMovement_SupplierId]
,mr.[Obrat v MJ] [MaterialMovementTurnoverUoM]
,mr.[Obrat v paletách] [MaterialMovementTurnoverPalletes]
FROM dsa.[v_MaterialMovementReceipt] AS mr
LEFT JOIN DimDate AS d ON CONVERT( datetime, mr.[Den], 104) = d.[DateDate]
LEFT JOIN DimDivision AS div ON mr.[Divize] = div.[DivisionName]
LEFT JOIN DimBranch AS b ON LEFT( mr.[Pobočka], 3) = b.[BranchCode]
LEFT JOIN DimProduct AS p ON mr.[Produkt - Kód] = p.[ProductCode]
LEFT JOIN DimSupplier AS s ON mr.[IČO] = s.[SupplierICO]
LEFT JOIN DimDocument AS doc ON mr.[Číslo dokladu] = doc.[DocumentNumber]

RETURN 0

CREATE PROCEDURE [dbo].[p_LoadFactMaterialSale]
AS

INSERT INTO FactMaterialSale WITH (TABLOCKX)
(
	 [MaterialSale_DateId]
	,[MaterialSale_DivisionId]
	,[MaterialSale_BranchId]
	,[MaterialSale_DocumentId]
	,[MaterialSale_ProductId]
	,[MaterialSale_SupplierId]
	,[MaterialSaleTurnoverUoM]
	,[MaterialSaleTurnoverPalletes]
)
SELECT 
 d.[DateId] AS [MaterialSale_DateId]
,div.[DivisionId] AS [MaterialSale_DivisionId]
,b.[BranchId] AS [MaterialSale_BranchId]
,doc.[DocumentId] AS [MaterialSale_DocumentId]
,p.[ProductId] AS [MaterialSale_ProductId]
,s.[SupplierId] AS [MaterialSale_SupplierId]
,mr.[Obrat v MJ] [MaterialSaleTurnoverUoM]
,mr.[Obrat v paletách] [MaterialSaleTurnoverPalletes]
FROM [dsa].[v_MaterialSale] AS mr
LEFT JOIN DimDate AS d ON CONVERT( datetime, mr.[Den], 104) = d.[DateDate]
LEFT JOIN DimDivision AS div ON mr.[Divize] = div.[DivisionName]
LEFT JOIN DimBranch AS b ON LEFT( mr.[Pobočka], 3) = b.[BranchCode]
LEFT JOIN DimProduct AS p ON mr.[Produkt - Kód] = p.[ProductCode]
LEFT JOIN DimSupplier AS s ON mr.[IČO] = s.[SupplierICO]
LEFT JOIN DimDocument AS doc ON ISNULL( mr.[Číslo dokladu], N'') = doc.[DocumentNumber]

RETURN 0

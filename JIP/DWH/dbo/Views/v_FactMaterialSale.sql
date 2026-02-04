--WARNING! ERRORS ENCOUNTERED DURING SQL PARSING!
CREATE VIEW [dbo].[v_FactMaterialSale]
AS
SELECT [MaterialSaleId]
	,[MaterialSale_DateId]
	,[MaterialSale_BranchId]
	,[MaterialSale_DocumentId]
	,[MaterialSale_ProductId]
	,[MaterialSale_SupplierId]
	,[MaterialSaleTurnoverUoM]
	,[MaterialSaleTurnoverPalletes]
FROM [dbo].[FactMaterialSale]
INNER JOIN [v_BrancFilter] ON [MaterialSale_BranchId] = [BranchId]

CREATE VIEW [dbo].[v_FactMaterialSale]
AS
SELECT [MaterialSaleId]
	,[MaterialSale_DateId]
	,[MaterialSale_DivisionId]
	,[MaterialSale_BranchId]
	,[MaterialSale_DocumentId]
	,[MaterialSale_ProductId]
	,[MaterialSale_SupplierId]
	,[MaterialSaleTurnoverUoM]
	,[MaterialSaleTurnoverPalletes]
FROM [dbo].[FactMaterialSale];

CREATE VIEW [dbo].[v_DimSupplier]
AS
SELECT [SupplierId]
	,[SupplierICO]
	,[SupplierName]
	,[dbo].[f_GetFullName]([SupplierICO], [SupplierName]) AS [SupplierFullName]
	,[SupplierCity]
	,[SupplierIsJIP]
FROM [DimSupplier]

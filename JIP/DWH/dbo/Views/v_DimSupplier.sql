CREATE VIEW [dbo].[v_DimSupplier]
AS
SELECT [SupplierId]
	,[SupplierICO]
	,[SupplierName]
	,[SupplierCity]
	,[SupplierIsJIP]
	,[SupplierDeleted]
FROM [DimSupplier]

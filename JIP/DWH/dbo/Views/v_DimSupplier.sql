CREATE VIEW [dbo].[v_DimSupplier]
AS
SELECT [SupplierId]
	,[SupplierICO]
	,[SupplierName]
	,[SupplierICO] +  IIF([SupplierName] <> N'', ' - ' + [SupplierName], '' ) AS [SupplierFullName]
	,[SupplierCity]
	,[SupplierIsJIP]
FROM [DimSupplier]

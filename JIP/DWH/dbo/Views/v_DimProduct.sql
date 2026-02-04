CREATE VIEW [dbo].[v_DimProduct]
AS
SELECT [ProductId]
	,[ProductCode]
	,[ProductName]
	,[ProductCode] + IIF([ProductName] <> N'', N' - ' + [ProductName], N'') AS [ProductFullName]
	,[ProductCardType]
FROM [DimProduct]

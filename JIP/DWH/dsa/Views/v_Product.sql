CREATE VIEW [dsa].[v_Product]
AS
SELECT DISTINCT [Produkt - Kód] AS [ProductCode]
	,0 AS [ProductDeleted]
FROM [dsa].[v_MaterialMovementReceipt]

UNION

SELECT DISTINCT [Produkt - Kód] AS [ProductCode]
	,0 AS [ProductDeleted]
FROM [dsa].[v_MaterialSale]

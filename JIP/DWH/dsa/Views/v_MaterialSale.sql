CREATE VIEW [dsa].[v_MaterialSale]
AS 
SELECT 
[Divize]
	,[Pobočka]
	,[Den]
	,[IČO]
	,[Číslo dokladu]
	,[Produkt - Kód]
	,[Obrat v MJ]
	,[Obrat v paletách]
FROM [MaterialMovementSalesData]
WHERE [Divize] <> N'Celkový součet'

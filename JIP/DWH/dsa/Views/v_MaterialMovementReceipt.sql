CREATE VIEW [dsa].[v_MaterialMovementReceipt]
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
FROM [MaterialMovementReceipt]
WHERE [Divize] <> N'Celkový součet'

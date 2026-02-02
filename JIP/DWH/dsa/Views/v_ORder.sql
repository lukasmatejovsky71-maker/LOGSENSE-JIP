CREATE VIEW [dsa].[v_Order]
AS
SELECT [Zakázka]
	,CONVERT(BIT, MAX(CASE [Spekulace]
				WHEN 'Ne'
					THEN 0
				WHEN 'Ano'
					THEN 1
				ELSE 0
				END)) AS [Spekulace]
FROM [dsa].[MaterialMovementMasterData]
WHERE [MaterialMovementMasterData].[Divize] <> N'Celkový součet'
GROUP BY [Zakázka]

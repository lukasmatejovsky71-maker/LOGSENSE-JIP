CREATE PROCEDURE [dbo].[p_LoadDimProduct]
AS

DROP TABLE IF EXISTS #DimProduct

SELECT TOP 0
	 [ProductCode]
	,[ProductDeleted]
INTO #DimProduct
FROM [DimProduct]

INSERT INTO #DimProduct
(
	 [ProductCode]
	,[ProductDeleted]
)
SELECT DISTINCT
[Produkt - Kód] AS [ProductCode]
,0 AS [ProductDeleted]
FROM [dsa].[v_MaterialMovementReceipt]

;
MERGE [DimProduct] AS t
USING #DimProduct AS s ON t.[ProductCode] = s.[ProductCode]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		 [ProductCode]
		,[ProductDeleted]
	)
	VALUES
	(
		 s.[ProductCode]
		,s.[ProductDeleted]
	)

WHEN MATCHED THEN
	UPDATE SET
		 t.[ProductCode] = s.[ProductCode]
		,t.[ProductDeleted] = s.[ProductDeleted]

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.ProductDeleted = 1
;

DROP TABLE IF EXISTS #DimProduct

RETURN 0

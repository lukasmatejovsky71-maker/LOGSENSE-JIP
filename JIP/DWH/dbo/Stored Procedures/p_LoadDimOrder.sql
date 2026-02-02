CREATE PROCEDURE [dbo].[p_LoadDimOrder]
AS

DROP TABLE IF EXISTS #DimOrder

SELECT TOP 0
	[OrderNumber]
	,[OrderSpeculation]
INTO #DimOrder
FROM [DimOrder]

INSERT INTO #DimOrder
(
	[OrderNumber]
	,[OrderSpeculation]
)
SELECT
	[Zakázka] AS [OrderNumber]
	,[Spekulace] AS [OrderSpeculation]
FROM [dsa].[v_Order]

;
MERGE [DimOrder] AS t
USING #DimOrder AS s ON t.[OrderNumber] = s.[OrderNumber]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[OrderNumber]
		,[OrderSpeculation]
		,[OrderDeleted]
	)
	VALUES
	(
		s.[OrderNumber]
		,s.[OrderSpeculation]
		,0
	)

WHEN MATCHED THEN
	UPDATE SET
		t.[OrderNumber] = s.[OrderNumber]
		,t.[OrderSpeculation] = s.[OrderSpeculation]
		,t.[OrderDeleted] = 0

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.OrderDeleted = 1
;

DROP TABLE IF EXISTS #DimOrder

RETURN 0

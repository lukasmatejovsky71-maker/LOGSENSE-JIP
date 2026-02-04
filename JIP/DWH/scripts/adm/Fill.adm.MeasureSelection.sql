/*
--------------------------------------------------------------------------------------
Fill [adm].[MeasureSelection]
--------------------------------------------------------------------------------------
*/

IF OBJECT_ID('tempdb..#MeasureSelection') IS NOT NULL
    DROP TABLE #MeasureSelection

SELECT TOP 0
  [MeasureSelectionName]
, [MeasureSelectionIndex]
INTO #MeasureSelection
FROM [adm].[MeasureSelection]

INSERT INTO #MeasureSelection (
	[MeasureSelectionName]
	,[MeasureSelectionIndex]
	)
VALUES (
	N'# Orderlines'
	,1
	)
	,(
	N'# MJ'
	,2
	)
	,(
	N'# Objednávky'
	,3
	)
	,(
	N'# Palety'
	,4
	)

;
MERGE [adm].[MeasureSelection] t
USING #MeasureSelection s
	ON t.[MeasureSelectionName] = s.[MeasureSelectionName]
WHEN MATCHED
	THEN
		UPDATE
		SET t.[MeasureSelectionName] = s.[MeasureSelectionName]
			,t.[MeasureSelectionIndex] = s.[MeasureSelectionIndex]
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			[MeasureSelectionName]
			,[MeasureSelectionIndex]
			)
		VALUES (
			s.[MeasureSelectionName]
			,s.[MeasureSelectionIndex]
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE
;

IF OBJECT_ID('tempdb..#MeasureSelection') IS NOT NULL
    DROP TABLE #MeasureSelection

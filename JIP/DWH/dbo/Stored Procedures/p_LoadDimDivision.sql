CREATE PROCEDURE [dbo].[p_LoadDimDivision]
AS

DROP TABLE IF EXISTS #DimDivision

SELECT TOP 0
	[DivisionName]
INTO #DimDivision
FROM [DimDivision]

INSERT INTO #DimDivision
(
	[DivisionName]
)
SELECT DISTINCT
	[Divize] AS [DivisionName]
FROM [dsa].[v_MaterialMovementReceipt]

;
MERGE [DimDivision] AS t
USING #DimDivision AS s ON t.[DivisionName] = s.[DivisionName]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[DivisionName]
	)
	VALUES
	(
		s.[DivisionName]
	)

WHEN MATCHED THEN
	UPDATE SET
		t.[DivisionName] = s.[DivisionName]

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.DivisionDeleted = 1
;

DROP TABLE IF EXISTS #DimDivision

RETURN 0

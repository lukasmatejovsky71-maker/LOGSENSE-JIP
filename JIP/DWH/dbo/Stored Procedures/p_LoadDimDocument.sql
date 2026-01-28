CREATE PROCEDURE [dbo].[p_LoadDimDocument]
AS

DROP TABLE IF EXISTS #DimDocument

SELECT TOP 0
	[DocumentNumber]
INTO #DimDocument
FROM [DimDocument]

INSERT INTO #DimDocument
(
	[DocumentNumber]
)
SELECT DISTINCT
	[Číslo dokladu] AS [DocumentNumber]
FROM [dsa].[v_MaterialMovementReceipt]

;
MERGE [DimDocument] AS t
USING #DimDocument AS s ON t.[DocumentNumber] = s.[DocumentNumber]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[DocumentNumber]
		,[DocumentDeleted]
	)
	VALUES
	(
		s.[DocumentNumber]
		,0
	)

WHEN MATCHED THEN
	UPDATE SET
		t.[DocumentNumber] = s.[DocumentNumber]
		,t.[DocumentDeleted] = 0

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.DocumentDeleted = 1
;

DROP TABLE IF EXISTS #DimDocument

RETURN 0

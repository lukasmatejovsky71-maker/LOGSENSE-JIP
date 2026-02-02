CREATE PROCEDURE [dbo].[p_LoadDimDocument]
AS
/*----------------------------------------------------------------
INSERT an empty row
-----------------------------------------------------------------*/
IF NOT EXISTS (
		SELECT [DocumentId]
		FROM [DimDocument]
		WHERE [DocumentId] = - 1
		)
BEGIN
	SET IDENTITY_INSERT [DimDocument] ON

	INSERT INTO [DimDocument] (
		[DocumentId]
		,[DocumentNumber]
		)
	SELECT - 1 AS [DocumentId]
		,N'' AS [DocumentNumber]

	SET IDENTITY_INSERT [DimDocument] OFF
END

/*----------------------------------------------------------------
Prepare temp table for dimension data
-----------------------------------------------------------------*/
DROP TABLE IF EXISTS #DimDocument

SELECT TOP 0 [DocumentNumber]
INTO #DimDocument
FROM [DimDocument]

/*----------------------------------------------------------------
Prepare dimension data from fact dsa tables
-----------------------------------------------------------------*/
INSERT INTO #DimDocument ([DocumentNumber])
SELECT [Číslo dokladu] AS [DocumentNumber]
FROM [dsa].[v_Document];

MERGE [DimDocument] AS t
USING #DimDocument AS s
	ON t.[DocumentNumber] = s.[DocumentNumber]
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			[DocumentNumber]
			,[DocumentDeleted]
			)
		VALUES (
			s.[DocumentNumber]
			,0
			)
WHEN MATCHED
	THEN
		UPDATE
		SET t.[DocumentNumber] = s.[DocumentNumber]
			,t.[DocumentDeleted] = 0
WHEN NOT MATCHED BY SOURCE
	THEN
		UPDATE
		SET t.DocumentDeleted = 1;

/*----------------------------------------------------------------
Cleanup
-----------------------------------------------------------------*/
DROP TABLE IF EXISTS #DimDocument

RETURN 0

/*
--------------------------------------------------------------------------------------
Fill [dbo].[MovementType]
--------------------------------------------------------------------------------------
*/

IF OBJECT_ID('tempdb..#MovementType') IS NOT NULL
    DROP TABLE #MovementType

SELECT TOP 0
0 [MovementTypeId]
, [MovementTypeName]
INTO #MovementType
FROM [dbo].[DimMovementType]

INSERT
INTO #MovementType
(
[MovementTypeId]
, [MovementTypeName]
)
VALUES
(
1,
N'Příjem'
),
(
2,
N'Výdej'
)

;
MERGE [dbo].[DimMovementType] t
USING #MovementType s
ON t.[MovementTypeId] = s.[MovementTypeId]

WHEN MATCHED AND s.[MovementTypeName] <> t.[MovementTypeName]
THEN
	UPDATE 
	SET
	    [MovementTypeName] = s.[MovementTypeName]

WHEN NOT MATCHED BY TARGET
THEN
	INSERT
	(
	    [MovementTypeId]
		,[MovementTypeName]
	)
	VALUES
	(
	    s.[MovementTypeId]
		,s.[MovementTypeName]
	)

WHEN NOT MATCHED BY SOURCE
THEN
    DELETE
;

IF OBJECT_ID('tempdb..#MovementType') IS NOT NULL
    DROP TABLE #MovementType

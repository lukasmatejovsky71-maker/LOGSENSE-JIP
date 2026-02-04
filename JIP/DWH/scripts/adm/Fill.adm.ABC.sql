/*
--------------------------------------------------------------------------------------
Fill [adm].[ABC]
--------------------------------------------------------------------------------------
*/

IF OBJECT_ID('tempdb..#ABC') IS NOT NULL
    DROP TABLE #ABC

SELECT TOP 0
  [ABCName]
, [ABCFrom]
, [ABCTo]
INTO #ABC
FROM [adm].[ABC]

INSERT INTO #ABC (
	[ABCName]
	,[ABCFrom]
	,[ABCTo]
	)
VALUES (
	N'A'
	,0
	,0.8
	)
	,(
	N'B'
	,0.8
	,0.95
	)
	,(
	N'C'
	,0.95
	,1
	)
;
MERGE [adm].[ABC] t
USING #ABC s
	ON t.[ABCName] = s.[ABCName]
WHEN MATCHED
	THEN
		UPDATE
		SET t.[ABCName] = s.[ABCName]
			,t.[ABCFrom] = s.[ABCFrom]
			,t.[ABCTo] = s.[ABCTo]
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			[ABCName]
			,[ABCFrom]
			,[ABCTo]
			)
		VALUES (
			s.[ABCName]
			,s.[ABCFrom]
			,s.[ABCTo]
			)
WHEN NOT MATCHED BY SOURCE
	THEN
		DELETE
;

IF OBJECT_ID('tempdb..#ABC') IS NOT NULL
    DROP TABLE #ABC

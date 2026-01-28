CREATE PROCEDURE [dbo].[p_LoadDimBranch]
AS

DROP TABLE IF EXISTS #DimBranch

SELECT TOP 0
	 [BranchCode]
	,[BranchName]
	,[BranchDeleted]
INTO #DimBranch
FROM [DimBranch]

INSERT INTO #DimBranch
(
	 [BranchCode]
	,[BranchName]
	,[BranchDeleted]
)
SELECT DISTINCT
 LEFT( [Pobočka], 3) AS [BranchCode]
,SUBSTRING( [Pobočka], 7, 255) AS [BranchName]
,0 AS [BranchDeleted]
FROM [dsa].[v_MaterialMovementReceipt]

;
MERGE [DimBranch] AS t
USING #DimBranch AS s ON t.[BranchName] = s.[BranchName]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		 [BranchCode]
		,[BranchName]
		,[BranchDeleted]
	)
	VALUES
	(
		 s.[BranchCode]
		,s.[BranchName]
		,s.[BranchDeleted]
	)

WHEN MATCHED THEN
	UPDATE SET
		 t.[BranchCode] = s.[BranchCode]
		,t.[BranchName] = s.[BranchName]
		,t.[BranchDeleted] = s.[BranchDeleted]

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.BranchDeleted = 1
;

DROP TABLE IF EXISTS #DimBranch

RETURN 0

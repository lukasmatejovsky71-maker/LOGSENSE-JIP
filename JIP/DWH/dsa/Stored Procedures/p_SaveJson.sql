CREATE PROCEDURE [dsa].[p_SaveJson]
	@FileName NVARCHAR(MAX),
	@FileContent NVARCHAR(MAX)
AS

SELECT TOP 0 
	[SourceFile]
	, [Data]
INTO #json
FROM [dsa].[json]

INSERT INTO #json
(
	[SourceFile]
	, [Data]
)
VALUES
(
	@FileName
	,@FileContent
)

;
MERGE [dsa].[json] AS t
USING #json AS s ON t.[SourceFile] = s.[SourceFile]
WHEN MATCHED THEN
	UPDATE SET
		t.[Data] = s.[Data]

WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[SourceFile]
		,[Data]
	)
	VALUES
	(
		s.[SourceFile]
		,s.[Data]
	)
;

RETURN 0

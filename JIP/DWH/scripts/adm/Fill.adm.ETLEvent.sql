/*
--------------------------------------------------------------------------------------
Fill [adm].[ETLEvent]
--------------------------------------------------------------------------------------
*/

IF OBJECT_ID('tempdb..#ETLEvent') IS NOT NULL
    DROP TABLE #ETLEvent

SELECT TOP 0
0 [ETLEventId]
, [ETLEventName]
INTO #ETLEvent
FROM [adm].[ETLEvent]

INSERT
INTO #ETLEvent
(
[ETLEventId]
, [ETLEventName]
)
VALUES
(
1,
N'Start'
),
(
2,
N'Finished'
),
(
3,
N'Failed'
)

;
MERGE [adm].[ETLEvent] t
USING #ETLEvent s
ON t.[ETLEventId] = s.[ETLEventId]

WHEN MATCHED AND s.[ETLEventName] <> t.[ETLEventName]
THEN
	UPDATE 
	SET
	    [ETLEventName] = s.[ETLEventName]

WHEN NOT MATCHED BY TARGET
THEN
	INSERT
	(
	    [ETLEventId]
		,[ETLEventName]
	)
	VALUES
	(
	    s.[ETLEventId]
		,s.[ETLEventName]
	)

WHEN NOT MATCHED BY SOURCE
THEN
    DELETE
;

IF OBJECT_ID('tempdb..#ETLEvent') IS NOT NULL
    DROP TABLE #ETLEvent

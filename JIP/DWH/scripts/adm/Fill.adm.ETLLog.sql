/*
--------------------------------------------------------------------------------------
Fill [adm].[ETLLog]
--------------------------------------------------------------------------------------
*/
IF OBJECT_ID('tempdb..#ETLLog') IS NOT NULL
    DROP TABLE #ETLLog

IF (N'$(Development)' = N'Yes')
BEGIN
	SELECT
	-1 [ETLLogId]
	, [adm].[f_GetETLEventId] (N'Start') [ETLLog_ETLEventId]
	, 0 [ETLLogServerExecutionId]
	, N'For development purposes only' [ETLLogPackageName]
	INTO #ETLLog

	SET IDENTITY_INSERT [adm].[ETLLog] ON

	MERGE [adm].[ETLLog] t
	USING #ETLLog s
	ON t.[ETLLogId] = s.[ETLLogId]
	WHEN NOT MATCHED BY TARGET
	THEN
	    INSERT
		(
		    [ETLLogId]
			,[ETLLog_ETLEventId]
			,[ETLLogStart]
			,[ETLLogServerExecutionId]
			,[ETLLogPackageName]
		)
		VALUES
		(
		    s.[ETLLogId]
			,s.[ETLLog_ETLEventId]
			,GETDATE()
			,s.[ETLLogServerExecutionId]
			,s.[ETLLogPackageName]
		)
	;

	SET IDENTITY_INSERT [adm].[ETLLog] OFF
END

IF OBJECT_ID('tempdb..#ETLLog') IS NOT NULL
    DROP TABLE #ETLLog

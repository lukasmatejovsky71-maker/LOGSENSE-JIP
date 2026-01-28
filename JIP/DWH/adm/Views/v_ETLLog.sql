CREATE VIEW [adm].[v_ETLLog]
AS 

SELECT 
	 [ETLLogId]
	,[ETLLogServerExecutionId]
	,[ETLLogPackageName]
	,[ETLLogStart]
	,[ETLLogFinish]
	,[dbo].[f_GetTimeSpan]([ETLLogStart], ISNULL( [ETLLogFinish], GETDATE())) AS [ETLLogFormattedDuration]
	,[ETLEvent].[ETLEventName]
	,[ETLLogErrorCode]
	,[ETLLogErrorMessage]
	,[ETLLogLogin]
FROM [adm].[ETLLog]
INNER JOIN [adm].[ETLEvent] ON [ETLLog].[ETLLog_ETLEventId] = [ETLEvent].[ETLEventId]

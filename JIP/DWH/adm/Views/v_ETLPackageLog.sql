CREATE VIEW [adm].[v_ETLPackageLog]
AS

SELECT 
	adm.ETLPackageLog.ETLPackageLog_ETLLogId
	,adm.ETLPackageLog.ETLPackageExecutionInstanceGUID
	,MIN(adm.ETLPackageLog.ETLPackageLogId) ETLPackageLogId
	,MAX(ETLPackageLogPackageName) ETLPackageLogPackageName
	,MAX( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId = 1, adm.ETLPackageLog.ETLPackageLogTime, NULL)) ETLPackageLogStartTime
	,MAX( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId IN (2,3), adm.ETLPackageLog.ETLPackageLogTime, NULL)) ETLPackageLogFinishTime
	,ROUND( DATEDIFF(second
	  ,MIN( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId = 1, adm.ETLPackageLog.ETLPackageLogTime, NULL))
	  ,ISNULL( MAX( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId IN (2,3), adm.ETLPackageLog.ETLPackageLogTime, NULL)), GETDATE())
	  ) / 60.0000, 2) ETLPackageLogDuration
	, [dbo].[f_GetTimeSpan](
	   MIN( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId = 1, adm.ETLPackageLog.ETLPackageLogTime, NULL))
	  ,ISNULL( MAX( IIF( adm.ETLPackageLog.ETLPackageLog_ETLEventId IN (2,3), adm.ETLPackageLog.ETLPackageLogTime, NULL)), GETDATE())
	) AS ETLPackageLogFormattedDuration
	, CASE MAX(adm.ETLPackageLog.ETLPackageLog_ETLEventId) WHEN 1 THEN 'Running' WHEN 2 THEN 'Finished' WHEN 3 THEN 'Failed' ELSE NULL END Status
	,MAX(adm.ETLPackageLog.ETLPackageLogErrorMsg) AS ETLPackageLogErrorMsg
	,MAX([ETLPackageLogLogin]) AS [ETLPackageLogLogin]
FROM adm.ETLPackageLog
--WHERE adm.ETLPackageLog.ETLPackageLog_ETLLogId = (SELECT MAX(ETLLogId) FROM adm.ETLLog)
GROUP BY 
	adm.ETLPackageLog.ETLPackageLog_ETLLogId
	,adm.ETLPackageLog.ETLPackageExecutionInstanceGUID
--ORDER BY
--	adm.ETLPackageLog.ETLPackageLog_ETLLogId DESC
--	,MIN(adm.ETLPackageLog.ETLPackageLogId)


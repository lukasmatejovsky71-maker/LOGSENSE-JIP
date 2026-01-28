CREATE PROCEDURE [adm].[p_LogETLPackageLogSuccess]
    @ETLLogId INT
	,@MachineName sysname
	,@PackageName sysname
	,@UserName sysname
	,@ExecutionInstanceGUID UNIQUEIDENTIFIER

AS
DECLARE
	@ETLEventId INT = [adm].[f_GetETLEventId] (N'Finished')

INSERT INTO [adm].[ETLPackageLog]
(
    [ETLPackageLog_ETLLogId]
	,[ETLPackageLogTime]
	,[ETLPackageLog_ETLEventId]
	,[ETLPackageLogMachineName]
	,[ETLPackageLogPackageName]
	,[ETLPackageLogUserName]
	,[ETLPackageExecutionInstanceGUID]
)
VALUES
(
    @ETLLogId
	,GETDATE()
	,@ETLEventId
	,@MachineName
	,@PackageName
	,@UserName
	,@ExecutionInstanceGUID
)

RETURN 0

CREATE PROCEDURE [adm].[p_LogETLPackageLogStart]
    @ETLLogId INT
	,@MachineName sysname
	,@PackageName sysname
	,@UserName sysname
	,@ExecutionInstanceGUID UNIQUEIDENTIFIER

AS
DECLARE
	@ETLEventId INT = [adm].[f_GetETLEventId] (N'Start')

INSERT INTO [adm].[ETLPackageLog]
(
    [ETLPackageLog_ETLLogId]
	,[ETLPackageLogTime]
	,[ETLPackageLog_ETLEventId]
	,[ETLPackageLogMachineName]
	,[ETLPackageLogPackageName]
	,[ETLPackageLogUserName]
	,[ETLPackageExecutionInstanceGUID]
	,[ETLPackageLogLogin]
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
	,SUSER_SNAME()
)

RETURN 0

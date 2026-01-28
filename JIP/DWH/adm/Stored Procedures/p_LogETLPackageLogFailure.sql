CREATE PROCEDURE [adm].[p_LogETLPackageLogFailure]
    @ETLLogId INT
	,@MachineName sysname
	,@PackageName sysname
	,@UserName sysname
	,@ExecutionInstanceGUID UNIQUEIDENTIFIER
    ,@SourceName sysname
    ,@TaskName sysname
	,@ErrorCode INT
	,@ErrorMessage NVARCHAR(MAX)

AS
DECLARE
	@ETLEventId INT = [adm].[f_GetETLEventId] (N'Failed')

INSERT INTO [adm].[ETLPackageLog]
(
    [ETLPackageLog_ETLLogId]
	,[ETLPackageLogTime]
	,[ETLPackageLog_ETLEventId]
	,[ETLPackageLogMachineName]
	,[ETLPackageLogPackageName]
	,[ETLPackageLogUserName]
	,[ETLPackageExecutionInstanceGUID]
    ,[ETLPackageLogSourceName]
    ,[ETLPackageLogTaskName]
	,[ETLPackageLogErrorCode]
	,[ETLPackageLogErrorMsg]
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
	,@SourceName
	,@TaskName
	,@ErrorCode
	,@ErrorMessage
)

RETURN 0

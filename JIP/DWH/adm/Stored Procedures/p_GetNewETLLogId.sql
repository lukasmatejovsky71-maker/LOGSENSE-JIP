CREATE PROCEDURE [adm].[p_GetNewETLLogId] 
@PackageName sysname,
@ServerExecutionId BIGINT

AS
BEGIN

DECLARE 
    @ETLEventId INT
	,@StartDate DATETIME

SELECT
    @ETLEventId = [adm].[f_GetETLEventId] (N'Start')
	,@StartDate = GETDATE()

INSERT 
INTO [adm].[ETLLog]
(
	[ETLLog_ETLEventId]
	,[ETLLogStart]
	,[ETLLogServerExecutionId]
	,[ETLLogPackageName]
	,[ETLLogLogin]
)
VALUES
(
    @ETLEventId
	,@StartDate
	,@ServerExecutionId
	,@PackageName
	,SUSER_SNAME()
)

SELECT
    @@IDENTITY [ETLLogId]

END
RETURN
CREATE PROCEDURE [adm].[p_UpdateETLLogFailure]
	@ETLLogId INT
	,@ErrorCode INT
	,@ErrorMessage NVARCHAR(MAX)
AS

DECLARE 
    @ETLEventId INT = [adm].[f_GetETLEventId](N'Failed'),
	@ETLLogErrorMessage NVARCHAR(MAX) = 
	    (
		SELECT [ETLLogErrorMessage] + CHAR(13) + CHAR(10)
		FROM [adm].[ETLLog] 
		WHERE [ETLLogId] = @ETLLogId
		)

UPDATE [adm].[ETLLog]
SET
	[ETLLog_ETLEventId] = @ETLEventId
	,[ETLLogFinish] = GETDATE()
	,[ETLLogErrorCode] = @ErrorCode
	,[ETLLogErrorMessage] = ISNULL(@ETLLogErrorMessage, N'') + @ErrorMessage
WHERE [ETLLogId] = @ETLLogId

RETURN 0

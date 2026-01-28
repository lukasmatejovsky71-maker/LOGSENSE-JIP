CREATE PROCEDURE [adm].[p_UpdateETLLogSuccess]
	@ETLLogId INT
AS

DECLARE @ETLEventId INT = [adm].[f_GetETLEventId](N'Finished')

UPDATE [adm].[ETLLog]
SET
	[ETLLog_ETLEventId] = @ETLEventId
	,[ETLLogFinish] = GETDATE()
WHERE [ETLLogId] = @ETLLogId

RETURN 0

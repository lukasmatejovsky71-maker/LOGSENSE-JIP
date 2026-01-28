CREATE FUNCTION [dbo].[f_GetTimeSpan] (@StartDate DATETIME, @EndDate DATETIME)
RETURNS NVARCHAR(max)
BEGIN
DECLARE 
	@TimeSpan DECIMAL(10, 2) = DATEDIFF(SECOND, @StartDate, @EndDate)
	,@Days INT
	,@Hours INT
	,@Minutes INT
	,@Seconds DECIMAL(10,2)
	,@FormattedTimeSpan NVARCHAR(max)

SET @Days = @TimeSpan / 86400
SET @Hours = (@TimeSpan % 86400) / 3600
SET @Minutes = ((@TimeSpan % 86400) % 3600) / 60
SET @Seconds = (((@TimeSpan % 86400) % 3600) % 60)
SET @FormattedTimeSpan =
	IIF( @Days > 0, CONVERT(NVARCHAR(max), @Days) + ' days ', '')
	+FORMAT(@Hours, '00:')
	+FORMAT(@Minutes, '00:')
	+FORMAT(@Seconds, '00')
RETURN	@FormattedTimeSpan

END

CREATE FUNCTION [dbo].[f_GetFullName] (
	@code NVARCHAR(255)
	,@name NVARCHAR(255)
	)
RETURNS NVARCHAR(1024)
AS
BEGIN
	RETURN @code + IIF(@name NOT IN (
				N''
				,N'#'
				,N'#N/A'
				), N' - ' + @name, N'')
END

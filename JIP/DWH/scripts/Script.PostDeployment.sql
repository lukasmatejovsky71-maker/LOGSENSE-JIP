/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


/*
--------------------------------------------------------------------------------------
Allow ad-hoc queries (OPENQUERY, OPENROWSET)
--------------------------------------------------------------------------------------
*/
EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE
GO

/*
--------------------------------------------------------------------------------------
Administrative tables
--------------------------------------------------------------------------------------
*/
:r .\adm\Fill.adm.ETLOption.sql
:r .\adm\Fill.adm.ETLConfiguration.sql
:r .\adm\Fill.adm.ETLEvent.sql
:r .\adm\Fill.adm.ETLLog.sql

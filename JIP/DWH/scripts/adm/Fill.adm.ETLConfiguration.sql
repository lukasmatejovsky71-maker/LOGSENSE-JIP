/*
--------------------------------------------------------------------------------------
Fill [adm].[ETLConfiguration]
--------------------------------------------------------------------------------------
*/
IF OBJECT_ID('tempdb..#ETLConfiguration') IS NOT NULL
    DROP TABLE #ETLConfiguration

SELECT TOP 0
  [ConfigurationFilter]
  ,[ConfiguredValue]
  ,[PackagePath]
  ,[ConfiguredValueType]
INTO #ETLConfiguration
FROM [adm].[ETLConfiguration]

INSERT INTO #ETLConfiguration
(
  [ConfigurationFilter]
  ,[ConfiguredValue]
  ,[PackagePath]
  ,[ConfiguredValueType]
)
VALUES
/* Tabular model connection string */
(
N'Connections'
,N'Data Source=SE15-SQL-DEV;Initial Catalog=$(TAB);Provider=MSOLAP.8;Integrated Security=SSPI;Impersonation Level=Impersonate;'
,N'\Package.Variables[User::TABConnectionString].Properties[Value]'
,N'String'
),
/* Tabular model database name */
(
N'Connections'
,N'$(TAB)'
,N'\Package.Variables[User::TABDatabaseName].Properties[Value]'
,N'String'
),
/* Flat files import folter */
(
N'Connections'
,N'C:\Users\lukas\source\repos\actum_digital_bic_casestudy\actum_digital_bic_casestudy\Import'
,N'\Package.Variables[User::FlatFilesFolder].Properties[Value]'
,N'String'
)




;
MERGE [adm].[ETLConfiguration] t
USING #ETLConfiguration s
ON t.[PackagePath] = s.[PackagePath]
WHEN NOT MATCHED BY TARGET
THEN
  INSERT
  (
    [ConfigurationFilter]
    ,[ConfiguredValue]
    ,[PackagePath]
    ,[ConfiguredValueType]
  )
  VALUES
  (
    s.[ConfigurationFilter]
    ,s.[ConfiguredValue]
    ,s.[PackagePath]
    ,s.[ConfiguredValueType]
  )
;

IF OBJECT_ID('tempdb..#ETLConfiguration') IS NOT NULL
    DROP TABLE #ETLConfiguration

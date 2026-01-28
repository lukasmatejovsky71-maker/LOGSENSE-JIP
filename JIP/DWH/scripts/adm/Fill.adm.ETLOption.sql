/*
--------------------------------------------------------------------------------------
Fill [adm].[ETLOption]
--------------------------------------------------------------------------------------
*/
IF OBJECT_ID('tempdb..#ETLOption') IS NOT NULL
    DROP TABLE #ETLOption

SELECT TOP 0
      [ETLOptionName]
    , [ETLOptionValue]
    , [ETLOptionDescription]
    , [ETLOptionCreated]
    , [ETLOptionCreatedBy]
    , [ETLOptionModified]
    , [ETLOptionModifiedBy]
    , [ETLOptionDeleted]
    , [ETLOptionDeletedBy]    
INTO #ETLOption
FROM [adm].[ETLOption]

INSERT INTO #ETLOption
(
      [ETLOptionName]
    , [ETLOptionValue]
    , [ETLOptionDescription]
    , [ETLOptionCreated]
    , [ETLOptionCreatedBy]
    , [ETLOptionModified]
    , [ETLOptionModifiedBy]
    , [ETLOptionDeleted]
    , [ETLOptionDeletedBy]    
)
VALUES
-- Name of the ETL package to start ETL
(
    N'ETLExecutionPackage'
    ,'MasterExecute.dtsx'
    ,'Name of the ETL package to start ETL'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),
-- Name of the ETL package to start ETL
(
    N'ETLProjectDWHConnectionString'
    ,N'Data Source=' + @@SERVERNAME + ';Initial Catalog=' + DB_NAME() + ';Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;'
    ,N'Name of the ETL package to start ETL'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),

-- Name of the ETL SSISDB Folder
(
    N'ETLFolder'
    ,N'$(ETLFolder)'
    ,N'Name of the ETL SSISDB Folder'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),

-- Name of the ETL SSISDB Project
(
    N'ETLProject'
    ,N'$(ETLProject)'
    ,N'Name of the ETL SSISDB Project'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),
-- Name of the ETL execution login
(
    N'ETLExecutionLogin'
    ,N'BGAD\sqlsde'
    ,N'Name of the ETL execution login'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),
-- Name of the SMTPServer
(
    N'SMTPServer'
    ,N'10.10.255.11'
    ,N'Name of the SMTPServer'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),
-- Name of the SMTPEmail
(
    N'SMTPEmail'
    ,N'SQLserverCZ@autoneum.com'
    ,N'Name of the SMTPEmail'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
),
-- Active Directory Code
(
    N'ActiveDirectoryCode'
    ,N'BGAD'
    ,N'Active Directory Code'
    ,GETDATE()
    ,SUSER_SNAME()
    ,GETDATE()
    ,SUSER_SNAME()
    ,0
    , NULL
)



;
MERGE [adm].[ETLOption] t
USING #ETLOption s
ON  t.[ETLOptionName] = s.[ETLOptionName]

WHEN NOT MATCHED BY TARGET
THEN
INSERT
(
   [ETLOptionName]
  ,[ETLOptionValue]
  ,[ETLOptionDescription]
  ,[ETLOptionCreated]
  ,[ETLOptionCreatedBy]
  ,[ETLOptionModified]
  ,[ETLOptionModifiedBy]
  ,[ETLOptionDeleted]
  ,[ETLOptionDeletedBy]
)
VALUES
(
   s.[ETLOptionName]
  ,s.[ETLOptionValue]
  ,s.[ETLOptionDescription]
  ,s.[ETLOptionCreated]
  ,s.[ETLOptionCreatedBy]
  ,s.[ETLOptionModified]
  ,s.[ETLOptionModifiedBy]
  ,s.[ETLOptionDeleted]
  ,s.[ETLOptionDeletedBy]
)
;

IF OBJECT_ID('tempdb..#ETLOption') IS NOT NULL
    DROP TABLE #ETLOption

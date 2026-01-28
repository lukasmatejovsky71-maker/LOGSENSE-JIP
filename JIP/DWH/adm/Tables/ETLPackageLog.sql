CREATE TABLE [adm].[ETLPackageLog] (
    [ETLPackageLogId]             INT             IDENTITY (1, 1) NOT NULL,
    [ETLPackageLog_ETLLogId]      INT             NOT NULL,
    [ETLPackageLogTime]           DATETIME        CONSTRAINT [DF_ETLPackageLog_ETLPackageLogTime] DEFAULT (GETDATE()) NOT NULL,
    [ETLPackageLog_ETLEventId]    INT             CONSTRAINT [FK_adm_ETLPackageLog_ETLPackageLog_ETLEventId] FOREIGN KEY REFERENCES [adm].[ETLEvent]([ETLEventId]) NOT NULL,
    [ETLPackageLogMachineName]    sysname  NULL,
    [ETLPackageLogPackageName]    sysname  NULL,
    [ETLPackageLogUserName]       sysname  NULL,
    [ETLPackageExecutionInstanceGUID] UNIQUEIDENTIFIER NOT NULL,
    [ETLPackageLogSourceName]     NVARCHAR (255)  NULL,
    [ETLPackageLogTaskName]       NVARCHAR (255)  NULL,
--    [ETLPackageLogTableName]      NVARCHAR (255)  NULL,
--    [ETLPackageLogRowCountSource] INT             NULL,
--    [ETLPackageLogRowCountTarget] INT             NULL,
--    [ETLPackageLogImportLogMsg]   NVARCHAR (500)  NULL,
    [ETLPackageLogErrorCode]      INT             NULL,
    [ETLPackageLogErrorMsg]       NVARCHAR (MAX)  NULL,
    [ETLPackageLogLogin]          NVARCHAR(128)   NULL,
    CONSTRAINT [PK_ETLPackageLog] PRIMARY KEY CLUSTERED ([ETLPackageLogId] ASC),
    CONSTRAINT [FK_ETLPackageLog_ETLPackageLog_ETLLogId]
        FOREIGN KEY ([ETLPackageLog_ETLLogId])
        REFERENCES [adm].[ETLLog] ([ETLLogId])
);

GO;
CREATE NONCLUSTERED INDEX [IX_adm_ETLPackageLog_ETLPackageLogTime]
ON [adm].[ETLPackageLog] ([ETLPackageLogTime])
INCLUDE ([ETLPackageLogId],[ETLPackageLog_ETLLogId],[ETLPackageLog_ETLEventId],[ETLPackageLogPackageName])

GO;
CREATE NONCLUSTERED INDEX [IX_adm_ETLPackageLog_ETLLogId]
ON [adm].[ETLPackageLog] ([ETLPackageLog_ETLLogId],[ETLPackageLogTime])
INCLUDE ([ETLPackageLogId],[ETLPackageLog_ETLEventId],[ETLPackageLogPackageName])

GO;
CREATE NONCLUSTERED INDEX [IX_adm_ETLPackageLog_ETLPackageLogPackageName]
ON [adm].[ETLPackageLog] ([ETLPackageLogPackageName])
INCLUDE ([ETLPackageLogId],[ETLPackageLog_ETLLogId],[ETLPackageLogTime],[ETLPackageLog_ETLEventId])

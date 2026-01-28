CREATE TABLE [adm].[ETLOption] (
    [ETLOptionId]          INT            IDENTITY (1, 1) NOT NULL,
    [ETLOptionName]        NVARCHAR (255) NOT NULL,
    [ETLOptionValue]       NVARCHAR (255) NULL,
    [ETLOptionDescription] NVARCHAR (255) NULL,
    [ETLOptionCreated]     DATETIME       CONSTRAINT [DF_adm_ETLOption_ETLOptionCreated] DEFAULT (getdate()) NOT NULL,
    [ETLOptionCreatedBy]   NVARCHAR (100) NOT NULL,
    [ETLOptionModified]    DATETIME       NULL,
    [ETLOptionModifiedBy]  NVARCHAR (100) NULL,
    [ETLOptionDeleted]     DATETIME       NULL,
    [ETLOptionDeletedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_adm_ETLOption] PRIMARY KEY CLUSTERED ([ETLOptionId] ASC),
    CONSTRAINT [UNQ_adm_ETLOption_ETLOptionDeleted] UNIQUE NONCLUSTERED ([ETLOptionName] ASC, [ETLOptionDeleted] ASC)
);


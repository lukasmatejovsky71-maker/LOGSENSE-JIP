CREATE TABLE [dbo].[DimDocument]
(
	[DocumentId] INT NOT NULL CONSTRAINT [PK_DimDocument_DocumentId] PRIMARY KEY IDENTITY (1,1),
	[DocumentNumber] NVARCHAR(255) NOT NULL,
	[DocumentDeleted] BIT NOT NULL DEFAULT 0
)

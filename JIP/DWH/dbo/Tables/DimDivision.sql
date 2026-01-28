CREATE TABLE [dbo].[DimDivision]
(
	[DivisionId] INT NOT NULL CONSTRAINT [PK_DimDivision_DivisionId] PRIMARY KEY IDENTITY (1,1),
	[DivisionName] NVARCHAR(255) NOT NULL,
	[DivisionDeleted] BIT NOT NULL DEFAULT 0
)

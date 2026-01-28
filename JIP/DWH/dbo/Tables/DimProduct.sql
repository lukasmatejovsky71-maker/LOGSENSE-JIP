CREATE TABLE [dbo].[DimProduct]
(
	[ProductId] INT NOT NULL CONSTRAINT [PK_DimProduct] PRIMARY KEY IDENTITY (1,1),
		[ProductCode] NVARCHAR(50) NOT NULL,
		[ProductDeleted] BIT NOT NULL DEFAULT 0
)

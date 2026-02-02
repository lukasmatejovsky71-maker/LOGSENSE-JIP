CREATE TABLE [dbo].[DimOrder]
(
	[OrderId] INT NOT NULL CONSTRAINT [PK_DimOrder_OrderId] PRIMARY KEY IDENTITY (1,1),
	[OrderNumber] NVARCHAR(255) NOT NULL,
	[OrderSpeculation] BIT NOT NULL CONSTRAINT [DF_DimOrder_OrderSpeculation] DEFAULT 0,
	[OrderDeleted] BIT NOT NULL CONSTRAINT [DF_DimOrder_OrderDeleted] DEFAULT 0
)

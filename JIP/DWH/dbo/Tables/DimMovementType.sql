CREATE TABLE [dbo].[DimMovementType]
(
	[MovementTypeId] INT NOT NULL CONSTRAINT [PK_DimMovementType] PRIMARY KEY
	,[MovementTypeName] NVARCHAR(50) NOT NULL
)

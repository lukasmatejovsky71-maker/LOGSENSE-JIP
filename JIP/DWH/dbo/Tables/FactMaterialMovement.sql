CREATE TABLE [dbo].[FactMaterialMovement] (
	[MaterialMovementId] INT NOT NULL CONSTRAINT [PK_FactMaterialMovement] PRIMARY KEY IDENTITY(1, 1)
	,[MaterialMovement_DateId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimDate] REFERENCES dbo.DimDate(DateId)
	,[MaterialMovement_DivisionId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimDivision] REFERENCES dbo.DimDivision(DivisionId)
	,[MaterialMovement_BranchId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimBranch] REFERENCES dbo.DimBranch(BranchId)
	,[MaterialMovement_DocumentId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimDocument] REFERENCES dbo.DimDocument(DocumentId)
	,[MaterialMovement_ProductId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimProduct] REFERENCES dbo.DimProduct(ProductId)
	,[MaterialMovement_SupplierId] INT NOT NULL CONSTRAINT [FK_FactMaterialMovement_DimSupplier] REFERENCES dbo.DimSupplier(SupplierId)
	,[MaterialMovementTurnoverUoM] DECIMAL(18, 4) NULL
	,[MaterialMovementTurnoverPalletes] DECIMAL(18, 4) NULL
	,
	)
GO;
CREATE INDEX [IX_MaterialMovement_MaterialMovement_DateId] ON [FactMaterialMovement]([MaterialMovement_DateId])

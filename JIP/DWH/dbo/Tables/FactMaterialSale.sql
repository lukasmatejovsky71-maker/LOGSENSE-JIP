CREATE TABLE [dbo].[FactMaterialSale]
(
	[MaterialSaleId] INT NOT NULL CONSTRAINT [PK_FactMaterialSale] PRIMARY KEY IDENTITY (1,1),
	[MaterialSale_DateId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimDate] REFERENCES dbo.DimDate(DateId),
	[MaterialSale_DivisionId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimDivision] REFERENCES dbo.DimDivision(DivisionId),
	[MaterialSale_BranchId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimBranch] REFERENCES dbo.DimBranch(BranchId),
	[MaterialSale_DocumentId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimDocument] REFERENCES dbo.DimDocument(DocumentId),
	[MaterialSale_ProductId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimProduct] REFERENCES dbo.DimProduct(ProductId),
	[MaterialSale_SupplierId] INT NOT NULL CONSTRAINT [FK_FactMaterialSale_DimSupplier] REFERENCES dbo.DimSupplier(SupplierId),
	[MaterialSaleTurnoverUoM] DECIMAL(18, 4)  NULL,
	[MaterialSaleTurnoverPalletes] DECIMAL(18, 4) NULL,
)
GO;
CREATE INDEX [IX_MaterialSale_MaterialSale_DateId] ON [FactMaterialSale]([MaterialSale_DateId])

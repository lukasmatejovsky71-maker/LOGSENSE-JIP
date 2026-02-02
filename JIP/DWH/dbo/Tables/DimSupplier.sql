CREATE TABLE [dbo].[DimSupplier]
(
	[SupplierId] INT NOT NULL CONSTRAINT [PK_DimSupplier_SupplierId] PRIMARY KEY IDENTITY (1,1),
	[SupplierICO] NVARCHAR(255) NOT NULL,
	[SupplierName] NVARCHAR(255) NOT NULL CONSTRAINT [DF_DimSupplier_SupplierName]  DEFAULT (N''),
	[SupplierCity] NVARCHAR(255) NOT NULL CONSTRAINT [DF_DimSupplier_SupplierCity]  DEFAULT (N''),
	[SupplierIsJIP] BIT NOT NULL CONSTRAINT [DF_DimSupplier_SupplierIsJIP] DEFAULT 0,
	[SupplierDeleted] BIT NOT NULL CONSTRAINT [DF_DimSupplier_SupplierDeleted] DEFAULT 0
)

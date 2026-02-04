CREATE TABLE [dbo].[DimProduct] (
	[ProductId] INT NOT NULL CONSTRAINT [PK_DimProduct] PRIMARY KEY IDENTITY(1, 1)
	,[ProductCode] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductCode] DEFAULT N''
	,[ProductCardType] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductCardType] DEFAULT N''
	,[ProductName] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductName] DEFAULT N''
	,[ProductSupplier] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductSupplier] DEFAULT N''
	,[ProductSupplierDescription] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductSupplierDescription] DEFAULT N''
	,[ProductUnitsInPackage] FLOAT(53) NULL
	,[ProductUnitsOnPallet] FLOAT(53) NULL
	,[ProductWeight InKg] FLOAT(53) NULL
	,[ProductDimensionsPcs_mm] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductDimensionsPcs_mm] DEFAULT N''
	,[ProductDimensionsCarton_mm] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductDimensionsCarton_mm] DEFAULT N''
	,[ProductDimensionsDisplay_mm] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductDimensionsDisplay_mm] DEFAULT N''
	,[ProductTemperatureMode] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductTemperatureMode] DEFAULT N''
	,[ProductGroup2] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductGroup2] DEFAULT N''
	,[ProductGroup2Description] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductGroup2Description] DEFAULT N''
	,[ProductContainerGroup2] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductContainerGroup2] DEFAULT N''
	,[ProductContainerGroup2pop] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductContainerGroup2pop] DEFAULT N''
	,[ProductWarranty] FLOAT(53) NULL
	,[ProductStockPrice] FLOAT(53) NULL
	,[ProductMinVolPac#] FLOAT(53) NULL
	,[ProductUnit] NVARCHAR(510) NOT NULL CONSTRAINT [DF_DimProduct_ProductUnit] DEFAULT N''
	,[ProductDeleted] BIT NOT NULL DEFAULT 0
	)

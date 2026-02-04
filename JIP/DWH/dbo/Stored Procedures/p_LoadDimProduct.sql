CREATE PROCEDURE [dbo].[p_LoadDimProduct]
AS
DROP TABLE

IF EXISTS #DimProduct
	SELECT TOP 0 [ProductCode]
		,[ProductCardType]
		,[ProductName]
		,[ProductSupplier]
		,[ProductSupplierDescription]
		,[ProductUnitsInPackage]
		,[ProductUnitsOnPallet]
		,[ProductWeight InKg]
		,[ProductDimensionsPcs_mm]
		,[ProductDimensionsCarton_mm]
		,[ProductDimensionsDisplay_mm]
		,[ProductTemperatureMode]
		,[ProductGroup2]
		,[ProductGroup2Description]
		,[ProductContainerGroup2]
		,[ProductContainerGroup2pop]
		,[ProductWarranty]
		,[ProductStockPrice]
		,[ProductMinVolPac#]
		,[ProductUnit]
		,[ProductDeleted]
	INTO #DimProduct
	FROM [DimProduct]

INSERT INTO #DimProduct (
	[ProductCode]
	,[ProductCardType]
	,[ProductName]
	,[ProductSupplier]
	,[ProductSupplierDescription]
	,[ProductUnitsInPackage]
	,[ProductUnitsOnPallet]
	,[ProductWeight InKg]
	,[ProductDimensionsPcs_mm]
	,[ProductDimensionsCarton_mm]
	,[ProductDimensionsDisplay_mm]
	,[ProductTemperatureMode]
	,[ProductGroup2]
	,[ProductGroup2Description]
	,[ProductContainerGroup2]
	,[ProductContainerGroup2pop]
	,[ProductWarranty]
	,[ProductStockPrice]
	,[ProductMinVolPac#]
	,[ProductUnit]
	,[ProductDeleted]
	)
SELECT ISNULL(p.[Kód], vp.[ProductCode]) AS [Code]
	,ISNULL([druh karty], N'') AS [CardType]
	,ISNULL([Název], N'') AS [Name]
	,ISNULL([Dodavatel], N'') AS [Supplier]
	,ISNULL([Dodavatel-popis], N'') AS [SupplierDescription]
	,[MJ v balení] AS [UnitsInPackage]
	,[MJ na paletě] AS [UnitsOnPallet]
	,[Hmotnost v kg] AS [Weight InKg]
	,ISNULL([Rozměry ks (mm)], N'') AS [DimensionsPcs_mm]
	,ISNULL([Rozměry karton (mm)], N'') AS [DimensionsCarton_mm]
	,ISNULL([Rozměry display (mm)], N'') AS [DimensionsDisplay_mm]
	,ISNULL([Teplotní režim], N'') AS [TemperatureMode]
	,ISNULL([Skupina2], N'') AS [Group2]
	,ISNULL([Skupina2-popis], N'') AS [Group2Description]
	,ISNULL([Nadř#skup#2], N'') AS [ContainerGroup2]
	,ISNULL([Nadř#skup#2 pop#], N'') AS [ContainerGroup2pop]
	,[Záruka] AS [Warranty]
	,[Skladová cena] AS [StockPrice]
	,[Min# obj# bal#] AS [MinVolPack]
	,ISNULL([Jednotka MJ], N'') AS [Unit]
	,0 AS [ProductDeleted]
FROM [dsa].[Product] AS p
FULL OUTER JOIN [dsa].[v_Product] AS vp ON p.[Kód] = vp.[ProductCode];

MERGE [DimProduct] AS t
USING #DimProduct AS s
	ON t.[ProductCode] = s.[ProductCode]
WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (
			[ProductCode]
			,[ProductCardType]
			,[ProductName]
			,[ProductSupplier]
			,[ProductSupplierDescription]
			,[ProductUnitsInPackage]
			,[ProductUnitsOnPallet]
			,[ProductWeight InKg]
			,[ProductDimensionsPcs_mm]
			,[ProductDimensionsCarton_mm]
			,[ProductDimensionsDisplay_mm]
			,[ProductTemperatureMode]
			,[ProductGroup2]
			,[ProductGroup2Description]
			,[ProductContainerGroup2]
			,[ProductContainerGroup2pop]
			,[ProductWarranty]
			,[ProductStockPrice]
			,[ProductMinVolPac#]
			,[ProductUnit]
			,[ProductDeleted]
			)
		VALUES (
			s.[ProductCode]
			,s.[ProductCardType]
			,s.[ProductName]
			,s.[ProductSupplier]
			,s.[ProductSupplierDescription]
			,s.[ProductUnitsInPackage]
			,s.[ProductUnitsOnPallet]
			,s.[ProductWeight InKg]
			,s.[ProductDimensionsPcs_mm]
			,s.[ProductDimensionsCarton_mm]
			,s.[ProductDimensionsDisplay_mm]
			,s.[ProductTemperatureMode]
			,s.[ProductGroup2]
			,s.[ProductGroup2Description]
			,s.[ProductContainerGroup2]
			,s.[ProductContainerGroup2pop]
			,s.[ProductWarranty]
			,s.[ProductStockPrice]
			,s.[ProductMinVolPac#]
			,s.[ProductUnit]
			,s.[ProductDeleted]
			)
WHEN MATCHED
	THEN
		UPDATE
		SET t.[ProductCode] = s.[ProductCode]
			,t.[ProductCardType] = s.[ProductCardType]
			,t.[ProductName] = s.[ProductName]
			,t.[ProductSupplier] = s.[ProductSupplier]
			,t.[ProductSupplierDescription] = s.[ProductSupplierDescription]
			,t.[ProductUnitsInPackage] = s.[ProductUnitsInPackage]
			,t.[ProductUnitsOnPallet] = s.[ProductUnitsOnPallet]
			,t.[ProductWeight InKg] = s.[ProductWeight InKg]
			,t.[ProductDimensionsPcs_mm] = s.[ProductDimensionsPcs_mm]
			,t.[ProductDimensionsCarton_mm] = s.[ProductDimensionsCarton_mm]
			,t.[ProductDimensionsDisplay_mm] = s.[ProductDimensionsDisplay_mm]
			,t.[ProductTemperatureMode] = s.[ProductTemperatureMode]
			,t.[ProductGroup2] = s.[ProductGroup2]
			,t.[ProductGroup2Description] = s.[ProductGroup2Description]
			,t.[ProductContainerGroup2] = s.[ProductContainerGroup2]
			,t.[ProductContainerGroup2pop] = s.[ProductContainerGroup2pop]
			,t.[ProductWarranty] = s.[ProductWarranty]
			,t.[ProductStockPrice] = s.[ProductStockPrice]
			,t.[ProductMinVolPac#] = s.[ProductMinVolPac#]
			,t.[ProductUnit] = s.[ProductUnit]
			,t.[ProductDeleted] = 0
WHEN NOT MATCHED BY SOURCE
	THEN
		UPDATE
		SET t.ProductDeleted = 1;

DROP TABLE

IF EXISTS #DimProduct
	RETURN 0

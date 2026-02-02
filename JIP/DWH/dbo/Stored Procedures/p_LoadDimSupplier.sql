CREATE PROCEDURE [dbo].[p_LoadDimSupplier]
AS

DROP TABLE IF EXISTS #DimSupplier

SELECT TOP 0
	[SupplierICO]
	,[SupplierName]
	,[SupplierCity]
	,[SupplierIsJIP]
INTO #DimSupplier
FROM [DimSupplier]

INSERT INTO #DimSupplier
(
	[SupplierICO]
	,[SupplierName]
	,[SupplierCity]
	,[SupplierIsJIP]
)
SELECT DISTINCT
	[IČO] AS [SupplierICO]
	,[K jméno]
	,[K město]
	,[SupplierIsJIP]
FROM [dsa].[v_Supplier]

;
MERGE [DimSupplier] AS t
USING #DimSupplier AS s ON t.[SupplierICO] = s.[SupplierICO]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[SupplierICO]
		,[SupplierName]
		,[SupplierCity]
		,[SupplierIsJIP]
		,[SupplierDeleted]
	)
	VALUES
	(
		s.[SupplierICO]
		,s.[SupplierName]
		,s.[SupplierCity]
		,s.[SupplierIsJIP]
		,0
	)

WHEN MATCHED THEN
	UPDATE SET
		t.[SupplierICO] = s.[SupplierICO]
		,t.[SupplierName] = s.[SupplierName]
		,t.[SupplierCity] = s.[SupplierCity]
		,t.[SupplierIsJIP] = s.[SupplierIsJIP]
		,t.[SupplierDeleted] = 0

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.SupplierDeleted = 1
;

DROP TABLE IF EXISTS #DimSupplier

RETURN 0

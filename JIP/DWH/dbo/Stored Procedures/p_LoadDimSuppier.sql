CREATE PROCEDURE [dbo].[p_LoadDimSupplier]
AS

DROP TABLE IF EXISTS #DimSupplier

SELECT TOP 0
	[SupplierICO]
	,[SupplierIsJIP]
INTO #DimSupplier
FROM [DimSupplier]

INSERT INTO #DimSupplier
(
	[SupplierICO]
	,[SupplierIsJIP]
)
SELECT DISTINCT
	[IČO] AS [SupplierICO]
	,IIF([IČO] LIKE '27464822%', 1, 0) AS [SupplierIsJIP]
FROM [dsa].[v_MaterialMovementReceipt]

;
MERGE [DimSupplier] AS t
USING #DimSupplier AS s ON t.[SupplierICO] = s.[SupplierICO]
WHEN NOT MATCHED BY TARGET THEN
	INSERT
	(
		[SupplierICO]
		,[SupplierIsJIP]
		,[SupplierDeleted]
	)
	VALUES
	(
		s.[SupplierICO]
		,s.[SupplierIsJIP]
		,0
	)

WHEN MATCHED THEN
	UPDATE SET
		t.[SupplierICO] = s.[SupplierICO]
		,t.[SupplierIsJIP] = s.[SupplierIsJIP]
		,t.[SupplierDeleted] = 0

WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET
		t.SupplierDeleted = 1
;

DROP TABLE IF EXISTS #DimSupplier

RETURN 0

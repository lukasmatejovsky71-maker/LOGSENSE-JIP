CREATE VIEW [dbo].[v_DimDate]
AS
SELECT d.[DateId]
	,d.[DateDate]
	,d.[DateCalendarYear]
	,d.[DateCalendarYearWeekName]
	,d.[DateCalendarYearMonthName]
	,d.[DateMonthNumberOfYear]
	,d.[DateCzechDayNameOfWeek]
	,d.[DateDayNumberOfWeek]
	,d.[DateCzechMonthName]
FROM [dbo].[DimDate] d
WHERE [DateCalendarYear] IN (
		SELECT d.[DateCalendarYear]
		FROM [dbo].[FactMaterialMovement] m
		INNER JOIN [dbo].[DimDate] d ON m.[MaterialMovement_DateId] = d.[DateId]
		)
	OR (
		[DateCalendarYear] IN (
			SELECT d.[DateCalendarYear]
			FROM [dbo].[FactMaterialSale] m
			INNER JOIN [dbo].[DimDate] d ON m.[MaterialSale_DateId] = d.[DateId]
			)
		)

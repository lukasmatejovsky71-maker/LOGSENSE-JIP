CREATE VIEW [dbo].[v_DimDate]
AS 
SELECT
d.[DateId]
,d.[DateDate]
,d.[DateCalendarYear]
,d.[DateCalendarYearWeekName]
,d.[DateCalendarYearMonthName]
,YEAR(d.[DateDate]) * 100 + MONTH(d.[DateDate]) AS [DateCalendarYearMonthSortOrder]
,d.[DateMonthNumberOfYear]
, CASE
	WHEN CAST(d.[DateDate] AS date) = CAST(GETDATE() AS date) THEN N'Today'
	ELSE FORMAT(d.[DateDate], 'dd.MM.yyyy')
  END AS [DateWithToday]
FROM [dbo].[DimDate] d

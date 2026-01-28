CREATE PROCEDURE [dbo].[p_LoadDimDate]
@DateFrom DATETIME = N'2000-01-01'
,@DateTo DATETIME = N'2050-12-31'
,@DateFirst INT = 1
,@LocaleCode NVARCHAR(5) = 'cs-CZ'
,@UpdateExisting BIT = 0

AS
BEGIN

SET DATEFIRST @DateFirst

DROP TABLE IF EXISTS #Date 

SELECT TOP 0
     [DateId]
    ,[DateDate]
    ,[DateDayNumberOfWeek]
    ,[DateCalendarYearWeekName]
    ,[DateCalendarYearWeekId]
    ,[DateEnglishDayNameOfWeek]
    ,[DateCzechDayNameOfWeek]
    ,[DateGermanDayNameOfWeek]
    ,[DateDayNumberOfMonth]
    ,[DateMonthNumberOfYear]
    ,[DateCalendarYearMonthId]
    ,[DateCalendarYearMonthName]
    ,[DateEnglishMonthName]
    ,[DateCzechMonthName]
    ,[DateGermanMonthName]
    ,[DateCalendarYear]
    ,[DateIsHoliday]
    ,[DateIsWorkingDay]
INTO #Date
FROM [dbo].[DimDate]

CREATE INDEX [#IX_Date] ON #Date ([DateDate])


;
WITH Dates AS
(
    SELECT @DateFrom [DateDate]
    UNION ALL
    SELECT DATEADD(day, 1, [DateDate]) [DateDate]
    FROM Dates
    WHERE [DateDate] < @DateTo

)
INSERT INTO #Date
(
     [DateId]
    ,[DateDate]
    ,[DateDayNumberOfWeek]
    ,[DateCalendarYearWeekName]
    ,[DateCalendarYearWeekId]
    ,[DateEnglishDayNameOfWeek]
    ,[DateCzechDayNameOfWeek]
    ,[DateGermanDayNameOfWeek]
    ,[DateDayNumberOfMonth]
    ,[DateMonthNumberOfYear]
    ,[DateCalendarYearMonthId]
    ,[DateCalendarYearMonthName]
    ,[DateEnglishMonthName]
    ,[DateCzechMonthName]
    ,[DateGermanMonthName]
    ,[DateCalendarYear]
    ,[DateIsHoliday]
    ,[DateIsWorkingDay]
)
SELECT 
   CONVERT(int, CONVERT(NCHAR(8), d.[DateDate], 112)) AS [DateId]
  ,d.[DateDate]
  ,DATEPART(weekday, d.[DateDate]) AS [DateDayNumberOfWeek]
  ,FORMAT(IIF(
    DATEPART(ISO_WEEK, d.[DateDate]) >51 AND DATEPART(MONTH, d.[DateDate]) = 1
    , -1
    , 0)
    + DATEPART(YEAR, d.[DateDate]), '0000') 
    + '/'
    + FORMAT( DATEPART(ISO_WEEK, d.[DateDate]), '00')
    AS [DateCalendarYearWeekName]
  ,IIF(
    DATEPART(ISO_WEEK, d.[DateDate]) >51 AND DATEPART(MONTH, d.[DateDate]) = 1
    , -100
    , 0)
    + DATEPART(YEAR, d.[DateDate]) * 100 
    + DATEPART(ISO_WEEK, d.[DateDate]) 
    AS [DateCalendarYearWeekId]
  ,FORMAT(d.[DateDate], 'dddd', 'en-US') AS [DateEnglishDayNameOfWeek]
  ,FORMAT(d.[DateDate], 'dddd', 'cs-CZ') AS [DateCzechDayNameOfWeek]
  ,FORMAT(d.[DateDate], 'dddd', 'de-DE') AS [DateGermanDayNameOfWeek]
  ,DATEPART(DAY, d.[DateDate]) AS [DateDayNumberOfMonth]
  ,DATEPART(MONTH, d.[DateDate]) AS [DateMonthNumberOfYear]
  ,DATEPART(YEAR, d.[DateDate]) * 100 + DATEPART(MONTH, d.[DateDate]) AS [DateCalendarYearMonthId]
  ,FORMAT(d.[DateDate], 'yyyy/MM') AS [DateCalendarYearMonthName]
  ,FORMAT(d.[DateDate], 'MMMM', 'en-US') AS [DateEnglishMonthName]
  ,FORMAT(d.[DateDate], 'MMMM', 'cs-CZ') AS [DateCzechMonthName]
  ,FORMAT(d.[DateDate], 'MMMM', 'de-DE') AS [DateGermanMonthName]
  ,DATEPART(year, d.[DateDate]) AS [DateCalendarYear]
  ,IIF(NULL IS NULL, 0, 1) AS [DateIsHoliday]
  ,IIF( FORMAT(d.[DateDate], 'ddd', 'en-US') IN ('Sat','Sun'), 0, 1) AS [DateIsWorkingDay]
FROM Dates AS d
LEFT JOIN [dbo].[DimDate] AS dd
  ON d.[DateDate] = dd.[DateDate]
WHERE dd.[DateId] IS NULL OR @UpdateExisting = 1
OPTION (MAXRECURSION 32767)

;
MERGE [dbo].[DimDate] t
USING #Date s ON t.[DateDate] = s.[DateDate]

WHEN MATCHED AND @UpdateExisting = 1 THEN
UPDATE
SET
     t.[DateDate]=s.[DateDate]
    ,t.[DateDayNumberOfWeek]=s.[DateDayNumberOfWeek]
    ,t.[DateCalendarYearWeekName]=s.[DateCalendarYearWeekName]
    ,t.[DateCalendarYearWeekId]=s.[DateCalendarYearWeekId]
    ,t.[DateEnglishDayNameOfWeek]=s.[DateEnglishDayNameOfWeek]
    ,t.[DateCzechDayNameOfWeek]=s.[DateCzechDayNameOfWeek]
    ,t.[DateGermanDayNameOfWeek]=s.[DateGermanDayNameOfWeek]
    ,t.[DateMonthNumberOfYear]=s.[DateMonthNumberOfYear]
    ,t.[DateCalendarYearMonthId]=s.[DateCalendarYearMonthId]
    ,t.[DateCalendarYearMonthName]=s.[DateCalendarYearMonthName]
    ,t.[DateEnglishMonthName]=s.[DateEnglishMonthName]
    ,t.[DateCzechMonthName]=s.[DateCzechMonthName]
    ,t.[DateGermanMonthName]=s.[DateGermanMonthName]
    ,t.[DateCalendarYear]=s.[DateCalendarYear]
    ,t.[DateIsHoliday]=s.[DateIsHoliday]
    ,t.[DateIsWorkingDay]=s.[DateIsWorkingDay]

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
     [DateId]
    ,[DateDate]
    ,[DateDayNumberOfWeek]
    ,[DateCalendarYearWeekName]
    ,[DateCalendarYearWeekId]
    ,[DateEnglishDayNameOfWeek]
    ,[DateCzechDayNameOfWeek]
    ,[DateGermanDayNameOfWeek]
    ,[DateDayNumberOfMonth]
    ,[DateMonthNumberOfYear]
    ,[DateCalendarYearMonthId]
    ,[DateCalendarYearMonthName]
    ,[DateEnglishMonthName]
    ,[DateCzechMonthName]
    ,[DateGermanMonthName]
    ,[DateCalendarYear]
    ,[DateIsHoliday]
    ,[DateIsWorkingDay]
)
VALUES
(
     s.[DateId]
    ,s.[DateDate]
    ,s.[DateDayNumberOfWeek]
    ,s.[DateCalendarYearWeekName]
    ,s.[DateCalendarYearWeekId]
    ,s.[DateEnglishDayNameOfWeek]
    ,s.[DateCzechDayNameOfWeek]
    ,s.[DateGermanDayNameOfWeek]
    ,s.[DateDayNumberOfMonth]
    ,s.[DateMonthNumberOfYear]
    ,s.[DateCalendarYearMonthId]
    ,s.[DateCalendarYearMonthName]
    ,s.[DateEnglishMonthName]
    ,s.[DateCzechMonthName]
    ,s.[DateGermanMonthName]
    ,s.[DateCalendarYear]
    ,s.[DateIsHoliday]
    ,s.[DateIsWorkingDay]
)
;

DROP TABLE #Date

RETURN
END
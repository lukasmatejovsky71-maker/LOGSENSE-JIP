CREATE TABLE [dbo].[DimDate] (
    [DateId]                          INT           NOT NULL,
    [DateDate]                        DATETIME      NULL,
    [DateDayNumberOfWeek]             INT           NULL,
    [DateCalendarYearWeekName]        NVARCHAR(10)  NOT NULL,
    [DateCalendarYearWeekId]          INT           NOT NULL,
    [DateEnglishDayNameOfWeek]        NVARCHAR (30) NULL,
    [DateCzechDayNameOfWeek]          NVARCHAR (10) NULL,
    [DateGermanDayNameOfWeek]         NVARCHAR (10) NULL,
    [DateDayNumberOfMonth]            INT           NULL,
    [DateMonthNumberOfYear]           INT           NULL,
    [DateCalendarYearMonthId]         INT           NULL,
    [DateCalendarYearMonthName]       NVARCHAR (7)  NULL,
    [DateEnglishMonthName]            NVARCHAR (10) NULL,
    [DateCzechMonthName]              NVARCHAR (10) NULL,
    [DateGermanMonthName]             NVARCHAR (10) NULL,
    [DateCalendarYear]                INT           NULL,
    [DateIsHoliday]                   BIT           NOT NULL CONSTRAINT [DF_Date_DateIsHoliday] DEFAULT (0),
    [DateIsWorkingDay]                BIT           NOT NULL CONSTRAINT [DF_Date_DateIsWorkingDay] DEFAULT (0),
    [DateHolidays]                    AS            (CONVERT([int],[DateIsHoliday])),
    [DateWorkingDays]                 AS            (CONVERT([int],[DateIsWorkingDay])),
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateId] ASC)
);
GO

CREATE UNIQUE INDEX [QU_DimDate_BusinessKey]
ON [dbo].[DimDate]
([DateDate] ASC)
GO

/*
GO
CREATE NONCLUSTERED INDEX [IX_DimDate_DateIsActualDay]
    ON [dbo].[DimDate]([DateIsActualDay] ASC);
*/

GO
CREATE NONCLUSTERED INDEX [IX_DimDate_DateCalendarYear]
    ON [dbo].[DimDate]([DateCalendarYear] ASC)
    INCLUDE([DateId], [DateDate]);
GO

/*
CREATE NONCLUSTERED INDEX [IX_DimDate_DateIsActualWeek]
    ON [dbo].[DimDate]([DateIsActualWeek] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_DimDate_DateIsActualMonth]
    ON [dbo].[DimDate]([DateIsActualMonth] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_DimDate_DateIsActualQuarter]
    ON [dbo].[DimDate]([DateIsActualQuarter] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_DimDate_DateIsActualYear]
    ON [dbo].[DimDate]([DateIsActualYear] ASC);
GO
*/

/*
CREATE NONCLUSTERED INDEX [IX_DimDate_CalendarYearWeekDate]
    ON [dbo].[DimDate]([DateCalendarYear] ASC, [DateMonthNumberOfYear] ASC, [DateWeekNumberOfYear] ASC, [DateDayNumberOfWeek] ASC);
GO
*/

CREATE NONCLUSTERED INDEX [IX_DimDate_CalendarYearMonthDate]
    ON [dbo].[DimDate]([DateCalendarYear] ASC, [DateMonthNumberOfYear] ASC, [DateDayNumberOfMonth] ASC);
GO

/*
CREATE NONCLUSTERED INDEX [IX_DimDate_DateFiscalYear]
    ON [dbo].[DimDate]([DateFiscalYear] ASC);
*/

GO

CREATE NONCLUSTERED INDEX [IX_DimDate_DateDate]
    ON [dbo].[DimDate]([DateDate] ASC);


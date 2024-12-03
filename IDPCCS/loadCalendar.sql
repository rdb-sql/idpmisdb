Use [IDPCCS]

CREATE TABLE [dbo].[CCS_Calendar](
	[Id] [int] identity(1,1),
	[SqnDate] [datetime],
	[IsCurrentDate] [bit] default (0),
	[SqnDay] [int],
	[SqnDayName] [nvarchar] (30),
	[SqnWeek] [int],
	[SqnISOWeek] [int],
	[SqnDayOfWeek] [int],
	[SqnMonth] [int],
	[SqnMonthName] [nvarchar] (30),
	[SqnQuarter] [int],
	[SqnYear] [int],
	[SqnFirstOfMonth] [datetime],
	[SqnLastOfYear] [datetime],
	[SqnDayOfYear] [int]
)

DECLARE @StartDate  date = '20230101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
)
--
Insert Into dbo.CCS_Calendar (SqnDate,SqnDay,SqnDayName,SqnWeek,SqnISOWeek,SqnDayOfWeek,SqnMonth,SqnMonthName,SqnQuarter,SqnYear,SqnFirstOfMonth,SqnLastOfYear,SqnDayOfYear)
SELECT * FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);

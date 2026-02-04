CREATE TABLE [adm].[MeasureSelection]
(
	[MeasureSelectionId] INT NOT NULL CONSTRAINT [PK_adm_MeasureSelection] PRIMARY KEY IDENTITY(1,1),
	[MeasureSelectionName] NVARCHAR (50) NOT NULL,
	[MeasureSelectionIndex] INT NOT NULL
)

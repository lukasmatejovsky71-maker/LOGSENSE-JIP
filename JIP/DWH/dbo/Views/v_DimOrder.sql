CREATE VIEW [dbo].[v_DimOrder]
AS
SELECT [OrderId]
	,[OrderNumber]
	,[OrderSpeculation]
	,[OrderDeleted]
FROM [DimOrder]

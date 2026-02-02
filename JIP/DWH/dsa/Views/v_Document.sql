CREATE VIEW [dsa].[v_Document]
AS
SELECT DISTINCT [Číslo dokladu]
FROM [dsa].[v_MaterialMovementReceipt]
WHERE [Číslo dokladu] IS NOT NULL

UNION

SELECT DISTINCT [Číslo dokladu]
FROM [dsa].[MaterialMovementSalesData]
WHERE [Číslo dokladu] IS NOT NULL

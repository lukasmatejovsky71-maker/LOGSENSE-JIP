CREATE TABLE [dsa].[MaterialMovementSalesData] (
    [Divize]           NVARCHAR (255) NULL,
    [Pobočka]          NVARCHAR (255) NULL,
    [IČO]              NVARCHAR (255) NULL,
    [Obrat v MJ]       FLOAT (53)     NULL,
    [Obrat v paletách] FLOAT (53)     NULL,
    [Den]              NVARCHAR (255) NULL,
    [Číslo dokladu]    NVARCHAR (255) NULL,
    [Produkt - Kód]    NVARCHAR (255) NULL
);

GO;
CREATE NONCLUSTERED INDEX [IX_dsa_MaterialMovementSalesData_Číslo dokladu]
ON [dsa].[MaterialMovementSalesData] ([Číslo dokladu])

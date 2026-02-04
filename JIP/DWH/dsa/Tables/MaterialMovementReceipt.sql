CREATE TABLE [dsa].[MaterialMovementReceipt]
(
    [Divize] nvarchar(255),
    [Pobočka] nvarchar(255),
    [Den] nvarchar(255),
    [IČO] nvarchar(255),
    [Číslo dokladu] nvarchar(255),
    [Produkt - Kód] nvarchar(255),
    [Obrat v MJ] float,
    [Obrat v paletách] float
);

GO
CREATE INDEX IX_dsa_MaterialMovementReceipt_Produkt_kod ON [dsa].[MaterialMovementReceipt]([Produkt - kód])

GO
CREATE INDEX IX_dsa_MaterialMovementReceipt_Divize ON [dsa].[MaterialMovementReceipt]([Divize])

GO;
CREATE NONCLUSTERED INDEX [IX_dsa_MaterialMovementrReceipt_Číslo dokladu]
ON [dsa].[MaterialMovementReceipt] ([Číslo dokladu])

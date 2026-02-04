CREATE TABLE [dsa].[Product] (
    [Kód]                  NVARCHAR (255) NULL,
    [druh karty]           NVARCHAR (255) NULL,
    [Název]                NVARCHAR (255) NULL,
    [Dodavatel]            NVARCHAR (255) NULL,
    [Dodavatel-popis]      NVARCHAR (255) NULL,
    [MJ v balení]          FLOAT (53)     NULL,
    [MJ na paletě]         FLOAT (53)     NULL,
    [Hmotnost v kg]        FLOAT (53)     NULL,
    [Rozměry ks (mm)]      NVARCHAR (255) NULL,
    [Rozměry karton (mm)]  NVARCHAR (255) NULL,
    [Rozměry display (mm)] NVARCHAR (255) NULL,
    [Teplotní režim]       NVARCHAR (255) NULL,
    [Skupina2]             NVARCHAR (255) NULL,
    [Skupina2-popis]       NVARCHAR (255) NULL,
    [Nadř#skup#2]          NVARCHAR (255) NULL,
    [Nadř#skup#2 pop#]     NVARCHAR (255) NULL,
    [Záruka]               FLOAT (53)     NULL,
    [Skladová cena]        FLOAT (53)     NULL,
    [Min# obj# bal#]       FLOAT (53)     NULL,
    [Jednotka MJ]          NVARCHAR (255) NULL
);


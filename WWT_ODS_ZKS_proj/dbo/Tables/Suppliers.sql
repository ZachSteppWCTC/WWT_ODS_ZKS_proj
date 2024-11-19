CREATE TABLE [dbo].[Suppliers] (
    [ODSSupplierID]   INT           IDENTITY (1, 1) NOT NULL,
    [SourceID]        INT           NOT NULL,
    [orig_SupplierID] INT           NOT NULL,
    [CompanyName]     VARCHAR (40)  NOT NULL,
    [ContactName]     VARCHAR (30)  NULL,
    [ContactTitle]    VARCHAR (30)  NULL,
    [Website]         VARCHAR (256) NULL,
    [Phone]           VARCHAR (24)  NULL,
    [Fax]             VARCHAR (24)  NULL,
    [ODSAddressID]    INT           NULL,
    PRIMARY KEY CLUSTERED ([ODSSupplierID] ASC),
    CONSTRAINT [FK_Suppliers.ODSAddressID] FOREIGN KEY ([ODSAddressID]) REFERENCES [dbo].[Address] ([ODSAddressID]),
    CONSTRAINT [FK_Suppliers.SourceID] FOREIGN KEY ([SourceID]) REFERENCES [dbo].[SourceTrader] ([SourceID])
);


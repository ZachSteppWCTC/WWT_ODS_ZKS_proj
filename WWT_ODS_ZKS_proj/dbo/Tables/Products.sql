CREATE TABLE [dbo].[Products] (
    [ODSProductID]    INT           IDENTITY (1, 1) NOT NULL,
    [SourceID]        INT           NOT NULL,
    [orig_ProductID]  INT           NOT NULL,
    [ProductName]     VARCHAR (100) NULL,
    [ODSSupplierId]   INT           NULL,
    [QuantityPerUnit] VARCHAR (20)  NULL,
    [Cost]            MONEY         NULL,
    [RetailPrice]     MONEY         NULL,
    [ODSCategoryId]   INT           NOT NULL,
    [UnitsInStock]    SMALLINT      NULL,
    [ReorderLevel]    SMALLINT      NULL,
    [Discontinued]    BIT           NOT NULL,
    [UnitsOnOrder]    SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([ODSProductID] ASC),
    CONSTRAINT [FK_Products.ODSCategoryId] FOREIGN KEY ([ODSCategoryId]) REFERENCES [dbo].[Category] ([ODSCategoryId]),
    CONSTRAINT [FK_Products.ODSSupplierId] FOREIGN KEY ([ODSSupplierId]) REFERENCES [dbo].[Suppliers] ([ODSSupplierID]),
    CONSTRAINT [FK_Products.SourceID] FOREIGN KEY ([SourceID]) REFERENCES [dbo].[SourceTrader] ([SourceID])
);


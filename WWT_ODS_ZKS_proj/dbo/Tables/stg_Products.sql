CREATE TABLE [dbo].[stg_Products] (
    [ProductID]       INT           NULL,
    [ProductName]     VARCHAR (100) NULL,
    [SupplierID]      INT           NULL,
    [CategoryID]      INT           NULL,
    [QuantityPerUnit] VARCHAR (20)  NULL,
    [UnitPrice]       MONEY         NULL,
    [WholesalePrice]  MONEY         NULL,
    [UnitsInStock]    SMALLINT      NULL,
    [UnitsOnOrder]    SMALLINT      NULL,
    [ReorderLevel]    SMALLINT      NULL,
    [Discontinued]    BIT           NULL,
    [SourceID]        INT           NULL
);


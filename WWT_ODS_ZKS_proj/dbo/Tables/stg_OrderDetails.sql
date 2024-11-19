CREATE TABLE [dbo].[stg_OrderDetails] (
    [OrderID]   INT            NULL,
    [ProductID] INT            NULL,
    [UnitPrice] MONEY          NULL,
    [Quantity]  SMALLINT       NULL,
    [Discount]  NUMERIC (3, 2) NULL,
    [SourceID]  INT            NULL
);


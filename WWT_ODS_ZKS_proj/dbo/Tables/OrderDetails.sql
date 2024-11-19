CREATE TABLE [dbo].[OrderDetails] (
    [ODSOrderID]   INT            NOT NULL,
    [ODSProductID] INT            NOT NULL,
    [UnitPrice]    MONEY          NULL,
    [Quantity]     SMALLINT       NOT NULL,
    [Discount]     DECIMAL (3, 2) NULL,
    PRIMARY KEY CLUSTERED ([ODSOrderID] ASC, [ODSProductID] ASC),
    CONSTRAINT [FK_OrderDetails.ODSOrderID] FOREIGN KEY ([ODSOrderID]) REFERENCES [dbo].[Orders] ([ODSOrderID]),
    CONSTRAINT [FK_OrderDetails.ODSProductID] FOREIGN KEY ([ODSProductID]) REFERENCES [dbo].[Products] ([ODSProductID])
);


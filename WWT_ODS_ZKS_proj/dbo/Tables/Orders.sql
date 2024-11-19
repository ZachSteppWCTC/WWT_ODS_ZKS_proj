CREATE TABLE [dbo].[Orders] (
    [ODSOrderID]        INT          IDENTITY (1, 1) NOT NULL,
    [SourceID]          INT          NOT NULL,
    [orig_OrderID]      INT          NOT NULL,
    [ODSCustomerID]     INT          NOT NULL,
    [ODSEmployeeID]     INT          NULL,
    [OrderDate]         DATETIME     NOT NULL,
    [RequiredDate]      DATETIME     NULL,
    [ShippedDate]       DATETIME     NULL,
    [ShipVia]           INT          NULL,
    [Freight]           MONEY        NULL,
    [ShipName]          VARCHAR (40) NULL,
    [DeliveryAddressID] INT          NULL,
    PRIMARY KEY CLUSTERED ([ODSOrderID] ASC),
    CONSTRAINT [FK_Orders.DeliveryAddressID] FOREIGN KEY ([DeliveryAddressID]) REFERENCES [dbo].[Address] ([ODSAddressID]),
    CONSTRAINT [FK_Orders.ODSCustomerID] FOREIGN KEY ([ODSCustomerID]) REFERENCES [dbo].[Customers] ([ODSCustomerID]),
    CONSTRAINT [FK_Orders.ODSEmployeeID] FOREIGN KEY ([ODSEmployeeID]) REFERENCES [dbo].[Employees] ([ODSEmployeeID]),
    CONSTRAINT [FK_Orders.ShipVia] FOREIGN KEY ([ShipVia]) REFERENCES [dbo].[Shippers] ([ODSShipperID]),
    CONSTRAINT [FK_Orders.SourceID] FOREIGN KEY ([SourceID]) REFERENCES [dbo].[SourceTrader] ([SourceID])
);


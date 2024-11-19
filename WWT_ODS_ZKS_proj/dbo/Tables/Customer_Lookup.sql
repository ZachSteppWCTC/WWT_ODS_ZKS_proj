CREATE TABLE [dbo].[Customer_Lookup] (
    [ODSCustomerID]     INT         NOT NULL,
    [SourceID]          INT         NOT NULL,
    [source_CustomerID] VARCHAR (5) NOT NULL,
    PRIMARY KEY CLUSTERED ([ODSCustomerID] ASC, [SourceID] ASC),
    CONSTRAINT [FK_Customer_Lookup.ODSCustomerID] FOREIGN KEY ([ODSCustomerID]) REFERENCES [dbo].[Customers] ([ODSCustomerID]),
    CONSTRAINT [FK_Customer_Lookup.SourceID] FOREIGN KEY ([SourceID]) REFERENCES [dbo].[SourceTrader] ([SourceID])
);


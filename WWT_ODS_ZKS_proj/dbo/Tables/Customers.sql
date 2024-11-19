CREATE TABLE [dbo].[Customers] (
    [ODSCustomerID]    INT           IDENTITY (1, 1) NOT NULL,
    [CustomerName]     VARCHAR (100) NOT NULL,
    [ContactName]      VARCHAR (30)  NULL,
    [ContactTitle]     VARCHAR (30)  NULL,
    [Phone]            VARCHAR (24)  NULL,
    [Fax]              VARCHAR (24)  NULL,
    [BillingAddressID] INT           NULL,
    PRIMARY KEY CLUSTERED ([ODSCustomerID] ASC),
    CONSTRAINT [FK_Customers.BillingAddressID] FOREIGN KEY ([BillingAddressID]) REFERENCES [dbo].[Address] ([ODSAddressID])
);


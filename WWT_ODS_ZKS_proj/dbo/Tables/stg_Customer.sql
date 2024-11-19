CREATE TABLE [dbo].[stg_Customer] (
    [CustomerID]        VARCHAR (5)   NULL,
    [CompanyName]       VARCHAR (100) NULL,
    [ContactName]       VARCHAR (30)  NULL,
    [ContactTitle]      VARCHAR (30)  NULL,
    [Address]           VARCHAR (60)  NULL,
    [City]              VARCHAR (50)  NULL,
    [Region]            VARCHAR (15)  NULL,
    [PostalCode]        VARCHAR (50)  NULL,
    [Country]           VARCHAR (50)  NULL,
    [Phone]             VARCHAR (50)  NULL,
    [Fax]               VARCHAR (24)  NULL,
    [SourceID]          INT           NULL,
    [BillingAddressID]  INT           NULL,
    [DeliveryAddressID] INT           NULL,
    [Address2]          VARCHAR (60)  NULL
);


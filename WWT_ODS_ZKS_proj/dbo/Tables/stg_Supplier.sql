CREATE TABLE [dbo].[stg_Supplier] (
    [SupplierID]    INT           NULL,
    [CompanyName]   VARCHAR (100) NULL,
    [ContactName]   VARCHAR (50)  NULL,
    [ContactTitle]  VARCHAR (30)  NULL,
    [Address]       VARCHAR (60)  NULL,
    [City]          VARCHAR (50)  NULL,
    [StateOrRegion] VARCHAR (15)  NULL,
    [PostalCode]    VARCHAR (50)  NULL,
    [Country]       VARCHAR (50)  NULL,
    [Phone]         VARCHAR (50)  NULL,
    [Fax]           VARCHAR (24)  NULL,
    [Website]       VARCHAR (256) NULL,
    [SourceID]      INT           NULL,
    [AddressID]     INT           NULL,
    [Address2]      VARCHAR (60)  NULL
);


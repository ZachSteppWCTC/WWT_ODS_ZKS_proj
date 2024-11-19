CREATE TABLE [dbo].[Shippers] (
    [ODSShipperID]    INT          IDENTITY (1, 1) NOT NULL,
    [SourceID]        INT          NOT NULL,
    [orig_ShippersID] INT          NOT NULL,
    [CompanyName]     VARCHAR (40) NOT NULL,
    [Phone]           VARCHAR (24) NULL,
    PRIMARY KEY CLUSTERED ([ODSShipperID] ASC)
);


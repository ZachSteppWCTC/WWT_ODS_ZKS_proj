CREATE TABLE [dbo].[stg_Orders] (
    [OrderID]           INT          NULL,
    [CustomerID]        VARCHAR (5)  NULL,
    [EmployeeID]        INT          NULL,
    [OrderDate]         DATETIME     NULL,
    [RequiredDate]      DATETIME     NULL,
    [ShippedDate]       DATETIME     NULL,
    [ShipVia]           INT          NULL,
    [Freight]           MONEY        NULL,
    [ShipName]          VARCHAR (40) NULL,
    [ShipAddress]       VARCHAR (60) NULL,
    [ShipCity]          VARCHAR (50) NULL,
    [ShipStateOrRegion] VARCHAR (15) NULL,
    [ShipPostalCode]    VARCHAR (50) NULL,
    [ShipCountry]       VARCHAR (50) NULL,
    [SourceID]          INT          NULL,
    [ShipAddress2]      VARCHAR (60) NULL
);


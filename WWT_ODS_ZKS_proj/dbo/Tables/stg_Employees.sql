CREATE TABLE [dbo].[stg_Employees] (
    [EmployeeID]      INT           NULL,
    [LastName]        VARCHAR (20)  NULL,
    [FirstName]       VARCHAR (10)  NULL,
    [JobTitle]        VARCHAR (30)  NULL,
    [Title]           VARCHAR (25)  NULL,
    [BirthDate]       DATE          NULL,
    [HireDate]        DATE          NULL,
    [TerminationDate] DATE          NULL,
    [Address]         VARCHAR (60)  NULL,
    [City]            VARCHAR (15)  NULL,
    [StateOrRegion]   VARCHAR (15)  NULL,
    [PostalCode]      VARCHAR (10)  NULL,
    [Country]         VARCHAR (15)  NULL,
    [HomePhone]       VARCHAR (24)  NULL,
    [Extension]       VARCHAR (4)   NULL,
    [EmailAddress]    VARCHAR (100) NULL,
    [Notes]           VARCHAR (MAX) NULL,
    [ReportsTo]       INT           NULL,
    [SourceID]        INT           NULL,
    [IsActive]        BIT           NULL,
    [Address2]        VARCHAR (60)  NULL
);


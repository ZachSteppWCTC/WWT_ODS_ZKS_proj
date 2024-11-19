CREATE TABLE [dbo].[Category] (
    [ODSCategoryId] INT            IDENTITY (1, 1) NOT NULL,
    [Category]      VARCHAR (30)   NOT NULL,
    [Description]   VARCHAR (1028) NULL,
    PRIMARY KEY CLUSTERED ([ODSCategoryId] ASC)
);


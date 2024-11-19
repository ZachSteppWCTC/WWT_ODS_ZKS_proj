CREATE TABLE [dbo].[SourceTrader] (
    [SourceID]   INT          IDENTITY (1, 1) NOT NULL,
    [TraderName] VARCHAR (40) NOT NULL,
    PRIMARY KEY CLUSTERED ([SourceID] ASC)
);


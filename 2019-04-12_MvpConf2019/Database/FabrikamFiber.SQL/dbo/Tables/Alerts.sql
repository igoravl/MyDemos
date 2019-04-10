CREATE TABLE [dbo].[Alerts] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [Created]     DATETIME       NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Alerts] PRIMARY KEY CLUSTERED ([ID] ASC)
);


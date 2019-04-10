CREATE TABLE [dbo].[ServiceLogEntries] (
    [ID]              INT            IDENTITY (1, 1) NOT NULL,
    [CreatedAt]       DATETIME       NOT NULL,
    [Description]     NVARCHAR (MAX) NULL,
    [CreatedByID]     INT            NULL,
    [ServiceTicketID] INT            NOT NULL,
    CONSTRAINT [PK_dbo.ServiceLogEntries] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_dbo.ServiceLogEntries_dbo.Employees_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [dbo].[Employees] ([ID]),
    CONSTRAINT [FK_dbo.ServiceLogEntries_dbo.ServiceTickets_ServiceTicketID] FOREIGN KEY ([ServiceTicketID]) REFERENCES [dbo].[ServiceTickets] ([ID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_CreatedByID]
    ON [dbo].[ServiceLogEntries]([CreatedByID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ServiceTicketID]
    ON [dbo].[ServiceLogEntries]([ServiceTicketID] ASC);


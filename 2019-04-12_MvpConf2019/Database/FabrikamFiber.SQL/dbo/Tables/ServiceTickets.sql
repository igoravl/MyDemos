CREATE TABLE [dbo].[ServiceTickets] (
    [ID]              INT            IDENTITY (1, 1) NOT NULL,
    [Title]           NVARCHAR (MAX) NOT NULL,
    [Description]     NVARCHAR (MAX) NULL,
    [Status]          INT            NOT NULL,
    [StatusValue]     INT            NOT NULL,
    [EscalationLevel] INT            NOT NULL,
    [Opened]          DATETIME       NULL,
    [Closed]          DATETIME       NULL,
    [CustomerID]      INT            NULL,
    [CreatedByID]     INT            NULL,
    [AssignedToID]    INT            NULL,
    CONSTRAINT [PK_dbo.ServiceTickets] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_dbo.ServiceTickets_dbo.Customers_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([ID]),
    CONSTRAINT [FK_dbo.ServiceTickets_dbo.Employees_AssignedToID] FOREIGN KEY ([AssignedToID]) REFERENCES [dbo].[Employees] ([ID]),
    CONSTRAINT [FK_dbo.ServiceTickets_dbo.Employees_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [dbo].[Employees] ([ID])
);


GO
CREATE NONCLUSTERED INDEX [IX_CustomerID]
    ON [dbo].[ServiceTickets]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CreatedByID]
    ON [dbo].[ServiceTickets]([CreatedByID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AssignedToID]
    ON [dbo].[ServiceTickets]([AssignedToID] ASC);


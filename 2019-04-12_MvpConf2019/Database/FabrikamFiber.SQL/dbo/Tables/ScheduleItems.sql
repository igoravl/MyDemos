CREATE TABLE [dbo].[ScheduleItems] (
    [ID]              INT      IDENTITY (1, 1) NOT NULL,
    [EmployeeID]      INT      NOT NULL,
    [ServiceTicketID] INT      NOT NULL,
    [Start]           DATETIME NOT NULL,
    [WorkHours]       INT      NOT NULL,
    [AssignedOn]      DATETIME NULL,
    CONSTRAINT [PK_dbo.ScheduleItems] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_dbo.ScheduleItems_dbo.Employees_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.ScheduleItems_dbo.ServiceTickets_ServiceTicketID] FOREIGN KEY ([ServiceTicketID]) REFERENCES [dbo].[ServiceTickets] ([ID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_EmployeeID]
    ON [dbo].[ScheduleItems]([EmployeeID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ServiceTicketID]
    ON [dbo].[ScheduleItems]([ServiceTicketID] ASC);


CREATE TABLE [dbo].[Customers] (
    [ID]             INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]      NVARCHAR (MAX) NULL,
    [LastName]       NVARCHAR (MAX) NULL,
    [Address_Street] NVARCHAR (MAX) NULL,
    [Address_City]   NVARCHAR (MAX) NULL,
    [Address_State]  NVARCHAR (MAX) NULL,
    [Address_Zip]    NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Customers] PRIMARY KEY CLUSTERED ([ID] ASC)
);


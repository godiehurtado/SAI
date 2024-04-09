CREATE TABLE [dbo].[BatchLog] (
    [BatchLogID]    INT      IDENTITY (1, 1) NOT NULL,
    [StartDateTime] DATETIME DEFAULT (getdate()) NOT NULL,
    [EndDateTime]   DATETIME NULL,
    [Status]        CHAR (1) NOT NULL
);


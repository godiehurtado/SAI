CREATE TABLE [dbo].[PackageLog] (
    [PackageLogID]        INT              IDENTITY (1, 1) NOT NULL,
    [BatchLogID]          INT              NOT NULL,
    [PackageVersionID]    INT              NOT NULL,
    [ExecutionInstanceID] UNIQUEIDENTIFIER NOT NULL,
    [MachineName]         VARCHAR (64)     NOT NULL,
    [UserName]            VARCHAR (64)     NOT NULL,
    [StartDateTime]       DATETIME         DEFAULT (getdate()) NOT NULL,
    [EndDateTime]         DATETIME         NULL,
    [Status]              CHAR (1)         NOT NULL
);

